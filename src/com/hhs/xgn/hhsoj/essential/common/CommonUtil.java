package com.hhs.xgn.hhsoj.essential.common;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.PrintWriter;
import java.util.ArrayList;

import com.google.gson.Gson;

public class CommonUtil {
	
	public static String readFile(String path){
		try{
			BufferedReader br=new BufferedReader(new InputStreamReader(new FileInputStream(path),"utf-8"));
			String str,tot="";
			while((str=br.readLine())!=null){
				tot+=str+"\n";
			}
			
			br.close();
			return tot;
		}catch(Exception e){
			return null;
		}
	}
	
	public static boolean writeFile(String path,String content){
		try{
			PrintWriter pw=new PrintWriter(path);
			pw.println(content);
			pw.close();
			return true;
		}catch(Exception e){
			return false;
		}
	}
	
	public static Problem readProbInfo(String path){
		Gson gs=new Gson();
		return gs.fromJson(readFile(path),Problem.class);
	}
	
	public static Submission generateBlankSubmission(String author,String code,String lang,int id,String pId,String pSet){
		Submission s=new Submission();
		s.author=author;
		s.code=code;
		s.lang=lang;
		s.compilerInfo="";
		s.id=id;
		s.isFinal=false;
		s.judger="";
		s.problemId=pId;
		s.problemSet=pSet;
		s.res=new ArrayList<>();
		s.score=0;
		s.submitTime=System.currentTimeMillis();
		return s;
	}

	public static String readFileWithLimit(String path, int limit){
		
		try{
			BufferedReader br=new BufferedReader(new InputStreamReader(new FileInputStream(path),"utf-8"));
			
			char[] c=new char[limit];
			
			int read=br.read(c);
			
			
			String s=new String(c,0,read);
			if(read==limit){
				s+="<...>";
			}
			
			br.close();
			
			return s;
		}catch(Exception e){
			return null;
		}
	}

	public static void copyFile(File fromFile, File toFile) throws IOException {
		FileInputStream ins = new FileInputStream(fromFile);
		FileOutputStream out = new FileOutputStream(toFile);
		byte[] b = new byte[1024];
		int n = 0;
		while ((n = ins.read(b)) != -1) {
			out.write(b, 0, n);
		}

		ins.close();
		out.close();
	}
}
