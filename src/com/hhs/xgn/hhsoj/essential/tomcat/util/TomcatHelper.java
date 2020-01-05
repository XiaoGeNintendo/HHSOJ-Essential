package com.hhs.xgn.hhsoj.essential.tomcat.util;

import java.io.File;
import java.util.ArrayList;

import com.google.gson.Gson;
import com.hhs.xgn.hhsoj.essential.common.CommonUtil;
import com.hhs.xgn.hhsoj.essential.common.Problemset;
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
				
				Problemset p=gs.fromJson(CommonUtil.readFile(sub.getAbsolutePath()+"/problemset.json"), Problemset.class);
				p.id=sub.getName();
				System.out.println(p.id);
				ap.add(p);
			}catch(Exception e){
				System.out.println("Corrupted P.Set Data Found:"+sub);
			}
		}
		
		return ap;
	}
}
