package com.hhs.xgn.hhsoj.essential.common;

import java.util.ArrayList;
import java.util.HashMap;

/**
 * Represents a submission
 * @author XGN
 *
 */
public class Submission {
	public String code;
	public String lang;
	public String author;
	public long submitTime;
	
	public String judger;
	public long id;
	
	/**
	 * The result of the submission
	 */
	public ArrayList<TestsetResult> res;
	/**
	 * Compiler information
	 */
	public String compilerInfo;
	
	/**
	 * The score of the submission.
	 */
	public float score;
	/**
	 * Is the verdict final
	 */
	public boolean isFinal;
	
	/**
	 * The problem set id of the submission
	 */
	public String problemSet;
	/**
	 * The problem id of the submission
	 */
	public String problemId;
	
	public void addResult(TestResult testResult) {
		res.get(res.size()-1).res.add(testResult);
	}

	public float calcScore(Problem pr) {
		HashMap<String,Testset> mp=new HashMap<>();
		
		for(Testset ts:pr.tests){
			mp.put(ts.name, ts);
		}
		
		float score=0;
		for(TestsetResult tsr:res){
			score+=tsr.getScore(mp.get(tsr.name).scheme);
		}
		
		return score;
	}
	
}
