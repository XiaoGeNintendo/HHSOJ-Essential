package com.hhs.xgn.hhsoj.essential.common;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.PrintWriter;
import java.lang.reflect.Type;
import java.util.HashMap;

import com.google.gson.Gson;
import com.google.gson.reflect.TypeToken;

public class CommonUtil {
	
	static Gson gs=new Gson();
	public static final int BLOCK_SIZE=1024*1024;
	
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
	
	@Deprecated
	public static String colorize(float f){
//		System.out.println(f+Integer.toHexString((int)((1-f)*256))+Integer.toHexString((int)f*256)+"00");
		if(f>=1.0){
			return "(0,255,0)";
		}
		if(f<=0.0){
			return "(255,0,0)";
		}
		return "("+(int)((1-f)*256)+","+(int)(f*256)+","+"0)";
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
		s.res=new HashMap<>();
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
		byte[] b = new byte[BLOCK_SIZE];
		int n = 0;
		while ((n = ins.read(b)) != -1) {
			out.write(b, 0, n);
		}

		ins.close();
		out.close();
	}

	public static HashMap<String, Language> readLang(String path) {
		Type type = new TypeToken<HashMap<String, Language>>(){}.getType();
		return gs.fromJson(readFile(path), type);
	}

	public static Submission readSubmissionInfo(String path) {
		return gs.fromJson(readFile(path),Submission.class);
	}

	public static void assertEql(int x, int y) {
		if(x!=y){
			throw new AssertionError(x+"!="+y);
		}
	}

	@Deprecated
	public static int calcHash(byte[] by, int len) {
		final int p=114514;
		int hash=0;
		for(int i=0;i<len;i++){
			hash=(hash+by[i])*p;
		}
		
		return hash;
	}
}
