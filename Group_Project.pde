import java.util.*; 
Table table;
//z scores for each airline 
HashMap<String,Double> co2Map,delaysMap,cancellationsMap;
double Co2Mean, delaysMean, cancellationsMean;
double Co2SD, delaysSD, cancellationsSD;
String[] airlineNames = {"AA", "AS", "B6", "HA", "NK", "G4", "WN", "F9", "UA", "DL"};
//ratings for each airline 
TreeMap<String, Double> ratings;
TreeMap<String, Double> weightedRatings; 
heatMapMetrics delaysHM, cancellationsHM, Co2HM;

String date , carrier, origin, originCity, orginCityAbr, 
destination, destinationCity, destinationStateAbr;

int flightNumber, originAirportWAC, destinationWAC, ScheduledDepTime, ActDepTime, ScheduledArrTime,
ActARRTime, distance, diverted, cancelled;

int screen, i;
screen screen1, screen2;
PFont font, niceFont;

widget a , b;

Display [] someMessage, someMessage2, someMessage3, someMessage4, someMessage5, someMessage6,
someMessage7, someMessage8, someMessage9, someMessage10, someMessage11, someMessage12, someMessage13, someMessage14,
someMessage15, someMessage16, someMessage17, someMessage18;

float [] chart = new float [2000];
int [] onOfVDistance = new int [2000];

PShape usa;

PShape alabama, alaska, arizona, arkansas, california,
  colorado, connecticut, delaware, districtofColumbia, florida, georgia,
  hawaii, idaho, illinois, indiana, iowa, kansas, kentucky, louisiana,
  maine, maryland, massachusetts, michigan, minnesota, mississippi, missouri, montana,
  nebraska, nevada, newHampshire, newJersey,
  newMexico, newYork, northCarolina, northDakota,
  ohio, oklahoma, oregon, pennsylvania, virginIsland, rhodeIsland, southCarolina,
  southDakota, tennessee, texas, utah, vermont, virginia,
  washington, westVirginia, wisconsin, wyoming;


widget michiganWidget, ohioWidget, alabamaWidget, alaskaWidget, arizonaWidget,
  arkansasWidget, californiaWidget, coloradoWidget, connecticutWidget, delawareWidget, districtofColumbiaWidget,
  floridaWidget, georgiaWidget, hawaiiWidget, idahoWidget, illinoisWidget, indianaWidget, iowaWidget,
  kansasWidget, kentuckyWidget,
  louisianaWidget, maineWidget, marylandWidget, massachusettsWidget, minnesotaWidget,
  mississippiWidget, missouriWidget, montanaWidget, nebraskaWidget, nevadaWidget, newHampshireWidget, newJerseyWidget,
  newMexicoWidget, newYorkWidget, northCarolinaWidget, northDakotaWidget,
  oklahomaWidget, oregonWidget, pennsylvaniaWidget, rhodeIslandWidget, southCarolinaWidget,
  southDakotaWidget, tennesseeWidget, texasWidget, utahWidget, vermontWidget, virginiaWidget,
  washingtonWidget, westVirginiaWidget, wisconsinWidget, wyomingWidget;


void setup() {
  
  size (1000, 835);
  background (255);
  table = loadTable("flights2k(1).csv", "header");
  //println(table.getRowCount() + " total rows in table");
  //usa = loadShape("us.svg");
  
  //someMessage =  new Display[table.getRowCount()];
  //someMessage2 = new Display[table.getRowCount()];
  //someMessage3 = new Display[table.getRowCount()];
  //someMessage4 = new Display[table.getRowCount()];
  //someMessage5 = new Display[table.getRowCount()];
  //someMessage6 = new Display[table.getRowCount()];
  //someMessage7 =  new Display[table.getRowCount()];
  //someMessage8 = new Display[table.getRowCount()];
  //someMessage9 = new Display[table.getRowCount()];
  //someMessage10 = new Display[table.getRowCount()];
  //someMessage11 = new Display[table.getRowCount()];
  //someMessage12 = new Display[table.getRowCount()];
  //someMessage13 = new Display[table.getRowCount()];
  //someMessage14 = new Display[table.getRowCount()];
  //someMessage15 = new Display[table.getRowCount()];
  //someMessage16 = new Display[table.getRowCount()];
  //someMessage17 = new Display[table.getRowCount()];
  //someMessage18 = new Display[table.getRowCount()];
  

  //for (TableRow row : table.rows()) {  // this prints out some info on to the terminal 
  //  date = row.getString("FL_DATE");
  //  carrier = row.getString("MKT_CARRIER");
  //  flightNumber = row.getInt("MKT_CARRIER_FL_NUM");
  //  origin = row.getString("ORIGIN");
  //  originCity = row.getString("ORIGIN_CITY_NAME");
  //  orginCityAbr = row.getString("ORIGIN_STATE_ABR");
    
  //  originAirportWAC = row.getInt("ORIGIN_WAC");
  //  destination = row.getString("DEST");
  //  destinationCity = row.getString("DEST_CITY_NAME");
  //  destinationWAC = row.getInt("DEST_WAC");
    
  //  ScheduledDepTime = row.getInt("CRS_DEP_TIME");
  //  ActDepTime = row.getInt("DEP_TIME");
    
  //  cancelled = row.getInt("CANCELLED");
  //  diverted = row.getInt("DIVERTED");
   
  //  distance = row.getInt("DISTANCE");
  //   //println(date.substring(0, 10) + " "+ carrier + " " + flightNumber + " " 
  //   // + origin + " (" + originCity + ") " + orginCityAbr + originAirportWAC);
  //}
      
     cancellationsMap = new HashMap<String, Double>();
     delaysMap = new HashMap<String, Double>();
     co2Map = new HashMap<String, Double>(); 
     ratings =  new TreeMap<String, Double>();
     weightedRatings = new TreeMap<String, Double>(); 
     
     //Creating objects for each data point 
     delaysHM = new heatMapMetrics("DIVERTED"); //<>//
     cancellationsHM = new heatMapMetrics("CANCELLED"); 
     Co2HM = new heatMapMetrics("DISTANCE");
     delaysHM.insertFrequencies();
     cancellationsHM.insertFrequencies();
     Co2HM.insertFrequencies(); 

     double[] cancellationData = getData("CANCELLED");
     DistributionMetrics cancellationsMetrics = new DistributionMetrics(cancellationData);
     cancellationsMean = cancellationsMetrics.calculateMean();
     cancellationsSD = cancellationsMetrics.calculateSD();
     
     double[] delaysData = getData("DIVERTED");
     DistributionMetrics delaysMetrics = new DistributionMetrics(delaysData);
     delaysMean = delaysMetrics.calculateMean();
     delaysSD = delaysMetrics.calculateSD();
     
     double[] distanceData = getData("DISTANCE");
     DistributionMetrics distanceMetrics = new DistributionMetrics(distanceData);
     double distanceMean = distanceMetrics.calculateMean();
     Co2Mean = distanceMetrics.calculateMean() * CO2_EMISSIONS;
     Co2SD = distanceMetrics.calculateSD() * CO2_EMISSIONS; 
     combineCancellations();
     combinedelays();
     combineCo2();
     calculateRating(); 
     
     //adjusting ratings to be relative 
     float[] ratingsArray = new float[10];
     int i = 0;
     for(String key:ratings.keySet()){
       float currRating = (float)(double)ratings.get(key);
       ratingsArray[i] = currRating; 
       i++; 
     }
     ratingsArray = sort(ratingsArray);  
     for(float curr: ratingsArray){
       println(curr);
     }
     for(int j = 0;j<ratingsArray.length-1;j++){
       String currAirline = airlineNames[j]; 
       float searchRating = (float)(double)ratings.get(currAirline); 
       int index = 0;
       for(int k = 0;k<ratingsArray.length-1;k++){
           if(ratingsArray[k] == searchRating) index = k;
       }
       Double newRating = ((double)index * 0.5)+1; 
       weightedRatings.put(currAirline, newRating);
     }
     
     for(String key: weightedRatings.keySet()){
         println(key + ":" + weightedRatings.get(key)); 
     }
     
     println("The following is a rating out of 5 for each airline"); 
    for(String key: ratings.keySet()){
      println(key + ":" + ratings.get(key));
    }
    
    println("Mean distance: " + Math.round(distanceMean) + " miles. ");
    //state with highest number of cancellations
    double highestFreq = 0;
    String highestState = ""; 
    for(String keys: cancellationsHM.frequencies.keySet()){
      if(cancellationsHM.frequencies.get(keys) > highestFreq) {
        highestFreq = cancellationsHM.frequencies.get(keys);
        highestState = keys; 
      }
    }
    println("The state with the highest number of cancellations is " + highestState + " with "+ highestFreq + " cancellations. ");
    
    
    //a = new widget (10, 15, 100, 40,
    //"FL_DATE", color(255),
    //font, FLIGHTDATE_BUTTON);
    
    //b = new widget (150, 15, 150, 40,
    //"MKT_CARRIER", color(255),
    //font, EVENT_BUTTON2);
    
    //screen1 = new screen (color(150), new ArrayList<widget>());
    //screen2 = new screen(color(150), new ArrayList<widget>());
    //screen1.addWidget(a, b);
    //screen2.addWidget(a, null);
    
    //screen = 1;
    
  
  // from here it displays it on a screen
  //int i = 0;
  // while (i < table.getRowCount()){ 
  //   for (TableRow row : table.rows()) { 
  //     date = row.getString("FL_DATE");
  //     date = date.substring(0, 10);
       
  //     carrier = row.getString("MKT_CARRIER");
       
  //     flightNumber = row.getInt("MKT_CARRIER_FL_NUM");
       
  //     origin = row.getString("ORIGIN");
       
  //     originCity = row.getString("ORIGIN_CITY_NAME");
       
  //     orginCityAbr = row.getString("ORIGIN_STATE_ABR");
       
  //     originAirportWAC = row.getInt("ORIGIN_WAC");
  //     destination = row.getString("DEST");
  //     destinationCity = row.getString("DEST_CITY_NAME");
  //     destinationWAC = row.getInt("DEST_WAC");
    
  //     ScheduledDepTime = row.getInt("CRS_DEP_TIME");
  //     ActDepTime = row.getInt("DEP_TIME");
    
  //     ScheduledArrTime = row.getInt("CRS_ARR_TIME");
  //     ActARRTime = row.getInt("ARR_TIME");
       
  //     cancelled = row.getInt("CANCELLED");
  //     diverted = row.getInt("DIVERTED");
   
  //     distance = row.getInt("DISTANCE");
  //     onOfVDistance[i] = distance;
       
  //     niceFont = loadFont("AdelleSansDevanagari-Regular-20.vlw");
       
       //someMessage[i] = new Display(date, niceFont);
       //someMessage2[i] = new Display(carrier, niceFont);
       //someMessage3[i] = new Display(flightNumber, niceFont);
       //someMessage4[i] = new Display(origin, niceFont);
       //someMessage5[i] = new Display(originCity, niceFont);
       //// someMessage6[i] = new Display(orginCityAbr, niceFont); // dont think we need this one
       //someMessage7[i] = new Display(originAirportWAC, niceFont);
       //someMessage8[i] = new Display(destination, niceFont);
       //someMessage9[i] = new Display(destinationCity, niceFont);
       //someMessage10[i] = new Display(destinationWAC, niceFont);
       //someMessage11[i] = new Display(ScheduledDepTime, niceFont);
       //someMessage12[i] = new Display(ActDepTime, niceFont);
       //someMessage13[i] = new Display(ScheduledArrTime, niceFont);
       //someMessage14[i] = new Display(ActARRTime, niceFont);
       //someMessage15[i] = new Display(destinationWAC, niceFont);
       
       //someMessage16[i] = new Display(distance, 0 , 0, niceFont);
       
       //someMessage17[i] = new Display(cancelled, 0, niceFont);
       //someMessage18[i] = new Display(diverted, 0, niceFont );
       //i++;
     }
   
   
  //michigan = usa.getChild("MI");
  //ohio = usa.getChild("OH");
  //massachusetts = usa.getChild("MA");
  //alabama = usa.getChild("AL");
  //alaska = usa.getChild("AK");  // 5
  //arizona = usa.getChild("AZ");  // 7
  //arkansas = usa.getChild("AR"); // 8
  //california = usa.getChild("CA"); //9
  //colorado = usa.getChild("CO"); // 10
  //connecticut = usa.getChild("CT"); // 11
  //delaware = usa.getChild("DE"); // 12
  //districtofColumbia = usa.getChild("DC"); //13
  //florida = usa.getChild("FL"); //14
  //georgia = usa.getChild("GA"); // 15
  //hawaii = usa.getChild("HI"); // 17
  //idaho = usa.getChild("ID");  // 18
  //illinois = usa.getChild("IL"); // 19
  //indiana = usa.getChild("IN"); // 20
  //iowa = usa.getChild("IA"); // 21
  //kansas = usa.getChild("KS"); // 22
  //kentucky = usa.getChild("KY"); //23
  //louisiana = usa.getChild("LA"); //24
  //maine = usa.getChild("ME"); // 25
  //maryland = usa.getChild("MD");
  //minnesota = usa.getChild("MN"); //27
  //mississippi = usa.getChild("MS");
  //missouri = usa.getChild("MO"); // 29
  //montana = usa.getChild("MT");
  //nebraska = usa.getChild("NE"); //31
  //nevada = usa.getChild("NV");
  //newHampshire = usa.getChild("NH"); //33
  //newJersey = usa.getChild("NJ");
  //newMexico = usa.getChild("NM"); // 35
  //newYork = usa.getChild("NY");
  //northCarolina = usa.getChild("NC"); //37
  //northDakota = usa.getChild("ND");
  //oklahoma = usa.getChild("OK");
  //oregon = usa.getChild("OR"); // 41
  //pennsylvania = usa.getChild("PA");
  //rhodeIsland = usa.getChild("RI"); // 45
  //southCarolina = usa.getChild("SC");
  //southDakota = usa.getChild("SD"); // 47
  //tennessee = usa.getChild("TN");
  //texas = usa.getChild("TX"); // 49
  //utah = usa.getChild("UT");
  //vermont = usa.getChild("VT"); // 51
  //virginia = usa.getChild("VA");
  //washington = usa.getChild("WA"); // 53
  //westVirginia = usa.getChild("WV");
  //wisconsin = usa.getChild("WI"); // 55
  //wyoming = usa.getChild("WY"); // 56

  //michiganWidget = new widget(michigan);
  //ohioWidget = new widget (ohio);
  //alabamaWidget = new widget (alabama);
  //alaskaWidget = new widget (alaska);
  //arizonaWidget = new widget (arizona);
  //arkansasWidget = new widget (arkansas);
  //californiaWidget = new widget (california);
  //coloradoWidget = new widget (colorado);
  //connecticutWidget = new widget (connecticut);
  //delawareWidget = new widget (delaware);
  //districtofColumbiaWidget = new widget (districtofColumbia);

  //floridaWidget = new widget (florida);
  //georgiaWidget = new widget (georgia);
  //hawaiiWidget = new widget (hawaii);
  //idahoWidget = new widget (idaho);
  //illinoisWidget = new widget (illinois);

  //indianaWidget = new widget (indiana);
  //iowaWidget = new widget (iowa);

  //kansasWidget = new widget (kansas);
  //kentuckyWidget = new widget (kentucky);

  //louisianaWidget = new widget (louisiana);
  //maineWidget = new widget (maine);
  //marylandWidget = new widget (maryland);
  //massachusettsWidget = new widget (massachusetts);
  //minnesotaWidget = new widget (minnesota);
  //mississippiWidget = new widget (mississippi);
  //missouriWidget = new widget (missouri);
  //montanaWidget = new widget (montana);
  //nebraskaWidget = new widget (nebraska);
  //nevadaWidget = new widget (nevada);
  //newHampshireWidget = new widget (newHampshire);
  //newJerseyWidget = new widget (newJersey);
  //newMexicoWidget = new widget (newMexico);
  //newYorkWidget = new widget (newYork);
  //northCarolinaWidget = new widget (northCarolina);
  //northDakotaWidget = new widget (northDakota);

  //oklahomaWidget = new widget (oklahoma);
  //oregonWidget = new widget (oregon);
  //pennsylvaniaWidget = new widget (pennsylvania);
  //rhodeIslandWidget = new widget (rhodeIsland);
  //southCarolinaWidget = new widget (southCarolina);
  //southDakotaWidget = new widget (southDakota);
  //tennesseeWidget = new widget (tennessee);
  //texasWidget = new widget (texas);
  //utahWidget = new widget (utah);
  //vermontWidget = new widget (vermont);
  //virginiaWidget = new widget (virginia);
  //washingtonWidget = new widget (washington);
  //westVirginiaWidget = new widget (westVirginia);
  //wisconsinWidget = new widget (wisconsin);
  //wyomingWidget = new widget (wyoming);
//}


  public void combineCancellations(){
      for(int i = 0;i<airlineNames.length;i++){
         double[] currData = getData("CANCELLED", airlineNames[i], "MKT_CARRIER"); //<>//
         AirlineMetrics currMetrics = new AirlineMetrics(currData, cancellationsMean, cancellationsSD, false);
         double currZScore = currMetrics.calculateZScore();
         cancellationsMap.put(airlineNames[i], currZScore); 
      }
  }
  
    public void combinedelays(){
      for(int i = 0;i<airlineNames.length;i++){
         double[] currData = getData("DIVERTED", airlineNames[i], "MKT_CARRIER"); //<>//
         AirlineMetrics currMetrics = new AirlineMetrics(currData, delaysMean, delaysSD, false);
         double currZScore = currMetrics.calculateZScore();
         delaysMap.put(airlineNames[i], currZScore); 
      }
  }
  
    public void combineCo2(){
      for(int i = 0;i<airlineNames.length;i++){
         double[] currData = getData("DISTANCE", airlineNames[i], "MKT_CARRIER"); //<>//
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
        //println(row.getInt(columnName));
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
        Double rating = (WEIGHT_1 * (co2Score) + WEIGHT_2 * cancScore + WEIGHT_3 * delaysScore) * 5/6 ; //<>//
        ratings.put(currAirline, rating); 
        //println(ratings.get(currAirline)); 
    }
  }
  
void draw() { 
  //for(String key: ratings.keySet()){ //<>//
  //    text(key + ":" + ratings.get(key), 5, 25);
  // }
}
   
   
   
  //text("Frequencies of cancellations by state: ", 5, 25); 
  //for(int i = 0;i<cancellationsHM.states.length;i++){
  //    String currState = cancellationsHM.states[i];
  //    //text(cancellationsHM.frequencies.get(currState), 20, 25+i);
  //}
  
  //line 289 - 333 display the message
  //background(255);
  //fill(0);
  //int tmp = i+2;
  //text("The flight date for the " + tmp + "th row in the table is: ", 5, 25);
  //someMessage[i].draw(770, 25);
  //text("The Carrier Initials for the " + tmp + "th row in the table is: ", 5, 75);
  //someMessage2[i].draw(770, 75);
  //text("The flight number for the " + tmp + "th row in the table is: ", 5, 125);
  //someMessage3[i].draw(770, 125);
  //text("The orgin airport's initials for the " + tmp + "th row in the table is: ", 5, 175);
  //someMessage4[i].draw(770, 175);
  //text("The orgin city for the " + tmp + "th row in the table is: ", 5, 225);
  //someMessage5[i].draw(770, 225);
  
  //text("The World Area Code of orgin airport for the " + tmp + "th row in the table is: ", 5, 275);
  //someMessage7[i].draw(770, 275);
  //text("The destination airport's initials  " + tmp + "th row in the table is: ", 5, 325);
  //someMessage8[i].draw(770, 325);
  //text("The destination city for the " + tmp + "th row in the table is: ", 5, 375);
  //someMessage9[i].draw(770, 375);
  //text("The World Area Code of destination airport " + tmp + "th row in the table is: ", 5, 425);
  //someMessage10[i].draw(770, 425);
  
  //text("The Scheduled Dep. time for the " + tmp + "th row in the table is: ", 5, 475);
  //someMessage11[i].draw(770, 475);
  //text("The Actual Dep. time for the " + tmp + "th row in the table is: ", 5, 525);
  //someMessage12[i].draw(770, 525);
  //text("The Scheduled Arr. time for the " + tmp + "th row in the table is: ", 5, 575);
  //someMessage13[i].draw(770, 575);
  //text("The Actual Arr. time for the " + tmp + "th row in the table is: ", 5, 625);
  //someMessage14[i].draw(770, 625);
  
  //text("The World Area Code of destination airport for the " + tmp + " th row in the table is: ", 5, 675);
  //someMessage15[i].draw(770, 675);
  
  //text("The distance of flight in the " + tmp + "th row in the table is: ", 5, 725);
  //someMessage16[i].draw(770, 725);
  
  //text("The flight in the " + tmp + "th row in the table is cancelled: ", 5, 775);
  //someMessage17[i].draw(770, 775);
  //text("The flight in the " + tmp + "th row in the table is diverted: ", 5, 825);
  //someMessage18[i].draw(770, 825);
  //i++;
  //frameRate(1);
  
  
  
  //line 338 - 388 draws the map
  //ohioWidget.draw(ohio);
  //michiganWidget.draw(michigan);
  //alabamaWidget.draw(alabama);
  //alaskaWidget.draw(alaska);
  //arizonaWidget.draw(arizona);
  //arkansasWidget.draw(arkansas);
  //californiaWidget.draw(california);
  //coloradoWidget.draw(colorado);
  //connecticutWidget.draw(connecticut);
  //delawareWidget.draw(delaware);
  //districtofColumbiaWidget.draw(districtofColumbia);
  //floridaWidget.draw(florida);
  //georgiaWidget.draw(georgia);
  //hawaiiWidget.draw(hawaii);
  //idahoWidget.draw(idaho);
  //illinoisWidget.draw(illinois);
  //indianaWidget.draw(indiana);
  //iowaWidget.draw(iowa);
  //kansasWidget.draw(kansas);
  //kentuckyWidget.draw(kentucky);
  //louisianaWidget.draw(louisiana);
  //maineWidget.draw(maine);
  //marylandWidget.draw(maryland);
  //massachusettsWidget.draw(massachusetts);
  //minnesotaWidget.draw(minnesota);
  //mississippiWidget.draw(mississippi);
  //missouriWidget.draw(missouri);
  //montanaWidget.draw(montana);
  //nebraskaWidget.draw(nebraska);
  //nevadaWidget.draw(nevada);
  //newHampshireWidget.draw(newHampshire);
  //newJerseyWidget.draw(newJersey);
  //newMexicoWidget.draw(newMexico);
  //newYorkWidget.draw(newYork);
  //northCarolinaWidget.draw(northCarolina);
  //northDakotaWidget.draw(northDakota);
  //oklahomaWidget.draw(oklahoma);
  //oregonWidget.draw(oregon);
  //pennsylvaniaWidget.draw(pennsylvania);
  //rhodeIslandWidget.draw(rhodeIsland);
  //southCarolinaWidget.draw(southCarolina);
  //southDakotaWidget.draw(southDakota);
  //tennesseeWidget.draw(tennessee);
  //texasWidget.draw(texas);
  //utahWidget.draw(utah);
  //vermontWidget.draw(vermont);
  //virginiaWidget.draw(virginia);
  //washingtonWidget.draw(washington);
  //westVirginiaWidget.draw(westVirginia);
  //wisconsinWidget.draw(wisconsin);
  //wyomingWidget.draw(wyoming);
  
  
  
  // line 393 - 415 draw the bar chart (if someone has a better one we can replace mine one)
  //int gap = 0;
  //background(255);
  //textSize(20);
  //fill(0);
  //line(100, 0, 100, 1000);
  //text("distance (10m) , starting from 0, 100, 200.. ", 200, 10, 500, 320); // each gap is 100
  //line(100, height/10, 1000, height/10);
  //fill(0);
  //text("number of rows", 0, 40, 100, 320); // each box / line (when there is a lot of boxes) represents a column in the sheet

  //fill(255);
  //for (int i = 0; i < table.getRowCount(); i++) {
  //  line(100 + gap, 70, 100 + gap, 90);
  //  gap = gap + 10;
  //}

  //for (int i = 0; i < 10; i++){
  //  chart[i] = onOfVDistance[i]/10;
  //}

  //for (int i = 0; i < 10; i++){
  //  rect(100, (i*height/10) + height/10, chart[i], height/10);
  //}

  //  below is not important
  //if (screen == 1){
  //  screen1.draw();
  //}
  //else {
  //  screen2.draw();
  //}
  //a.draw();
  //b.draw();
//}

void mousePressed() {
  noLoop();
  //int event;
  //if (screen ==1){
  //  event = screen1.getEvent(mouseX, mouseY);
  //      switch(event) {
  //  case FLIGHTDATE_BUTTON:
  //    screen = 0;
  //    println("button 1 is pressed");
  //    break;
  //  case EVENT_BUTTON3:
  //    println("forward is pressed");
  //    break;
  //  }
  //}
  //else {
  //  event = screen2.getEvent(mouseX, mouseY);
  //  switch(event) {
  //  case EVENT_BUTTON2:
  //    println("button 2 is pressed");
  //    break;
  //  case EVENT_BUTTON4:
  //    screen = 1;
  //    println("backward is pressed");
  //    break;
  //  }
  //}
}

void mouseReleased() {
  loop();
}
