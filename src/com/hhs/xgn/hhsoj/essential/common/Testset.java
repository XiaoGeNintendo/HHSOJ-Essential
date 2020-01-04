package com.hhs.xgn.hhsoj.essential.common;

import java.util.Arrays;

/**
 * A testset
 * @author XGN
 *
 */
public class Testset {
	/**
	 * Max - the maximum score of each subtask <br/>
	 * Min - the minimum score of each subtask <br/>
	 * Sum - the sum of score <br/>
	 * Avg - the avg of score <br/>
	 */
	public String scheme;
	
	/**
	 * All requirement for testing this subtask
	 */
	public String[] requirement=new String[0];
	
	/**
	 * Judge to the end of the subtask even if there's something wrong already?
	 */
	public boolean toEnd;

	@Override
	public String toString() {
		return "Testset [scheme=" + scheme + ", requirement=" + Arrays.toString(requirement) + ", toEnd=" + toEnd + "]";
	}
}
