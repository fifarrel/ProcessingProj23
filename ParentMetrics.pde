class DistributionMetrics{
  double[] data;
  
  DistributionMetrics(double[] data) {
      this.data = data;
  }
  
  public double calculateMean(){
    double sum = 0;
    int count = 0;;
    for(int i = 0;i<data.length;i++){
        double curr = data[i];
        sum += curr;
        count++;
    }
    println(sum);
    return sum/count;
  }
  
  public double calculateSD(){
      double mean = calculateMean();
      double sum = 0;
      int n = 0;
      for(int i = 0;i<data.length;i++){
          double curr = data[i];
          sum += Math.pow(curr - mean, 2);
          n++;
      }
      sum /= n;
      println(Math.sqrt(sum));
      return Math.sqrt(sum);
  }
   
}
