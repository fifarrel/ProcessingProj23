class heatMapMetrics{
    public TreeMap<String, Double> frequencies; 
    String columnName; 
    String[] states;
    
    public heatMapMetrics(String columnName){
      this.columnName = columnName;  //<>//
      states = table.getStringColumn("ORIGIN_STATE_ABR");
      frequencies = new TreeMap<String, Double>();  //<>//
    }
    public void insertFrequencies(){
      for(String state: states){
        frequencies.put(state, calculateFrequency(state)); 
      }
    }
   
    private double calculateFrequency(String state) {
          //FOR EACH ROW, IF SAME AIRLINE, ADD FREQUENCY TO COUNT 
          double sum = 0;
          for(TableRow row: table.findRows(state, "ORIGIN_STATE_ABR")){
              sum += row.getDouble(columnName);
          }
          return (columnName.equals("DISTANCE") ? sum * CO2_EMISSIONS : sum);
    }
   
}
