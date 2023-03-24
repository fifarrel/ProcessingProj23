import java.util.Map;

HashMap<String,Double> co2Map,delaysMap,cancellationsMap;
double Co2Mean, delaysMean, cancellationsMean;
double Co2SD, delaysSD, cancellationsSD;
String[] airlineNames = {"AA", "AS", "B6", "HA", "NK", "G4", "WN", "F9", "UA"};
double AAZScore;

Table table;


  void setup(){
     table = loadTable("flights2k(1).csv", "header");
     //airlineNames = {"AA", "AS", "B6", "HA", "NK", "G4", "WN", "F9", "UA"};
     cancellationsMap = new HashMap<String, Double>();
     //array storing all co2Data 
     double[] cancellationData = getData("CANCELLED");
     DistributionMetrics cancellationsMetrics = new DistributionMetrics(cancellationData);
     cancellationsMean = cancellationsMetrics.calculateMean();
     cancellationsSD = cancellationsMetrics.calculateSD();
     println(cancellationsMean);
     
     double[] delaysData = getData("DIVERTED");
     DistributionMetrics delaysMetrics = new DistributionMetrics(delaysData);
     delaysMean = delaysMetrics.calculateMean();
     delaysSD = delaysMetrics.calculateSD();
     
     //double[] Co2Data = getData("Co2");
     //need to add column of Co2 data to table 
     
     combineCancellations();
     println(cancellationsMap.get("F9"));

  }
  
  public void combineCancellations(){
      for(int i = 0;i<airlineNames.length;i++){
         double[] currData = getData("CANCELLED", airlineNames[i], "MKT_CARRIER"); //<>//
         AirlineMetrics currMetrics = new AirlineMetrics(currData, cancellationsMean, cancellationsSD);
         double currZScore = currMetrics.calculateZScore();
         cancellationsMap.put(airlineNames[i], currZScore); 
      }
  }
  
  public double[] getData(String column){
    double[] data = new double[table.getRowCount()];
    for(int i = 0;i<table.getRowCount();i++){
      data[i] = table.getDouble(i, column);
    }
    return data;
  }
  
  public double[] getData(String columnName, String airlineName, String airlinecol){
    double[] data = new double[table.getRowCount()];
    int i = 0;
    for(TableRow row: table.findRows(airlineName, airlinecol)){
        //println(row.getInt(columnName));
        data[i] = row.getInt(columnName);
        i++;
    }
    return data;
  }
  
 
