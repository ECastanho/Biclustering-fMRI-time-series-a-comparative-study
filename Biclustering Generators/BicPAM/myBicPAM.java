package tests.bicpam;

import java.io.File;
import java.io.IOException;
import java.util.List;

import bicpam.bicminer.BiclusterMiner;
import bicpam.bicminer.BiclusterMiner.Orientation;
import bicpam.bicminer.coherent.AdditiveBiclusterMiner;
import bicpam.bicminer.coherent.MultiplicativeBiclusterMiner;
import bicpam.bicminer.coherent.SymmetricBiclusterMiner;
import bicpam.bicminer.constant.ConstantBiclusterMiner;
import bicpam.bicminer.constant.ConstantOverallBiclusterMiner;
import bicpam.bicminer.order.OrderPreservingBiclusterMiner;
import bicpam.closing.BiclusterFilter;
import bicpam.closing.BiclusterMerger;
import bicpam.closing.Biclusterizer;
import bicpam.mapping.Itemizer;
import bicpam.mapping.Itemizer.DiscretizationCriteria;
import bicpam.mapping.Itemizer.FillingCriteria;
import bicpam.mapping.Itemizer.NoiseRelaxation;
import bicpam.mapping.Itemizer.NormalizationCriteria;
import bicpam.pminer.fim.MaximalFIM;
import bicpam.pminer.fim.ClosedFIM;

import bicpam.pminer.spm.SequentialPM;
import bicpam.pminer.spm.SequentialPM.SequentialImplementation;
import domain.Bicluster;
import domain.Biclusters;
import domain.Dataset;
import generator.BicMatrixGenerator.PatternType;
import utils.BicReader;
import utils.BicResult;
import utils.others.CopyUtils;

public class myBicPAM{
	
	public static void main(String[] args) throws Exception{

		// Additive patterns
		Do_bicpams("originalDatasetFolder/dataset.txt",
				"outputFolder/biclusters.txt",
				"Additive"
				);
		// Multiplicative patterns
		Do_bicpams("originalDatasetFolder/dataset.txt",
				"outputFolder/biclusters.txt",
				"Multiplicative"
				);

		// Constant patterns
		Do_bicpams("originalDatasetFolder/dataset.txt",
				"outputFolder/biclusters.txt",
				"Constant"
				);
	}
	
    public static void Do_bicpams(String infile, String outfile, String coherence) throws Exception{
    	String dataset = new String(); 
    	String output = new String(); 
    	
    	// Input File
        dataset = infile;
    	// Output File 
        output  = outfile;
    	
    	
		/** A: Read Dataset **/
    	dataset = new File("").getAbsolutePath()+dataset;
		Dataset data;
		if (dataset.contains(".arff"))
			data = new Dataset(BicReader.getInstances(dataset));
		else
			data = new Dataset(BicReader.getConds(dataset,1,"\t"),BicReader.getGenes(dataset,"\t"),BicReader.getTable(dataset,1,"\t"));

		/** B: Define Homogeneity **/
		PatternType type = null;
		if(coherence.equals("Additive"))
			type = PatternType.Additive; /*coherence assumption*/
		else if (coherence.equals("Multiplicative"))
			type = PatternType.Multiplicative; /*coherence assumption*/
		else if (coherence.equals("Constant"))
			type = PatternType.Constant; /*coherence assumption*/
		
		Orientation orientation = Orientation.PatternOnRows;
		
		/** C: Define Stopping Criteria **/
		int minNrBicsBeforeMerging = 1000; //choose high number of biclusters
		int minNrColumns = 2;
		int minNrRows = 2;
		int nrIterations = 5; //increase for more even space exploration 

		/** D: Define Itemizer for Mapping **/
		int nrLabels = 5;
		boolean symmetries = false;
		data = Itemizer.run(data, nrLabels, symmetries, 
			NormalizationCriteria.Row, 
			DiscretizationCriteria.NormalDist,
			NoiseRelaxation.None, /* multi-item assignments */
			FillingCriteria.RemoveValue);
						
		/** E: Define Biclusterizer for Closing **/
		double minOverlapMerging = 0.7;
		double minSimilarity = 0.5;
		Biclusterizer posthandler = new Biclusterizer(new BiclusterMerger(minOverlapMerging),
				new BiclusterFilter(minSimilarity));

		/** F: PMiner **/
		BiclusterMiner bicminer = null; 
	   	if(type.equals(PatternType.OrderPreserving)){
			SequentialPM pminer = new SequentialPM();
		    pminer.algorithm = SequentialImplementation.PrefixSpan;
			pminer.inputMinNrBics(minNrBicsBeforeMerging);
			pminer.inputMinColumns(minNrColumns);
			bicminer = new OrderPreservingBiclusterMiner(data,pminer,posthandler,orientation);		
		} else {
			//MaximalFIM pminer = new MaximalFIM();
			ClosedFIM pminer = new ClosedFIM();
			//new ClosedFIM();
			pminer.inputMinNrBics(minNrBicsBeforeMerging);
			pminer.inputMinColumns(minNrColumns);
			pminer.setMinRows(minNrRows); 
			if(type.equals(PatternType.Additive)){
				bicminer = new AdditiveBiclusterMiner(data,pminer,posthandler,orientation);
			} else if(type.equals(PatternType.Constant)){
				bicminer = new ConstantBiclusterMiner(data,pminer,posthandler,orientation); 
			} else if(type.equals(PatternType.Symmetric)){
				bicminer = new SymmetricBiclusterMiner(data,pminer,posthandler,orientation); 
			} else if(type.equals(PatternType.ConstantOverall)){
				bicminer = new ConstantOverallBiclusterMiner(data,pminer,posthandler,orientation); 
			} else {
				bicminer = new MultiplicativeBiclusterMiner(data,pminer,posthandler,orientation); 
			}
		}
		
		/** G: Run BicPAM **/		
		long time = System.currentTimeMillis();
		Biclusters bics = new Biclusters();
		List<List<Integer>> originalIndexes = CopyUtils.copyIntList(data.indexes);
		List<List<Integer>> originalScores = CopyUtils.copyIntList(data.intscores);
		
		double removePercentage = 0.3;
		for(int i=0; i<nrIterations; i++){
			Biclusters iBics = bicminer.mineBiclusters();
			data.remove(iBics.getElementCounts(),removePercentage);
			bicminer.setData(data);
			bics.addAll(iBics);
		}
		data.indexes = originalIndexes;
		data.intscores = originalScores;
		time = System.currentTimeMillis() - time;

		/** H: Output and Evaluation **/		
		BicResult a = new BicResult(output);
		
		System.out.println("Time:"+((double)time/(double)1000)+"ms");
		a.println("FOUND BICS:" + bics.toString(data.rows,data.columns));
		for(Bicluster bic : bics.getBiclusters()) a.println(bic.toString(data)+"\n\n");
	}
}
