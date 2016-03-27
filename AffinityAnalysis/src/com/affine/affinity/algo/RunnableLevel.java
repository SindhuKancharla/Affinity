package com.affine.affinity.algo;

import java.util.List;
import java.util.Map;


public class RunnableLevel implements Runnable {

	private Map<String, List<String>> map;
	private String dateString;
	private String level;

	public RunnableLevel(Map<String, List<String>> map, String dateString, String level) {

		this.map = map;
		this.dateString = dateString;
		this.level = level;
	}
	
 	@Override
	public void run() {

		 System.out.println(Thread.currentThread().getName() + " -- "+level);
			
		 AffinityAlgorithm affinityAlgorithm = new AffinityAlgorithm();
		 affinityAlgorithm.run(map,dateString,level);
 	     
	}

}
