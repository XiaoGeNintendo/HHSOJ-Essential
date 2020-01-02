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
import java.util.Arrays;
import java.util.HashMap;
import java.util.Map;
import java.util.concurrent.TimeUnit;

import com.google.gson.Gson;
import com.google.gson.reflect.TypeToken;
import com.hhs.xgn.hhsoj.essential.common.CommonUtil;
import com.hhs.xgn.hhsoj.essential.common.Language;
import com.hhs.xgn.hhsoj.essential.common.Submission;

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
	}
	
	/**
	 * Returns true if answer is AC, false otherwise
	 * @param sub
	 * @param in
	 * @param set
	 * @return
	 */
	boolean runSingleTest(Submission sub,File in,File set){
		//TODO ddd
		return true;
	}
	
	void runTestset(Submission sub,File set){
		System.out.println("Running on testset:"+set);
		
		for(int id=0;;id++){
			File in=new File("test"+id+".in");
			if(in.exists()==false){
				break;
			}
			
			boolean b=runSingleTest(sub,in,set);
			if(b==false){
				break;
			}
		}
	}
	
	void testFull(Submission sub,File data) throws Exception{
		//clean folder
		File temp=new File("judge");
		remove(temp);
		temp.mkdirs();
		
		//write to file
		CommonUtil.writeFile("judge/Main."+getLang(sub.lang).ext,sub.code);
		
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
		for(File x:data.listFiles()){
			if(x.isDirectory()){
				runTestset(sub,x);
			}
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
			dos.writeInt(CommonUtil.readProbInfo(path+"/problem.json").ver);
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
