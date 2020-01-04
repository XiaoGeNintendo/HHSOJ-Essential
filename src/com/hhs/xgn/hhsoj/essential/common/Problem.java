package com.hhs.xgn.hhsoj.essential.common;

import java.util.HashMap;

public class Problem {
	public String name;
	public int tl;
	public int ml;
	public int ver;
	
	public HashMap<String,Testset> tests=new HashMap<>();
	public String[] order=new String[0];
	
}
