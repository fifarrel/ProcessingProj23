class AirlineMetrics extends DistributionMetrics{
  double distMean;
  double distSD;
  
  AirlineMetrics(double[] data, double distMean, double distSD){
    super(data);
    this.distMean = distMean;
    this.distSD = distSD;
  }
  
   public double calculateZScore(){
      double x = calculateMean();
      return (x - distMean) / distSD;
  }
  
}
