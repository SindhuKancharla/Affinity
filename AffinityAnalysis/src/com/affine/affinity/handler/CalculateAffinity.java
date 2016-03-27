package com.affine.affinity.handler;

import java.util.ArrayList;
import java.util.List;
import java.util.concurrent.ExecutionException;
import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;
import java.util.concurrent.Future;

import com.affine.affinity.algo.GettingInputFromHive;
import com.affine.affinity.util.PropertiesConfigHolder;
import com.affine.services.PublishMapReduce;
import com.affine.services.impl.PublishMapReduceForCatgToCatg;
import com.affine.services.impl.PublishMapReduceForDeptToDept;
import com.affine.services.impl.PublishMapReduceForItemToItem;

public class CalculateAffinity {
	private ExecutorService executor = Executors.newCachedThreadPool();
	List<Future<String>> results = null;
	String resultMsg;

	public String runAffinityAlgorith(String fromDateNew, String toDateNew,
			String dateString, PropertiesConfigHolder ch) {
		List<PublishMapReduce> tasks = new ArrayList<PublishMapReduce>();
		try {
			if (ch.isFlag()) {				
				
				long startTime = System.currentTimeMillis();

				tasks.add(new PublishMapReduceForItemToItem(fromDateNew,
						toDateNew, dateString, ch.getConfigPropLoc()));
				tasks.add(new PublishMapReduceForCatgToCatg(fromDateNew,
						toDateNew, dateString, ch.getConfigPropLoc()));
				tasks.add(new PublishMapReduceForDeptToDept(fromDateNew,
						toDateNew, dateString, ch.getConfigPropLoc()));
				results = executor.invokeAll(tasks); // jp.runMapReduce(fromDateNew,
														// toDateNew,
														// ch.getConfigPropLoc());
				for (Future<String> future : results) {
					try {
						resultMsg = (String) future.get();

					} catch (ExecutionException e) {
						System.out
								.println("Error while iterating feature object : "
										+ e);
					}
				}
				
				long endTime = System.currentTimeMillis();
				
				long diff = endTime-startTime;
				System.out.println(" Time taken for Algo Computations = "+ diff);
			
			} else {
				
				long startTime = System.currentTimeMillis();

				GettingInputFromHive gettingInputFromHive = new GettingInputFromHive();
				resultMsg = gettingInputFromHive.runAlgorithm(fromDateNew,
						toDateNew, dateString);

				long endTime = System.currentTimeMillis();
				
				long diff = endTime-startTime;
				System.out.println(" Time taken for Algo Computations = "+ diff);
			
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return resultMsg;
	}
}
