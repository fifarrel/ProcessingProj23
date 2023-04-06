import java.util.*; 
Table table;

String date , carrier, origin, originCity, orginCityAbr, 
destination, destinationCity, destinationStateAbr;

int flightNumber, originAirportWAC, destinationWAC, ScheduledDepTime, ActDepTime, ScheduledArrTime,
ActARRTime, distance, diverted, cancelled;

int screen, i;
screen mainScreen, mapScreen, mapScreen2, mapScreen3;
PFont font, niceFont;

widget titleWidget, triangleWidget1, triangleWidget2, carrierWid1, carrierWid2, carrierWid3, carrierWid4,
carrierWid5, carrierWid6, carrierWid7, carrierWid8, carrierWid9, carrierWid10, carrierWid11, carrierWid12, messageWidget;

widget statesWidArray[], delaysArray[], cancellationsA[];

Message message;
float [] chart = new float [2000];
int [] onOfVDistance = new int [2000];

PShape usa;

Map map;

PShape triangle;
ArrayList carrierWidgets;
ArrayList states, delaysStates, cancellationsStates;
float trustRating;

PFont titleFont;
//<<<<<<< HEAD
int flightDelay;

int xPos, yPos;
int previousWidgetX, previousWidgetY, previousWidgetX1, previousWidgetY1, previousWidgetX2, previousWidgetY2;
boolean displayStateToStateDist, displayState, displayPopUp;
widget previousWidget, newWidget, previousWidget1, previousWidget2; 
//z scores for each airline 
HashMap<String,Double> co2Map,delaysMap,cancellationsMap;
double Co2Mean, delaysMean, cancellationsMean;
double Co2SD, delaysSD, cancellationsSD;
String[] airlineNames = {"AA", "AS", "B6", "HA", "NK", "G4", "WN", "F9", "UA", "DL"};
//ratings for each airline 
TreeMap<String, Double> ratings;
TreeMap<String, Double> weightedRatings; 
heatMapMetrics delaysHM, cancellationsHM, Co2HM;
PImage plane;
PImage [] background;
int numberOfFrames;
ArrayList backG;


void draw() {
  
  background(255);
  fill(0);

  if (screen == 0){
    mainScreen.draw();
      
  }
  else if (screen == 1){
    mapScreen.draw(1);
    fill(60); stroke(0);
    text("Co2 emissions per state", 250, 65); 
    line(250, 80, 770, 80);

  
  if(previousWidgetX != 0 && xPos != 0){
    line(previousWidgetX, previousWidgetY, xPos, yPos);
  }
  if(displayStateToStateDist && newWidget != null){
    fill(0);
    int S2SCo2 = calculateDistance(previousWidget.origin, newWidget.origin);
    text("Distance from " + previousWidget.widgetName+" airport to ", 70, 700);
    text(newWidget.widgetName + " airport is " + S2SCo2 + " miles", 80, 750);
  }
    for (int i = 0; i < states.size() - 2; i++){
      widget cur = (widget) states.get(i);
      if (cur.widgetColor == 0 && displayState == true){
        fill(0);
        long frequency = Math.round(Co2HM.calculateFrequency(cur.origin));
        text(cur.widgetName + " Co2 emissions = " +  frequency + ((frequency == 1) ? " tonne" : " tonnes"), 90, 700);
      }
    }
  }
  else if(screen == 2){
    mapScreen2.draw(1); 
    fill(173, 71, 3); stroke(0);
    text("Delays per state", 300, 65); 
    line(300, 80, 630, 80);
    for (int i = 0; i < delaysStates.size() - 2; i++){
      widget cur = (widget) delaysStates.get(i);
      if (cur.widgetColor == 0 && displayState == true){
        fill(0);
        long frequency = Math.round(delaysHM.calculateFrequency(cur.origin));
        text(cur.widgetName + " delays = " +  frequency, 190, 700);
      }
    }
    
  }
  else if(screen == 3){
    mapScreen3.draw(1); 
    fill(148, 10, 10); stroke(0);
    text("Cancellations per state", 250, 65); 
    line(250, 80, 750, 80);
    fill(148, 10, 10);
    for (int i = 0; i < cancellationsStates.size() - 2; i++){
      widget cur = (widget) cancellationsStates.get(i);
      if (cur.widgetColor == 0 && displayState == true){
        fill(0);
        long frequency = Math.round(cancellationsHM.calculateFrequency(cur.origin));
        text(cur.widgetName + " Cancellations = " +  frequency, 90, 700);
      }
    }
  }
    if(displayPopUp == true && screen == 1) {
    fill(88, 172, 191);
    rect(mouseX, mouseY, 120, 40, 10);
    fill(255); textSize(12);
    text("Click and drag to", mouseX+10, mouseY+20);
    text("get the distance!", mouseX + 10, mouseY + 33); 
    textSize(48);
  }
  int event;
  for (int i = 0; i < carrierWidgets.size(); i++) {
    widget currentWidget = (widget) carrierWidgets.get(i);
    event = currentWidget.getEvent(mouseX, mouseY);
    switch(event) {
    case BUTTON1:
      carrierWid1.trustRating = 0.3;
      break;
    case BUTTON2:
      carrierWid2.trustRating = 0.8;
      break;
    case BUTTON3:
      carrierWid3.trustRating = 0.28;
      break;
    case BUTTON4:
      carrierWid4.trustRating = 0.45;
      break;
    case BUTTON5:
      carrierWid5.trustRating = 0.33;
      break;
    case BUTTON6:
      carrierWid6.trustRating = 0.56;
      break;
    case BUTTON7:
      carrierWid7.trustRating = 0.77;
      break;
    case BUTTON8:
      carrierWid8.trustRating = 0.452;
      break;
    case BUTTON9:
      carrierWid9.trustRating = 0.79;
      break;
    case BUTTON11:
      carrierWid11.trustRating = 0.90;
      break;
    }
  }
}

//previousWidget = null; 
int previousColor = 0;
int previousColor1 = 0;
int previousColor2 = 0;
color xCol = 0;

void mousePressed() {
int event =0;
  for (int i = 0; i < carrierWidgets.size(); i++) {
    widget currentWidget = (widget) carrierWidgets.get(i);
    event = currentWidget.getEvent(mouseX, mouseY);
  }
    println("Clicked");
    switch(event) {
    case BUTTON1:
      println("Button 1");
      break;
    case BUTTON2:
      println("Button 2");
      break;
    case BUTTON3:
      println("Button 3");
      break;
    case BUTTON4:
      println("Button 4");
      break;
    case BUTTON5:
      println("Button 5");
      break;
    case BUTTON6:
      println("Button 6");
      break;
    case BUTTON7:
      println("Button 7");
      break;
    case BUTTON8:
      println("Button 8");
      break;
    case BUTTON9:
      println("Button 9");
      break;
    case BUTTON10:
      println("Button 10");
      break;
    case BUTTON11:
      println("Button 11");
      break;
    case BUTTON12:
      println("Button 12");
      break;
    case home:  
      carrierWid1.trustRating = 0;
      carrierWid2.trustRating = 0;
      carrierWid3.trustRating = 0;
      carrierWid4.trustRating = 0;
      carrierWid5.trustRating = 0;
      carrierWid6.trustRating = 0;
      carrierWid7.trustRating = 0;
      carrierWid8.trustRating = 0;
      carrierWid9.trustRating = 0;
      carrierWid11.trustRating = 0;
      break;
    case triLeft:
      //println("TRIANGLE LEFT");
      //screen--;
      if(screen == 3){ 
        screen =2;
        break;
      }
      if(screen == 2){
        screen = 1;
        break;
      }
      else screen = 0;
      break;
    case triRight:
      //specificScreen = specificScreen + 1;
      println(screen);
      if(screen == 1) screen =2;
      else if(screen == 2) screen = 3;
      else screen = 1; 
      break;
    }
  
    xCol = get(mouseX, mouseY);
    xPos = 0; 
    yPos = 0;
    displayStateToStateDist = false; 
    for(widget state: statesWidArray){
    if((int)blue(xCol) == state.widgetColor){
      if(previousWidget != null && previousColor != 0) previousWidget.widgetColor = previousColor;
        previousWidget = state; 
        previousColor = state.widgetColor;
        previousWidgetX = mouseX; 
        previousWidgetY = mouseY; 
        state.widgetColor = 0; 
        displayPopUp = false;
      }
    }
    for(widget state: delaysArray){
    if((int)red(xCol) ==(int)red(state.widgetColor)){
      if(previousWidget1 != null && previousColor1 != 0) previousWidget1.widgetColor = previousColor1;
        previousWidget1 = state; 
        previousColor1 = state.widgetColor;
        previousWidgetX1 = mouseX; 
        previousWidgetY1 = mouseY; 
        state.widgetColor = 0; 
      }
    }
    for(widget state: cancellationsA){
    if((int)green(xCol) ==(int)green(state.widgetColor)){
      if(previousWidget2 != null && previousColor2 != 0) previousWidget2.widgetColor = previousColor2;
        previousWidget2 = state; 
        previousColor2 = state.widgetColor;
        previousWidgetX2 = mouseX; 
        previousWidgetY2 = mouseY; 
        state.widgetColor = 0; 
      }
    }
}
void mouseMoved(){
  color xCol = get(mouseX, mouseY); 
  if((int)blue(xCol) != 255) displayPopUp = true; 
  else displayPopUp = false;
}
void mouseReleased(){
  color newCol = get(mouseX, mouseY); 
  if((int)blue(xCol) != (int)blue(newCol) && (int)blue(newCol) != 0){
    displayStateToStateDist = true;  
    displayState = false; 
    
  }
  else{
    displayState = true;  
    displayStateToStateDist = false; 
  }
}

void mouseDragged(){
  xPos = mouseX; 
  yPos = mouseY; 
  color currCol = get(mouseX, mouseY); 
  for(widget state: statesWidArray){
      if((int)blue(currCol) == state.widgetColor){
          newWidget = state;
          println("located"); 
        }
      }
}



  public void combineCancellations(){
      for(int i = 0;i<airlineNames.length;i++){
         double[] currData = getData("CANCELLED", airlineNames[i], "MKT_CARRIER");
         AirlineMetrics currMetrics = new AirlineMetrics(currData, cancellationsMean, cancellationsSD, false);
         double currZScore = currMetrics.calculateZScore();
         cancellationsMap.put(airlineNames[i], currZScore); 
      }
  }
  
    public void combinedelays(){
      for(int i = 0;i<airlineNames.length;i++){
         double[] currData = getData("DIVERTED", airlineNames[i], "MKT_CARRIER");
         AirlineMetrics currMetrics = new AirlineMetrics(currData, delaysMean, delaysSD, false);
         double currZScore = currMetrics.calculateZScore();
         delaysMap.put(airlineNames[i], currZScore); 
      }
  }
  
    public void combineCo2(){
      for(int i = 0;i<airlineNames.length;i++){
         double[] currData = getData("DISTANCE", airlineNames[i], "MKT_CARRIER");
         AirlineMetrics currMetrics = new AirlineMetrics(currData, Co2Mean, Co2SD, true);
         double currZScore = currMetrics.calculateZScore();
         co2Map.put(airlineNames[i], currZScore); 
      }
  }
  
  //get data for data point 
  public double[] getData(String column){
    double[] data = new double[table.getRowCount()];
    for(int i = 0;i<table.getRowCount();i++){
      data[i] = table.getDouble(i, column);
    }
    return data;
  }
  
  //get data for airline 
  public double[] getData(String columnName, String airlineName, String airlinecol){
    double[] data = new double[table.getRowCount()];
    int i = 0;
    for(TableRow row: table.findRows(airlineName, airlinecol)){
        data[i] = row.getInt(columnName);
        i++;
    }
    return data;
  }
  
  //Calculate rating for each airline 
  public void calculateRating(){
    for(int i = 0;i<airlineNames.length;i++){
        String currAirline = airlineNames[i];
        double co2Score = 6 - (co2Map.get(currAirline) + 3);
        double cancScore = 6 - (cancellationsMap.get(currAirline) + 3);
        double delaysScore =6 -  (delaysMap.get(currAirline) + 3); 
        //assuming the weights for time-being, eventually get input from user 
        Double rating = (WEIGHT_1 * (co2Score) + WEIGHT_2 * cancScore + WEIGHT_3 * delaysScore) * 5/6 ;
        ratings.put(currAirline, rating); 
    }
  }
  
  public int calculateDistance(String origin, String destination){

    for(TableRow currRow: table.findRows(origin, "ORIGIN_STATE_ABR")){
        String currDest = currRow.getString("DEST_STATE_ABR"); 
        if(currDest.equals(destination)){
          return currRow.getInt("DISTANCE") ; 
        } 
    }
    return -1; 
  }
  
