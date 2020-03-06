package com.hhs.xgn.hhsoj.essential.se;

public class ManagerThread extends Thread {
	public ServerManager m;
	public int port;
	
	public void run() {
		m=new ServerManager();
		try {
			m.start(port);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	public ManagerThread() {
		
	}
	
	public ManagerThread(int port) {
		this.port=port;
	}
}
