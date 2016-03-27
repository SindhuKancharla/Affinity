package com.affine.affinity.algo;

import java.io.*;
import java.net.URI;
import java.net.URISyntaxException;
import java.sql.SQLException;
import java.util.*;

import org.apache.hadoop.conf.Configuration;
import org.apache.hadoop.fs.FileSystem;
import org.apache.hadoop.fs.Path;

//import com.affine.aa.connectivity.JoinTablesForAlgo;

/**
 * This class represents the whole dataset of all supermarket transactions. A
 * transaction is an itemset of items bought by a supermarket client in a single
 * transaction. The class includes functions for loading the dataset from the
 * file, computing support and confidence etc. The <code> main() </code>
 * function of the class loads the dataset from the default file, runs the
 * apriori algorithm and dumps the results to the console.
 * 
 * 
 */

public class AffinityAlgorithm {

	private String localFilePath =null;
	private String localFileName = null;
	private String hdfsFileName = null;
	private String hdfsPath = null;

	private String serverip = null;
	private String hdfsport = null;
	//private AffinityAlgorithm dataSet;

	private LinkedList<Itemset> transactionList = new LinkedList<Itemset>();
	
	/**
	 * Creates and initializes the dataset with the data from a file
	 * 
	 * @param filename
	 *            the name of the file to be loaded
	 * @throws SQLException 
	 * @throws IOException
	 */
	
	//private final static Logger logger = Logger.getLogger(AffinityAlgorithm.class.getName()); 

	
    
	public AffinityAlgorithm(Map<String, List<String>> itemIdsByTransactionId) throws SQLException {


		for(Map.Entry<String, List<String>> entry : itemIdsByTransactionId.entrySet()){
			
			List<String> itemList = entry.getValue();
			
			Itemset itemSet = new Itemset();  
                                                                                                                                                                                                                                                                  
			for(String item : itemList){
				itemSet.addItem(new Item(item));
			}
			
			if (itemSet.size() != 0) {
				transactionList.add(itemSet);
			}
		}
	}

	/**
	 * 
	 * @return the iterator that allows to go over all the transactions in the
	 *         dataset The transactions are <code> Itemset </code> objects
	 */
	public Iterator<Itemset> getTransactionIterator() {
		return transactionList.iterator();
	}

	/**
	 * 
	 * @return the number of transactions in the dataset
	 */
	public int getNumTransactions() {
		
		return transactionList.size();
	}

	/**
	 * 
	 * @param itemset
	 * @return the support value for a given itemset in the context of the
	 *         current dataset
	 */
	public double computeOccurenceForRule(Itemset itemset) {
		int occurrenceCount = 0;
		Iterator<Itemset> itItemset = getTransactionIterator();
		while (itItemset.hasNext()) {
			Itemset shoppingList = (Itemset) itItemset.next();
			if (shoppingList.intersectWith(itemset).size() == itemset.size()) {
				occurrenceCount++;
			}
		}
		//double support = ((double) occurrenceCount) / getNumTransactions();
		double support = ((double) occurrenceCount);

		//support = Math.round(support * 100.0) / 100.0;
		return support;
	}

	/**
	 * 
	 * @param associationRule
	 * @return the confidence value for a given association rule in the context
	 *         of the current dataset
	 */
	public double computeConfidenceForAssociationRule(
			AssociationRule associationRule) {
		Itemset union = associationRule.getItemsetA().unionWith(
				associationRule.getItemsetB());
		double confidence = computeOccurenceForRule(union)/ computeOccurenceForRule(associationRule.getItemsetA());
		//confidence = Math.round(confidence * 100.0) / 100.0;
		return confidence;
	}
	
	/**
	 * 
	 * @param associationRule
	 * @return the Lift value for a given association rule in the context
	 *         of the current dataset
	 */
	public String computeLiftForAssociationRule(
			AssociationRule associationRule) {
		Itemset union = associationRule.getItemsetA().unionWith(
				associationRule.getItemsetB());
		
		String retValue = "";
		double supportItemsetA = computeOccurenceForRule(associationRule.getItemsetA());
		double supportItemsetB = computeOccurenceForRule(associationRule.getItemsetB());
		
		double productOfOccurences = supportItemsetA* supportItemsetB;
		
		double lift = computeOccurenceForRule(union)/productOfOccurences;
		
		retValue = supportItemsetA+","+supportItemsetB+","+lift;
		//lift = Math.round(lift * 100.0) / 100.0;
		return retValue;
	}
	
	

	/**
	 * 
	 * @return all possible itemsets of size one based on the current dataset
	 */
	public Set<Itemset> getAllItemsetsOfSizeOne() {
		Iterator<Itemset> itItemset = getTransactionIterator();
		Itemset bigUnion = new Itemset();
		while (itItemset.hasNext()) {
			Itemset itemset = (Itemset) itItemset.next();
			bigUnion = bigUnion.unionWith(itemset);
		}

		// break up the big unioned itemset into one element itemsets
		HashSet<Itemset> allItemsets = new HashSet<Itemset>();
		Iterator<?> itItem = bigUnion.getItemIterator();
		while (itItem.hasNext()) {
			Item item = (Item) itItem.next();
			Itemset itemset = new Itemset();
			itemset.addItem(item);
			allItemsets.add(itemset);
		}

		return allItemsets;
	}

	/**
	 * The core of the association rule mining algorithm. This is what needs to
	 * be implemented. This is the only piece of code that you need to modify to
	 * complete the exercise.
	 * @param dataSet 
	 *  
	 * @param minSupport
	 *            minimal support value below which itemsets should not be
	 *            considered when generating candidate itemsets
	 * @param minConfidence
	 *            minimal support value for the association rules output by the
	 *            algorithm
	 * @param dateString 
	 * @param level 
	 * @param fw2 
	 * @return a collection of <code> AssociationRule </code> instances
	 * @throws IOException 
	 * @throws SQLException 
	 * @throws URISyntaxException 
	 */
	@SuppressWarnings({ "unchecked", "rawtypes" })
	public void runApriori(AffinityAlgorithm dataSet, double minSupport, double minConfidence, double minLift, String dateString, String level) throws IOException, SQLException, URISyntaxException {
			
		
		Properties prop = new Properties();
		
		String propFileName = "resources/config.properties";
		
		InputStream inputStream = getClass().getClassLoader().getResourceAsStream(propFileName);
		 
		if (inputStream != null) {
			prop.load(inputStream);
		} else {
			throw new FileNotFoundException("property file '" + propFileName + "' not found in the classpath");
		}
		
		if(level.equalsIgnoreCase("item")){
		
			this.localFilePath = prop.getProperty("LOCAL.FILE.PATH");
			this.localFileName = prop.getProperty("LOCAL.FILENAME.ITEM");
			this.hdfsFileName = prop.getProperty("HDFS.FILENAME.ITEM");
			this.hdfsPath = prop.getProperty("HDFS.FOLDER.PATH.ITEM");

		}
		else if(level.equalsIgnoreCase("Category"))
		{
			this.localFilePath = prop.getProperty("LOCAL.FILE.PATH");
			this.localFileName = prop.getProperty("LOCAL.FILENAME.CAT");
			this.hdfsFileName = prop.getProperty("HDFS.FILENAME.CAT");
			this.hdfsPath = prop.getProperty("HDFS.FOLDER.PATH.CAT");
		}
		else{
			this.localFilePath = prop.getProperty("LOCAL.FILE.PATH");
			this.localFileName = prop.getProperty("LOCAL.FILENAME.DEPT");
			this.hdfsFileName = prop.getProperty("HDFS.FILENAME.DEPT");
			this.hdfsPath = prop.getProperty("HDFS.FOLDER.PATH.DEPT");
		}
		
		
		
		System.out.println(localFilePath+localFileName);
		/*String localFilePath = prop.getProperty("localfilePath");
		String localFileName = prop.getProperty("localFileName");
		String hdfsFileName = prop.getProperty("hdfsfilename");
		String hdfsPath = prop.getProperty("hdfsPath");
*/
		Set<Object> discoveredAssociationRules = new HashSet<Object>();
		
		 
		Configuration configuration = new Configuration();

		String user = prop.getProperty("HIVE.USERNAME");
		configuration.set("user", user);
		
		this.serverip = prop.getProperty("HDFS.SERVER.IP");
		this.hdfsport = prop.getProperty("HADOOP.SERVER.PORT");
		
		
		String url = "hdfs://"+serverip+":"+hdfsport;
		
		System.out.println(url);

		URI uri =new URI(url);

		//URI uri =new URI("hdfs://192.168.0.31:9000");
		FileSystem hdfs = FileSystem.get(uri, configuration);
		
		
		FileWriter fw = new FileWriter(new File(localFilePath+localFileName));
		System.out.println("In run apriori");
		//logger.info("In run apriori");
		// generate candidate itemsets
		final int MAX_NUM_ITEMS = 1000000;
		Set[] candidates = new Set[MAX_NUM_ITEMS];
		candidates[1] = getAllItemsetsOfSizeOne();
		
		
		for (int numItems = 1; numItems < MAX_NUM_ITEMS
				&& !candidates[numItems].isEmpty(); numItems++) {
			
			if(numItems==2)
				break;
			
			candidates[numItems + 1] = new HashSet<Object>();
			for (Iterator<?> itItemset1 = candidates[numItems].iterator(); itItemset1
					.hasNext();) {
				Itemset itemset1 = (Itemset) itItemset1.next();
				
				for (Iterator<?> itItemset2 = candidates[numItems].iterator(); itItemset2
						.hasNext();) {
					Itemset itemset2 = (Itemset) itItemset2.next();
					
					if (itemset1.intersectWith(itemset2).size() == numItems - 1) {
						Itemset candidateItemset = itemset1.unionWith(itemset2);
						
						assert (candidateItemset.size() == numItems + 1);
						//if (computeOccurenceForRule(candidateItemset) >= minSupport) {
							candidates[numItems + 1].add(candidateItemset);
						//}
					}
				}
			}
		}

		List<Object> individualItems = new ArrayList<Object>();
		
		// generate association rules from candidate itemsets
		for (int numItems = 1; numItems < 3
				&& !candidates[numItems].isEmpty(); numItems++) {
			
			for (Iterator<?> itItemsetCandidate = candidates[numItems].iterator(); itItemsetCandidate
					.hasNext();) {
				Itemset itemsetCandidate = (Itemset) itItemsetCandidate.next();
				for (Iterator<?> itItemsetSub = itemsetCandidate
						.generateAllNonEmptySubsets().iterator(); itItemsetSub
						.hasNext();) {
					Itemset itemsetSub = (Itemset) itItemsetSub.next();
					Itemset itemsetA = itemsetSub;
					
					Itemset tempSet = new Itemset();
					
					Itemset itemsetB = itemsetCandidate.minusAllIn(itemsetSub);
					
					AssociationRule candidateAssociationRule = new AssociationRule(itemsetA, itemsetB);
					
					//if (computeConfidenceForAssociationRule(candidateAssociationRule) > minConfidence) {
						discoveredAssociationRules.add(candidateAssociationRule);
					//}
					
					if(individualItems.contains(itemsetB)){
						continue;
					}
					else{
						AssociationRule individualItemsRule = new AssociationRule(itemsetB, itemsetB);

						AssociationRule emptyItemsRule = new AssociationRule(tempSet, itemsetB);

						//if (computeConfidenceForAssociationRule(individualItemsRule) > minConfidence) {
							//System.out.println(" passed "+individualItemsRule.getItemsetA() + " -- "+ individualItemsRule.getItemsetB());

							discoveredAssociationRules.add(individualItemsRule);
						//}
						//if (computeConfidenceForAssociationRule(emptyItemsRule) > minConfidence) {
							discoveredAssociationRules.add(emptyItemsRule);
						//}
						individualItems.add(itemsetB);
					}
				}
				
			}
			if(numItems==3)
				break;
		}
		
	
		
		Iterator<Object> itAssociationRule = discoveredAssociationRules.iterator();
		while (itAssociationRule.hasNext()) {
			AssociationRule associationRule = (AssociationRule) itAssociationRule.next();				
			
			Itemset itemSetA = associationRule.getItemsetA();
			Itemset itemSetB = associationRule.getItemsetB();
				
			String itemIdA = itemSetA.toString();
			String itemIdB = itemSetB.toString();
			
			/*
			if(itemIdA.toString().equals(""))
				itemIdA = itemIdB;
			
			*/
			double occurenceOfRule = dataSet.computeOccurenceForRule(associationRule.getItemsetA().unionWith(associationRule.getItemsetB()));
			double confidence = dataSet.computeConfidenceForAssociationRule(associationRule);
			String val = dataSet.computeLiftForAssociationRule(associationRule);
			String[] vals = val.split(",");
			
			double occurenceOfA = Double.valueOf(vals[0]);
			double occurenceOfB = Double.valueOf(vals[1]);
			double partialLift = Double.valueOf(vals[2]);
			
			//occurenceOfRule = Math.round(occurenceOfRule * 100.0) / 100.0;
			
			confidence = Math.round(confidence * 100.0) / 100.0;

			//occurenceOfA = Math.round(occurenceOfA * 100.0) / 100.0;
			//occurenceOfB = Math.round(occurenceOfB * 100.0) / 100.0;
			//partialLift = Math.round(partialLift * 100.0) / 100.0;

			if(level.equalsIgnoreCase("Category")){
				
				if(itemIdA.isEmpty()){
					String parts1[] = itemIdB.split("\\|");

					fw.write(""+","+""+","+""+","+parts1[0]+","+parts1[1]+ ","+occurenceOfA+","+occurenceOfB+","+occurenceOfRule+ ","+partialLift+","+confidence+","+dateString);

				}
				else{
					String parts[] = itemIdA.split("\\|");
					String parts1[] = itemIdB.split("\\|");
	
					fw.write(""+","+parts[0]+","+parts[1]+","+parts1[0]+","+parts1[1]+ ","+occurenceOfA+","+occurenceOfB+","+occurenceOfRule+ ","+partialLift+","+confidence+","+dateString);
			
				}
			}
			else{
				fw.write(""+","+itemIdA+","+itemIdB+ ","+occurenceOfA+","+occurenceOfB+","+occurenceOfRule+ ","+partialLift+","+confidence+","+dateString);
			}
			//logger.info(itemIdA+","+itemIdB+ ","+associationRule+"--"+support+ ","+lift+","+confidence+","+dateString+"\n");
			fw.write("\n");
		}
		fw.close();
		Path localFile = new Path(localFilePath+localFileName);
		Path hdfsFilePath=new Path(hdfsPath+hdfsFileName);

		Path hdfsFolderPath = new Path(hdfsPath);
		
		if (hdfs.exists(hdfsFolderPath)) {
			hdfs.delete(hdfsFolderPath, true); // Delete existing Directory
		}
		
		hdfs.mkdirs(hdfsFolderPath); // Create new Directory

		hdfs.copyFromLocalFile(localFile, hdfsFilePath);
		//JoinTablesForAlgo obj = new JoinTablesForAlgo();
		//obj.joinTempResultAndMasterTables(level);
		
		
	}

	/**
	 * Loads the dataset from a default file, runs the apriori algorithm and outputs the result to the console.
	 * @param dateString 
	 * @param level 
	 * @param item_no_desc_map 
	 * @param fw 
	 * @param args
	 * @return 
	 */
	public void run(Map<String,List<String>> itemIdsByTransactionId, String dateString, String level) {
		
		try {
			
			//FileHandler fh = new FileHandler("affinity.log");  
		    //logger.addHandler(fh);
		    //SimpleFormatter formatter = new SimpleFormatter();  
		    //fh.setFormatter(formatter);  
		    
			AffinityAlgorithm dataSet = new AffinityAlgorithm(itemIdsByTransactionId);
			
			dataSet.runApriori(dataSet,0.0,0.0,0.0,dateString,level);

			System.out.println(Thread.currentThread().getName()+" -- DONE");
			//logger.info(Thread.currentThread().getName()+" -- DONE"+"\n");
		} catch (Exception ex) {
			ex.printStackTrace();
		}
	
	}

	public AffinityAlgorithm() {
		super();
	}
}