

import java.util.*; 
Table table;

String date , carrier, origin, originCity, orginCityAbr, 
destination, destinationCity, destinationStateAbr;

int flightNumber, originAirportWAC, destinationWAC, ScheduledDepTime, ActDepTime, ScheduledArrTime,
ActARRTime, distance, diverted, cancelled;

int screen, i;
screen mainScreen, mapScreen, mapScreen2, mapScreen3, creditScreen, sourceScreen, histoScreen;
PFont font, niceFont;

widget titleWidget, triangleWidget1, triangleWidget2, carrierWid1, carrierWid2, carrierWid3, carrierWid4,
carrierWid5, carrierWid6, carrierWid7, carrierWid8, carrierWid9, carrierWid10, carrierWid11, carrierWid12, messageWidget
, trustRatingWid1, trustRatingWid2, trustRatingWid3;
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
PFont titleFont, TpFont;

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

TreeMap<String, Double> ratings;
TreeMap<String, Double> weightedRatings, weightedDelays, weightedCancellations; 
heatMapMetrics delaysHM, cancellationsHM, Co2HM;
PImage plane;
PImage [] background;
int numberOfFrames;
ArrayList backG, empty;
int f = 825;
int g = 700;
int h = 950;
int pixelCount; 
int S2SCo2;
Histogram histogram;

boolean selector = false;
void draw() {
  background(255);
  fill(0);
  // YuChen Zhuang
  clickMeToStart();
  
  if (screen == 0)
  {
    f = 825;
    g = 700;
    h = 900;
    mainScreen.draw();
    mainScreen.selection();
  }
    else if (screen == 1)
    {
      // Emma Murphy
      mapScreen.draw(1);
      fill(60); stroke(0);
      text("Co2 emissions per state", 250, 65); 
      line(250, 80, 770, 80);
      
      if(previousWidgetX != 0 && xPos != 0)
      {
        line(previousWidgetX, previousWidgetY, xPos, yPos);
        //pixelCount++; 
      }
      if(displayStateToStateDist && newWidget != null)
      {
        fill(0);
        //S2SCo2 = calculateDistance(previousWidget.origin, newWidget.origin);
        text("Distance from " + previousWidget.widgetName+" airport to ", 70, 700);
        text(newWidget.widgetName + " airport is " + S2SCo2 + " miles", 80, 750);
      }
      for (int i = 0; i < states.size() - 2; i++)
      {
        widget cur = (widget) states.get(i);
        if (cur.widgetColor == 0 && displayState == true)
        {
          fill(0);
          long frequency = Math.round(Co2HM.calculateFrequency(cur.origin));
          text(cur.widgetName + " Co2 emissions = " +  frequency + ((frequency == 1) ? " tonne" : " tonnes"), 90, 700);
        }
      }
    }
    else if(screen == 2)
    {
      // Emma Murphy
      mapScreen2.draw(1); 
      fill(173, 71, 3); stroke(0);
      text("Delays per state", 300, 65); 
      line(300, 80, 630, 80);
      for (int i = 0; i < delaysStates.size() - 2; i++)
      {
        widget cur = (widget) delaysStates.get(i);
        if (cur.widgetColor == 0 && displayState == true)
        {
          fill(0);
          long frequency = Math.round(delaysHM.calculateFrequency(cur.origin));
          text(cur.widgetName + " delays = " +  frequency, 190, 700);
        }
      }
    
    }  
    else if(screen == 3)
    {
      // Emma Murphy
      mapScreen3.draw(1); 
      fill(148, 10, 10); stroke(0);
      text("Cancellations per state", 250, 65); 
      line(250, 80, 750, 80);
      fill(148, 10, 10);
      for (int i = 0; i < cancellationsStates.size() - 2; i++)
      {
        widget cur = (widget) cancellationsStates.get(i);
        if (cur.widgetColor == 0 && displayState == true)
        {
          fill(0);
          long frequency = Math.round(cancellationsHM.calculateFrequency(cur.origin));
          text(cur.widgetName + " Cancellations = " +  frequency, 90, 700);
        }
      }
    }
    // Bhudhav Singh 
    // drawing the Histogram when the screen is on -1 
    else if(screen == -1) {
      histoScreen.draw("Histogram");
    }
    // YuChen Zhuang
    else if (screen == -2)
    {
      sourceScreen.draw();
      sourceScreen.message(1);
    }
    else if (screen == -3)
    {
      creditScreen.draw();
      creditScreen.message();
    }
    // Emma Murphy 
    // Displaying the pop up box/ window when hovering over the co2 map
    if(displayPopUp == true && screen == 1) 
    {
      fill(88, 172, 191);
      rect(mouseX, mouseY, 120, 40, 10);
      fill(255); textSize(12);
      text("Click and drag to", mouseX+10, mouseY+20);
      text("get the distance!", mouseX + 10, mouseY + 33); 
      textSize(48);
    }
  // Finn Farrell
  int event;
  for (int i = 0; i < carrierWidgets.size(); i++) 
  {
    widget currentWidget = (widget) carrierWidgets.get(i);
    event = currentWidget.getEvent(mouseX, mouseY);
    if (carrierWid1.trustRatingType == 1) 
    {
        switch(event) 
        {
          case BUTTON1:
            carrierWid1.trustRating = (float)(double)weightedRatings.get("AA"); //  <<<<<<<<<<<<<<<<< emmas get function
            carrierWid1.shadeColour = (#166bba);
            break;
          case BUTTON2:
            carrierWid2.trustRating = (float)(double)weightedRatings.get("AS");
            carrierWid2.shadeColour = (#166bba);
            break;
          case BUTTON3:
            carrierWid3.trustRating = (float)(double)weightedRatings.get("B6");
            carrierWid3.shadeColour = (#166bba);
            break;
          case BUTTON4:
            carrierWid4.trustRating = (float)(double)weightedRatings.get("HA");
            carrierWid4.shadeColour = (#166bba);
            break;
          case BUTTON5:
            carrierWid5.trustRating = (float)(double)weightedRatings.get("NK");
            carrierWid5.shadeColour = (#166bba);
            break;
          case BUTTON6:
            carrierWid6.trustRating = (float)(double)weightedRatings.get("G4");
            carrierWid6.shadeColour = (#166bba);
            break;
          case BUTTON7:
            carrierWid7.trustRating = (float)(double)weightedRatings.get("WN");
            carrierWid7.shadeColour = (#166bba);
            break;
          case BUTTON8:
            carrierWid8.trustRating = (float)(double)weightedRatings.get("F9");
            carrierWid8.shadeColour = (#166bba);
            break;
          case BUTTON9:
            carrierWid9.trustRating = (float)(double)weightedRatings.get("UA");
            carrierWid9.shadeColour = (#166bba);
            break;
          case BUTTON11:
            carrierWid11.trustRating = 0.90;
            carrierWid11.shadeColour = (#166bba);
            break;
        }
    }
    else if (carrierWid1.trustRatingType == 2) 
    {
      switch(event) 
      {
        case BUTTON1:
          carrierWid1.trustRating = (float)(double)weightedDelays.get("AA");
          carrierWid1.shadeColour = (#fc2803);
          break;
        case BUTTON2:
          carrierWid2.trustRating = (float)(double)weightedRatings.get("AS");
          carrierWid2.shadeColour = (#fc2803);
          break;
        case BUTTON3:
          carrierWid3.trustRating = (float)(double)weightedRatings.get("B6");
          carrierWid3.shadeColour = (#fc2803);
          break;
        case BUTTON4:
          carrierWid4.trustRating = (float)(double)weightedRatings.get("HA");
          carrierWid4.shadeColour = (#fc2803);
          break;
        case BUTTON5:
          carrierWid5.trustRating = (float)(double)weightedRatings.get("NK");
          carrierWid5.shadeColour = (#fc2803);
          break;
        case BUTTON6:
          carrierWid6.trustRating = (float)(double)weightedRatings.get("G4");
          carrierWid6.shadeColour = (#fc2803);
          break;
        case BUTTON7:
          carrierWid7.trustRating = (float)(double)weightedRatings.get("WN");
          carrierWid7.shadeColour = (#fc2803);
          break;
        case BUTTON8:
          carrierWid8.trustRating = (float)(double)weightedRatings.get("F9");
          carrierWid8.shadeColour = (#fc2803);
          break;
        case BUTTON9:
          carrierWid9.trustRating = (float)(double)weightedRatings.get("UA");
          carrierWid9.shadeColour = (#fc2803);
          break;
        case BUTTON11:
          carrierWid11.trustRating = 0.7;
          carrierWid11.shadeColour = (#fc2803);
          break;
        }
      }
    else if (carrierWid1.trustRatingType == 3) {
      switch(event) {
      case BUTTON1:
        carrierWid1.trustRating = (float)(double)weightedCancellations.get("AA");
        carrierWid1.shadeColour = (#e303fc);
        break;
      case BUTTON2:
        carrierWid2.trustRating = (float)(double)weightedCancellations.get("AS");
        carrierWid2.shadeColour = (#e303fc);
        break;
      case BUTTON3:
        carrierWid3.trustRating = (float)(double)weightedCancellations.get("B6");
        carrierWid3.shadeColour = (#e303fc);
        break;
      case BUTTON4:
        carrierWid4.trustRating = (float)(double)weightedCancellations.get("HA");
        carrierWid4.shadeColour = (#e303fc);
        break;
      case BUTTON5:
        carrierWid5.trustRating = (float)(double)weightedCancellations.get("NK");
        carrierWid5.shadeColour = (#e303fc);
        break;
      case BUTTON6:
        carrierWid6.trustRating = (float)(double)weightedCancellations.get("G4");
        carrierWid6.shadeColour = (#e303fc);
        break;
      case BUTTON7:
        carrierWid7.trustRating = (float)(double)weightedCancellations.get("WN");
        carrierWid7.shadeColour = (#e303fc);
        break;
      case BUTTON8:
        carrierWid8.trustRating = (float)(double)weightedCancellations.get("F9");
        carrierWid8.shadeColour = (#e303fc);
        break;
      case BUTTON9:
        carrierWid9.trustRating = (float)(double)weightedCancellations.get("UA");
        carrierWid9.shadeColour = (#e303fc);
        break;
      case BUTTON11:
        carrierWid11.trustRating = 0.21;
        carrierWid11.shadeColour = (#e303fc);
        break;
      }
    }
    else {
     switch(event) 
        {
          case BUTTON1:
            println((float)(double)weightedRatings.get("AA"));
            carrierWid1.trustRating = (float)(double)weightedRatings.get("AA"); //  <<<<<<<<<<<<<<<<< emmas get function
            carrierWid1.shadeColour = (#166bba);
            break;
          case BUTTON2:
            carrierWid2.trustRating = (float)(double)weightedRatings.get("AS");
            carrierWid2.shadeColour = (#166bba);
            break;
          case BUTTON3:
            carrierWid3.trustRating = (float)(double)weightedRatings.get("B6");
            carrierWid3.shadeColour = (#166bba);
            break;
          case BUTTON4:
            carrierWid4.trustRating = (float)(double)weightedRatings.get("HA");
            carrierWid4.shadeColour = (#166bba);
            break;
          case BUTTON5:
            carrierWid5.trustRating = (float)(double)weightedRatings.get("NK");
            carrierWid5.shadeColour = (#166bba);
            break;
          case BUTTON6:
            carrierWid6.trustRating = (float)(double)weightedRatings.get("G4");
            carrierWid6.shadeColour = (#166bba);
            break;
          case BUTTON7:
            carrierWid7.trustRating = (float)(double)weightedRatings.get("WN");
            carrierWid7.shadeColour = (#166bba);
            break;
          case BUTTON8:
            carrierWid8.trustRating = (float)(double)weightedRatings.get("F9");
            carrierWid8.shadeColour = (#166bba);
            break;
          case BUTTON9:
            carrierWid9.trustRating = (float)(double)weightedRatings.get("UA");
            carrierWid9.shadeColour = (#166bba);
            break;
          case BUTTON11:
            carrierWid11.trustRating = 0.90;
            carrierWid11.shadeColour = (#166bba);
            break;
        }
    }
  }
}


int previousColor = 0;
int previousColor1 = 0;
int previousColor2 = 0;
color xCol = 0;

void mousePressed() 
{
    int event =0;
    for (int i = 0; i < carrierWidgets.size(); i++) 
    {
      widget currentWidget = (widget) carrierWidgets.get(i);
      event = currentWidget.getEvent(mouseX, mouseY);
    }  
    // Finn Farrell
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
      // Emma Murphy
    case triLeft:
      if(screen == 3){ 
        screen =2;
      }
      else if(screen == 2){
        screen = 1;
      }
      else if(screen == 1){
        screen = 0;
      }
      else if (screen == 0) {
         screen = -1;
      }
      else if (screen == -1) {
        screen = -2;
      }
      else if (screen == -2) {
        screen = -3;
      }
      break;
    case triRight:
        if(screen == 1) screen =2;
        else if(screen == 2) screen = 3;
        else if (screen == -1) screen = 0;
        else if (screen == -2) screen = -1;
        else if (screen == -3) screen = -2;
        else screen = 1; 
        break;
        // Finn Farrell
      case TYPEEVENT1:
        carrierWid1.trustRatingType = RATINGTYPE1;
        trustRatingWid1.widgetColour = #ffffff;
        trustRatingWid2.widgetColour = #4287f5;
        trustRatingWid3.widgetColour = #4287f5;
        break;
    case TYPEEVENT2:
        carrierWid1.trustRatingType = RATINGTYPE2;
        trustRatingWid1.widgetColour = #4287f5;
        trustRatingWid2.widgetColour = #ffffff;
        trustRatingWid3.widgetColour = #4287f5;
        break;
    case TYPEEVENT3:
        carrierWid1.trustRatingType = RATINGTYPE3;
        trustRatingWid1.widgetColour = #4287f5;
        trustRatingWid2.widgetColour = #4287f5;
        trustRatingWid3.widgetColour = #ffffff;
        break;
    }
    // Emma Murphy
    xCol = get(mouseX, mouseY);
    xPos = 0; 
    yPos = 0;
    displayStateToStateDist = false; 
    pixelCount = 0;
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
// Emma Murphy 
// detect when and when not to display the pop up screen
void mouseMoved(){
  color xCol = get(mouseX, mouseY); 
  if((int)blue(xCol) != 255) displayPopUp = true; 
  else displayPopUp = false;
}
// This method is used to get the distance between states airport
void mouseReleased(){
  color newCol = get(mouseX, mouseY); 
  if((int)blue(xCol) != (int)blue(newCol) && (int)blue(newCol) != 0){
    displayStateToStateDist = true;  
    displayState = false; 
    pixelCount = 0; 
  }
  else{
    pixelCount = 0; 
    displayState = true;  
    displayStateToStateDist = false; 
  }
}

// Emma Murphy 
// In the Co2 Map, this function allow you to check the distance between the states 
void mouseDragged()
{
  xPos = mouseX; 
  yPos = mouseY; 
  color currCol = get(mouseX, mouseY);  
  for(widget state: statesWidArray)
  {
      if((int)blue(currCol) == state.widgetColor)
      {
          newWidget = state;
          pixelCount++;
          S2SCo2 = calculateDistance(previousWidget.origin, newWidget.origin); 
       }
  }
}


  // Emma Murphy
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
  // Emma Murphy
  //get data for data point 
  public double[] getData(String column){
    double[] data = new double[table.getRowCount()];
    for(int i = 0;i<table.getRowCount();i++){
      data[i] = table.getDouble(i, column);
    }
    return data;
  }
  // Emma Murphy
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
    return pixelCount*17; 
  }
  
  // YuChen Zhuang
  int p = 0;
  int q = 0;
  int z = 0;
 
  // by YuChen Zhuang
  // using the stuff we did in the first few week and implement them into a click to Start screen
  public void clickMeToStart() 
  {
    background(250,218,94);
    image((PImage)backG.get(p), (float)screenWidth/2 - 260, 0);
    image((PImage)backG.get(p), (float)screenWidth/2 - 260, screenHeight/2 + 100);
    image((PImage)backG.get(p), (float)screenWidth/2 - 260, screenHeight/2 + 350);
    
    image((PImage)backG.get(p), -120, 0);
    image((PImage)backG.get(p), -120, screenHeight/2 + 100);
    image((PImage)backG.get(p), -120, screenHeight/2 + 350);
    
    image((PImage)backG.get(p), 700, 0);
    image((PImage)backG.get(p), 700, screenHeight/2 + 100);
    image((PImage)backG.get(p), 700, screenHeight/2 + 350);
    text("Click to Start", q, (screenHeight/2) );
    text("Click to Start", q - 1000, (screenHeight/2) );
    text("Click to Start", q - 2000, (screenHeight/2) );
    image((PImage)backG.get(p), (float)screenWidth/2 - 250, screenHeight/2 -150);
    //text("Click to Start", q, (screenHeight/2) );
    if ((mousePressed) && (z == 0)){
       screen = 0;
       z++;
    }
    q = q + 2;
    if (q > screenWidth + 1000) {
      q = 0;
    }
    p++;
    if (p > 60){
      p = 0;
    }
  }
  
