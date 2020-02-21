package com.hhs.xgn.hhsoj.essential.tomcat.util;

import java.io.File;
import java.util.ArrayList;
import java.util.HashMap;

import com.google.gson.Gson;
import com.hhs.xgn.hhsoj.essential.common.CommonUtil;
import com.hhs.xgn.hhsoj.essential.common.Language;
import com.hhs.xgn.hhsoj.essential.common.Problem;
import com.hhs.xgn.hhsoj.essential.common.Problemset;
import com.hhs.xgn.hhsoj.essential.common.Submission;
import com.hhs.xgn.hhsoj.essential.common.User;

/**
 * The class to read/write tomcat stuff
 * @author XGN
 *
 */
public class TomcatHelper {
	public static Config config;
	public static Gson gs=new Gson();
	
	public static void fetchConfig(){
		if(!new File("config.json").exists()){
			System.out.println("FATAL: CANNOT FIND CONFIG FILE. SEE DOCUMENTATION FOR DETAIL");
			System.out.println("EXPECTED TO FIND IT HERE:"+new File("config.json").getAbsolutePath());
		}else{
			System.err.println("Fetch Config Data Success");
			config=gs.fromJson(CommonUtil.readFile("config.json"), Config.class);
		}
		
	}
	public static ArrayList<User> getUsers(){
		if(config==null){
			fetchConfig();
		}
		File fa=new File(config.path+"/users");
		if(!fa.exists()){
			fa.mkdirs();
		}
		
		ArrayList<User> arr=new ArrayList<>();
		for(File sub:fa.listFiles()){
			try{
				arr.add(gs.fromJson(CommonUtil.readFile(sub.getAbsolutePath()), User.class));
			}catch(Exception e){
				System.out.println("Corrupted User Information Found:"+sub);
			}
		}
		
		return arr;
	}
	public static void addUser(String user, String pass) {
		if(config==null){
			fetchConfig();
		}
		File fa=new File(config.path+"/users");
		if(!fa.exists()){
			fa.mkdirs();
		}
		User x=new User();
		x.id=getUsers().size();
		x.username=user;
		x.password=pass;
		x.isAdmin=false;
		
		CommonUtil.writeFile(config.path+"/users/"+x.id, gs.toJson(x));
	}
	
	public static ArrayList<Problemset> getProblemsets(){
		if(config==null){
			fetchConfig();
		}
		File fa=new File(config.path+"/problems");
		if(!fa.exists()){
			fa.mkdirs();
		}
		
		ArrayList<Problemset> ap=new ArrayList<>();
		for(File sub:fa.listFiles()){
			try{
				if(sub.isFile()){
					continue;
				}
				
				Problemset p=getProblemset(sub.getName());
				
				p.id=sub.getName();
//				System.out.println(p.id);
				ap.add(p);
			}catch(Exception e){
				System.out.println("Corrupted P.Set Data Found:"+sub);
			}
		}
		
		return ap;
	}
	
	public static ArrayList<Problem> getAllProblems(String set){
		if(config==null){
			fetchConfig();
		}
		File fa=new File(config.path+"/problems");
		if(!fa.exists()){
			fa.mkdirs();
		}
		
		ArrayList<Problem> arr=new ArrayList<>();
		File s=new File(config.path+"/problems/"+set);
		if(s.exists()==false){
			return arr;
		}
		
		for(File sub:s.listFiles()){
			if(sub.isDirectory()){
				Problem p=getProblem(set,sub.getName());
				
				arr.add(p);
			}
		}
		
		return arr;
	}
	
	public static Problem getProblem(String set,String id){
		try{
			if(config==null){
				fetchConfig();
			}
			
			Problem p=CommonUtil.readProbInfo(getProblemPath(set, id)+"/problem.json");
			p.set=set;
			p.id=id;
			return p;
		}catch(Exception e){
			return null;
		}
	}
	public static String getProblemPath(String set, String id) {
		if(config==null){
			fetchConfig();
		}
		return config.path+"/problems/"+set+"/"+id;
	}
	public static Problemset getProblemset(String set) {
		if(config==null){
			fetchConfig();
		}
		
		return gs.fromJson(CommonUtil.readFile(config.path+"/problems/"+set+"/problemset.json"), Problemset.class);
	}
	
	public static HashMap<String,Language> getLangs(){
		if(config==null){
			fetchConfig();
		}
		File fa=new File(config.path+"/config");
		if(!fa.exists()){
			fa.mkdirs();
		}
		
		return CommonUtil.readLang(config.path+"/config/lang.json");
	}
	public static int getSubmissionCount() {
		if(config==null){
			fetchConfig();
		}
		
		File fa=new File(config.path+"/submission");
		if(!fa.exists()){
			fa.mkdirs();
		}
		
		return fa.list().length;
	}
	
	public static ArrayList<Submission> getAllSubmissions(){
		if(config==null){
			fetchConfig();
		}
		
		File fa=new File(config.path+"/submission");
		if(!fa.exists()){
			fa.mkdirs();
		}
		ArrayList<Submission> arr=new ArrayList<>();
		for(File sub:fa.listFiles()){
			arr.add(CommonUtil.readSubmissionInfo(sub.getAbsolutePath()));
		}
		
		return arr;
	}
	
	public static Submission getSubmission(String id){
		if(config==null){
			fetchConfig();
		}
		
		File fa=new File(config.path+"/submission");
		if(!fa.exists()){
			fa.mkdirs();
		}
		
		return CommonUtil.readSubmissionInfo(config.path+"/submission/"+id+".json");
	}
	
	public static final String[] tS={"Accepted",
									 "Wrong Answer",
									 "Time Limit Exceeded",
									 "Memory Limit Exceeded",
									 "Runtime Error",
									 "Restrict Function",
									 "Point"
								    },
								 tA={
									 "AC",
									 "WA",
									 "TLE",
									 "MLE",
									 "RE",
									 "RF",
									 ""
								 },
								 tF={"fa fa-check",
 									 "fa fa-close",
									 "fa fa-clock-o",
									 "fa fa-database",
									 "fa fa-bomb",
									 "fa fa-ban",
									 "fa fa-pie-chart"
								    },
								 tT={"Your code is correct",
								     "Your code produced incorrect output",
								     "Your code used too much time to run",
								     "Your code used too much memory to run",
								     "Your code exited abnormally",
								     "Your code used illegal system call",
								     "Click to see detail"
								    },
								 tC={"#00ee00",
									 "#0000ee",
									 "#ff8800",
									 "#aa00aa",
									 "#dd0000",
									 "#ddcc00",
									 "#000000"
								    };
	public static final String tFor="<span style=\"color:%s;font-weight:bold\" title=\"%s\"><i class=\"%s\"></i> %s</span>";
	
	public static String styledVerdict(String ver){
		for(int i=0;i<tS.length;i++){
			if(ver.equals(tS[i])){
				return String.format(tFor, tC[i],tT[i],tF[i],ver);
			}
		}
		return String.format(tFor, "#cccccc","","",ver);
	}
	
	public static String shortVerdict(String ver) {
		for(int i=0;i<tS.length;i++){
			if(ver.equals(tS[i])){
				return tA[i];
			}
		}
		return ver;
	}
	
	public static String shortScore(float x) {
		String str;
		if(Math.abs(x)<=1e5f) {
			str=String.format("%.1f",x);
			if(str.length()<=6) {
				return str;
			}
		}
		if(Math.abs(x)<=1e8f) {
			str=String.format("%.1fk",x/1000f);
			if(str.length()<=6) {
				return str;
			}
		}
		if(Math.abs(x)<=1e11f) {
			str=String.format("%.1fm",x/1e6f);
			if(str.length()<=6) {
				return str;
			}
		}
		if(Math.abs(x)<=1e14f) {
			str=String.format("%.1fb",x/1e9f);
			if(str.length()<=6) {
				return str;
			}
		}
		if(Math.abs(x)<=1e17f) {
			str=String.format("%.1ft",x/1e12f);
			if(str.length()<=6) {
				return str;
			}
		}
		if(x<0) {
			return "-Inf";
		}
		return "Inf";
	}
}
