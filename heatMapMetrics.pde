class heatMapMetrics{
    public TreeMap<String, Double> frequencies; 
    String columnName; 
    String[] states;
    
    public heatMapMetrics(String columnName, String[] states){
      this.columnName = columnName; 
      //states = table.getStringColumn("ORIGIN_STATE_ABR");
      this.states = states;
      frequencies = new TreeMap<String, Double>(); 
      
    }
    int i = 0;
    public void insertFrequencies(){
      for(String state: states){
        double currFrequency = calculateFrequency(state);
        if(currFrequency <10) currFrequency +=  2*i;
        frequencies.put(state, (200-currFrequency)); 
      }
      i++;
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
