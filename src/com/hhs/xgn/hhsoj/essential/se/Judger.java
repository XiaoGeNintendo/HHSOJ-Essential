package com.hhs.xgn.hhsoj.essential.se;

import java.io.DataInputStream;
import java.io.DataOutputStream;
import java.net.Socket;

import com.hhs.xgn.hhsoj.essential.common.Submission;

/**
 * Represents a judging server
 * @author think
 *
 */
public class Judger {
	public boolean isFree;
	/**
	 * The name of it
	 */
	public String name;
	/**
	 * The socket
	 */
	public Socket sock;
	public DataInputStream dis;
	public DataOutputStream dos;
	/**
	 * The dealing thread
	 */
	public Thread deal;
	
	public Judger(String name,Socket sock,DataInputStream dis,DataOutputStream dos){
		deal=null;
		isFree=true;
		this.name=name;
		this.sock=sock;
		this.dis=dis;
		this.dos=dos;
	}

	public boolean isOnline() {
		return !sock.isClosed() || !sock.isInputShutdown() || !sock.isOutputShutdown();
	}

	public void work(Submission submission,ServerManager boss) {
		deal=new JudgingThread(submission,this,boss);
		isFree=false;
		deal.start();
	}
}
