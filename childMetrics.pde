class AirlineMetrics extends DistributionMetrics{
  double distMean;
  double distSD;
  boolean CO2Object;
  AirlineMetrics(double[] data, double distMean, double distSD, boolean CO2Object){
    super(data);
    this.distMean = distMean;
    this.distSD = distSD;
    this.CO2Object = CO2Object; 
  }
  
   public double calculateZScore(){
      double x = (CO2Object) ? calculateMean() * CO2_EMISSIONS : calculateMean();
      return (x - distMean) / distSD;
  }
  
}
