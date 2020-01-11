package com.hhs.xgn.hhsoj.essential.se;

import java.io.BufferedReader;
import java.io.DataInputStream;
import java.io.DataOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.InputStreamReader;

import com.google.gson.Gson;
import com.hhs.xgn.hhsoj.essential.common.CommonUtil;
import com.hhs.xgn.hhsoj.essential.common.Problem;
import com.hhs.xgn.hhsoj.essential.common.Submission;

/**
 * A judging thread to communicate about judging
 * @author XGN
 *
 */
public class JudgingThread extends Thread {
	public Submission sub;
	public Judger j;
	public ServerManager boss;
	public JudgingThread(Submission sub, Judger j, ServerManager boss) {
		this.sub = sub;
		this.j = j;
		this.boss = boss;
	}
	
	public void run(){
		System.out.println("Start to judge "+sub.id+" on "+j.name);
		sub.judger=j.name;
		boss.saveSubmission(sub);
		
		try{
			//send information
			Gson gs=new Gson();
			j.dos.writeUTF(gs.toJson(sub));
			
			String path="problems/"+sub.problemSet+"/"+sub.problemId;
			
			Problem p=CommonUtil.readProbInfo(path+"/problem.json");
			
			int clientVer=j.dis.readInt();
			
			System.out.println(clientVer+"<>"+p.ver);
			if(clientVer!=p.ver){
				System.out.println("Need to update client information");
				j.dos.writeUTF("Update");
				
				//send everything
				//no nested folders are expected, thus won't be sent
				File f=new File(path);
				for(File x:f.listFiles()){
					if(x.isDirectory()){
						j.dos.writeUTF("!"+x.getName());
						
						for(File y:x.listFiles()){
							j.dos.writeUTF(x.getName()+"/"+y.getName());
							int snd=(int)y.length();
							j.dos.writeInt(snd);
							
							byte[] by=new byte[1024];
							FileInputStream fis=new FileInputStream(y);
							int len=0;
							while((len=fis.read(by, 0, 1024))!=-1){
//								System.out.println("Send"+len);
								j.dos.write(by,0,len);
							}
							fis.close();
							
							System.out.println("Send file "+y+" of size "+snd);
							
						}
					}else{
						j.dos.writeUTF(x.getName());
						int snd=(int)x.length();
						j.dos.writeInt(snd);
						
						byte[] by=new byte[1024];
						FileInputStream fis=new FileInputStream(x);
						int len=0;
						while((len=fis.read(by, 0, 1024))!=-1){
//							System.out.println("Send"+len);
							j.dos.write(by,0,len);
						}
						fis.close();
						
						System.out.println("Send file "+x+" of size "+snd);
						
					}
				}
				
				j.dos.writeUTF("$$END");
			}else{
				j.dos.writeUTF("OK");
			}
			
			while(true){
				sub=gs.fromJson(j.dis.readUTF(), Submission.class);
				boss.saveSubmission(sub);
				System.out.println("Received:"+gs.toJson(sub));
				if(sub.isFinal){
					break;
				}
			}
			
			System.out.println("Judging has done for "+sub.id);
			j.isFree=true;
			boss.notifyJudge();
		}catch(Exception e){
			System.out.println("Communication failed");
			e.printStackTrace();
			
		}
	}
}
