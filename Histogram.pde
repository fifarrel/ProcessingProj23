class Histogram{
 
    
   int[] histogram;
   
   double[] data;
      
    public Histogram (double[] data) {
      this.data = data;
      this.histogram = new int[150];
    }
 
 
 
public void calculateHistogram() {

  
  for (int i = 0; i < 150; i++) {
    histogram[i] = (int)data[i];
    //println("i" + data[i]);
  }
}


public void drawHistogram() {
  
  float barWidth = screenWidth / (float) 100;
  //ScreenWidth - 2 * margin;
  //(float) histogram.length; 
  float barHeight = screenHeight / (float)max(histogram);
     double maxVal = data[0];  
        for (int i = 0; i < 150; i++) {  
           if(data[i] > maxVal)  
               maxVal = data[i];  
        }  
  
  float mV = (float)maxVal;
  float data1 = (float)data[i];
  
  stroke(0); 
  
  for (int i = 0; i < 93; i++) {
    
    float Height = map(data1, 0, mV, 0, barHeight);
    
    float x = i * barWidth ; 
    float y = screenHeight - histogram[i] * barHeight; 
    float w = barWidth ; 
    float h = histogram[i] * barHeight; 
    
    
    if (mouseX >= x && mouseX <= x + w && mouseY >= y && mouseY <= screenHeight) {
      hoverIndex = i;
    }
    
    fill(255 - i * 2, 0, i * 2);
    
    //fill(hoverIndex == i ? color(255, 95, 74) : color(84)); 
    rect(x + 35, y -50, w , h );
    //rect(margin + i * binWidth, screenHeight - margin - Height, binWidth, Height);
  }
  
   //textAlign(CENTER);
  textSize(16);
  text("Distances", 440, screenHeight - margin/2);
  fill(178, 0, 37);
  
  pushMatrix();
  translate(margin/2, screenHeight/2);
  rotate(-HALF_PI);
  //textAlign(CENTER);
  textSize(16);
  text("Frequency", 0, 0);
  popMatrix();
  
  
  textSize(20);
  //textAlign(CENTER);
  fill(37, 0 ,0);
  text("Histogram", screenWidth/2, margin/2);
  
  
  if (hoverIndex >= 0) {
    fill(0);
    textSize(16);
    text(" Distance: " + histogram[hoverIndex], 700, 150);
  }
  }
 }
