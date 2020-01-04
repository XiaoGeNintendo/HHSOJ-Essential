package com.hhs.xgn.hhsoj.essential.judge;

import java.io.DataInputStream;
import java.io.DataOutputStream;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.io.PrintWriter;
import java.lang.reflect.Type;
import java.net.Socket;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.Map;
import java.util.concurrent.TimeUnit;

import com.google.gson.Gson;
import com.google.gson.reflect.TypeToken;
import com.hhs.xgn.hhsoj.essential.common.CommonUtil;
import com.hhs.xgn.hhsoj.essential.common.Language;
import com.hhs.xgn.hhsoj.essential.common.Problem;
import com.hhs.xgn.hhsoj.essential.common.Submission;
import com.hhs.xgn.hhsoj.essential.common.TestResult;
import com.hhs.xgn.hhsoj.essential.common.TestsetResult;

public class JudgeServer {

	public static void main(String[] args) {
		JudgeServer js=new JudgeServer();
		js.solve(args);
	}
	
	String ip;
	int port;
	String name;
	
	DataInputStream dis;
	DataOutputStream dos;
	
	HashMap<String,Language> langs=new HashMap<>();
	

	Gson gs=new Gson();
	
	public void downloadData(String set,String id){
		
	}
	
	void remove(File data){
		if(data.isDirectory()){
			for(File x:data.listFiles()){
				remove(x);
			}
		}else{
			data.delete();
		}
	}
	
	void downloadData(File data,String path) throws Exception{
		//first remove everything
		System.out.println("Removing...");
		remove(data);
		data.mkdirs();
		
		System.out.println("Read files");
		while(true){
			String name=dis.readUTF();
			
			if(name.equals("$$END")){
				break;
			}
			if(name.startsWith("!")){
				System.out.println("Read folder:"+name);
				new File(path+"/"+name.substring(1)).mkdirs();
				continue;
			}
			
			PrintWriter pw=new PrintWriter(path+"/"+name);
			int bytes=0;
			
			while(true){
				int c=dis.readInt();
				if(c==-1){
					break;
				}
				bytes++;
				pw.append((char)c);
			}
			pw.close();
			
			System.out.println("Read "+bytes+" bytes from "+name);
		}
		System.out.println("Read done");
	}
	
	/**
	 * Returns true if answer is AC, false otherwise
	 * @param sub
	 * @param in
	 * @param set
	 * @return
	 * @throws Exception 
	 */
	boolean runSingleTest(Submission sub,int id,File set,Problem pr) {

		String sn=set.getName();
		
		try{
			File in=new File(set.getAbsoluteFile()+"/test"+id+".in");
			File out=new File(set.getAbsoluteFile()+"/test"+id+".out");
			
			System.out.println("Running:"+sub.id+" on "+in.getName()+" "+set.getName());
			
			//copy files to given path
			CommonUtil.copyFile(in,new File("judge/in.txt"));
			CommonUtil.copyFile(out,new File("judge/ans.txt"));
			
			//run the core
			String[] r=getLang(sub.lang).runCmd;
			ArrayList<String> cmd=new ArrayList<>();
			cmd.add("python");
			cmd.add("core.py");
			cmd.add(""+pr.tl);
			cmd.add(""+pr.ml);
			
			
			addAll(cmd,getLang(sub.lang).opCode);
			addAll(cmd,getLang(sub.lang).file);
			addAll(cmd,r);
			
			
			System.out.println("Start running core with arg:"+cmd);
			ProcessBuilder pb=new ProcessBuilder(cmd);
			pb.directory(new File("judge"));
			pb.redirectOutput(new File("judge/sbout.txt"));
			Process p=pb.start();
			p.waitFor();
			
	
			String inp=CommonUtil.readFileWithLimit(in.getAbsolutePath(),1024);
			
			
			int v=p.exitValue();
			if(v!=0){
				sub.addResult(sn,new TestResult("Judgement Failed", 0, 0, "The sandbox returned:"+v+"\nSee 'checker exit code' on Github for detail", inp, "", 0));
				return false;
			}
			
			//core is done
			String sbout=CommonUtil.readFile("judge/sbout.txt");
			String[] arg=sbout.split("\n");
			if(arg[0].equals("RE")){
				sub.addResult(sn,new TestResult("Runtime Error", arg[1],arg[2], "Exit code is "+arg[3], inp, "", 0));
				return false;
			}
			if(arg[0].equals("RF")){
				sub.addResult(sn,new TestResult("Restrict Function", arg[1],arg[2], arg[3], inp, "", 0));
				return false;
			}
			if(arg[0].equals("TLE")){
				sub.addResult(sn,new TestResult("Time Limit Exceeded", arg[1],arg[2], "", inp, "", 0));
				return false;
			}
			if(arg[0].equals("MLE")){
				sub.addResult(sn,new TestResult("Memory Limit Exceeded", arg[1],arg[2], "", inp, "", 0));
				return false;
			}
			if(arg[0].equals("UKE")){
				sub.addResult(sn,new TestResult("Judgement Failed", arg[1], arg[2], "Please send an issue with this information:"+arg[3], "", "", 0));
				return false;
			}
			//next is compare answers
			
			String oup=CommonUtil.readFileWithLimit("judge/out.txt",1024);
			
			ProcessBuilder pb2=new ProcessBuilder("./checker","in.txt","out.txt","ans.txt","report.txt");
			pb2.directory(new File("judge"));
			Process p2=pb2.start();
			
			boolean notle=p2.waitFor(30, TimeUnit.SECONDS);
			
			if(notle){
				
				String info=CommonUtil.readFileWithLimit("judge/report.txt", 1024);
				
				if(p2.exitValue()==0){
					sub.addResult(sn,new TestResult("Accepted", arg[1],arg[2], info, inp, oup, 1));
					return true;
				}else{
					if(p2.exitValue()==7){
						sub.addResult(sn,new TestResult("Point", arg[1],arg[2], info, inp, oup, Float.parseFloat(info.split(" ")[0])));
						return true;
					}else{
						sub.addResult(sn,new TestResult("Wrong Answer", arg[1],arg[2], info, inp, oup, 0));
						return false;
					}
				}
			}else{
				sub.addResult(sn,new TestResult("Checker Time Limit Exceeded", arg[1],arg[2], "", inp, oup, 0));
				return false;
			}
		}catch(Exception e){
			e.printStackTrace();
			sub.addResult(sn,new TestResult("Judgement Failed", 0,0, e+"", "", "", 0));
			return false;
		}
	}
	
	private void addAll(ArrayList<String> cmd, int[] x) {
		cmd.add(""+x.length);
		for(int y:x){
			cmd.add(""+y);
		}
	}

	private void addAll(ArrayList<String> cmd, String[] x) {
		cmd.add(""+x.length);
		for(String y:x){
			cmd.add(""+y);
		}
	}
	
	void runTestset(Submission sub,File set,Problem p) throws Exception{
		System.out.println("Running on testset:"+set.getName());
		
		sub.res.put(set.getName(),new TestsetResult());
		
		boolean ok=true;
//		System.out.println(p.tests);
		
		for(String y:p.tests.get(set.getName()).requirement){
			if(!sub.res.get(y).pass){
				System.out.println(y+" did not pass! Skipped");
				ok=false;
				break;
			}
		}
		
		if(!ok){
			return;
		}
		
		boolean allClear=true;
		
		for(int id=0;;id++){
			File in=new File(set.getAbsoluteFile()+"/test"+id+".in");
			if(in.exists()==false){
				break;
			}
			
			
			boolean b=runSingleTest(sub,id,set,p);
			rollbackInfo(sub);
			if(b==false){
				allClear=false;
				if(!p.tests.get(set.getName()).toEnd){
					break;
				}
			}
		}
		
		sub.res.get(set.getName()).pass=allClear;
	}
	
	void testFull(Submission sub,File data) throws Exception{
		//clean folder
		File temp=new File("judge");
		remove(temp);
		temp.mkdirs();
		
		//write to file
		CommonUtil.writeFile("judge/Main."+getLang(sub.lang).ext,sub.code);
		
		//copy library
		CommonUtil.copyFile(new File("lib/core.py"), new File("judge/core.py"));
		CommonUtil.copyFile(new File("data/"+sub.problemSet+"_"+sub.problemId+"/checker"),new File("judge/checker"));
		
		//chmod
		ProcessBuilder pb_=new ProcessBuilder("chmod","*","+777");
		pb_.directory(new File("judge"));
		Process p_=pb_.start();
		p_.waitFor();
		
		//compile file
		System.out.println("Compiling by:"+Arrays.toString(getLang(sub.lang).compileCmd));
		ProcessBuilder pb=new ProcessBuilder(getLang(sub.lang).compileCmd);
		pb.redirectError(new File("judge/ce.txt"));
		pb.redirectOutput(new File("judge/ce.txt"));
		pb.directory(temp);
		
		Process p=pb.start();
		
		boolean notle=p.waitFor(30,TimeUnit.SECONDS);
		
		if(notle){
			sub.compilerInfo=CommonUtil.readFileWithLimit("judge/ce.txt",1024);
		
			if(p.exitValue()!=0){
				sub.isFinal=true;
				sub.compilerInfo="Compilation Error:\n"+sub.compilerInfo;
				return;
			}
		}else{
			sub.compilerInfo="Compile took 30 seconds, which was bad enough :(";
			sub.isFinal=true;
			return;
		}
		
		System.out.println("Compile Success");
		
		rollbackInfo(sub);
		
		//collect problem data
		Problem pr=gs.fromJson(CommonUtil.readFile("data/"+sub.problemSet+"_"+sub.problemId+"/problem.json"), Problem.class);
		
		for(String ord:pr.order){
			File x=new File("data/"+sub.problemSet+"_"+sub.problemId+"/"+ord);
			runTestset(sub,x,pr);
		}
		
		System.out.println("Calculating final score");
		sub.score=sub.calcScore(pr);
		sub.isFinal=true;
		
	}
	
	public void rollbackInfo(Submission sub){
		try{
			dos.writeUTF(gs.toJson(sub));
		}catch(Exception e){
			System.out.println("Warning: cannot rollback info:");
			e.printStackTrace();
		}
	}
	
	Language getLang(String lang) {
		return langs.get(lang);
	}

	void testSubmission(Submission sub) throws Exception{
		
		//try to fetch data now
		
		String path="data/"+sub.problemSet+"_"+sub.problemId;
		
		File data=new File(path);
		if(data.exists()==false){
			//no data!!
			dos.writeInt(-1);
		}else{
			//read ver
			try{
				dos.writeInt(CommonUtil.readProbInfo(path+"/problem.json").ver);
			}catch(Exception e){
				//even structure isn't right!
				dos.writeInt(-1);
			}
		}
		
		String isOk=dis.readUTF();
		if(isOk.equals("Update")){
			//read everything
			downloadData(data,path);
		}
		
		//start testing!!
		testFull(sub,data);
	}
	
	public void solve(String[] args){
		if(args.length<2){
			System.out.println("judge ip port name");
			System.exit(1);
		}
		
		ip=args[0];
		port=Integer.parseInt(args[1]);
		name=args[2];
		
		try{
			Socket s=new Socket(ip, port);
			System.out.println("Successfully connected to the server");
			System.out.println("Registering...");
			
			dis=new DataInputStream(s.getInputStream());
			dos=new DataOutputStream(s.getOutputStream());
			
			dos.writeUTF("judger");
			dos.writeUTF(name);
			
			String langCode=dis.readUTF();
			System.out.println("Read language configuration file:"+langCode);

			
			Type type = new TypeToken<HashMap<String, Language>>(){}.getType();
			langs=gs.fromJson(langCode, type);
			
			System.out.println(langs);
			
			while(true){
				
				String in=dis.readUTF();
				
				Submission sub=gs.fromJson(in, Submission.class);
				
				System.out.println("Read submission:"+sub.id);
				//TODO test it
				try{
					testSubmission(sub);
					rollbackInfo(sub);
					System.out.println("Test finished successfully");
				}catch(Exception e){
					sub.compilerInfo="Judge failed:"+e;
					sub.isFinal=true;
					e.printStackTrace();
				}
				
			}
		}catch(Exception e){
			e.printStackTrace();
		}
	}
}
