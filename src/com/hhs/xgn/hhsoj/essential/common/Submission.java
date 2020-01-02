package com.hhs.xgn.hhsoj.essential.common;

import java.util.ArrayList;

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
	public ArrayList<TestResult> res;
	/**
	 * Compiler information
	 */
	public String compilerInfo;
	/**
	 * Scorer Information
	 */
	public String scorerInfo;
	
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
	
}
