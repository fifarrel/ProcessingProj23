
// this tab just contain the initialisation of variables 

void settings() {
   size (screenWidth, screenHeight);
}
void setup() {
  
  screen = 0;
  background (255);
  table = loadTable("flights2k(1).csv", "header");
  println(table.getRowCount() + " total rows in table");
  usa = loadShape("us.svg");
  titleFont = loadFont("AdelleSansDevanagari-Regular-48.vlw");
  textFont(titleFont);
   
  plane = loadImage("airplane.gif"); 
  plane.resize(50, 50); 
  statesWidArray = new widget[51];
  delaysArray = new widget[51];
  cancellationsA = new widget[51]; 
        
     cancellationsMap = new HashMap<String, Double>();
     delaysMap = new HashMap<String, Double>();
     co2Map = new HashMap<String, Double>(); 
     ratings =  new TreeMap<String, Double>();
     weightedRatings = new TreeMap<String, Double>(); 
     
     //Creating objects for each data point 

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
     println("The following is a rating out of 5 for each airline");
     float[] ratingsArray = new float[10];
     int t = 0;
     for(String key:ratings.keySet()){
       float currRating = (float)(double)ratings.get(key);
       ratingsArray[t] = currRating; 
       t++; 
     }
     ratingsArray = sort(ratingsArray);  

     for(int j = 0;j<ratingsArray.length-1;j++){
       String currAirline = airlineNames[j]; 
       float searchRating = (float)(double)ratings.get(currAirline); 
       int index = 0;
       for(int k = 0;k<ratingsArray.length-1;k++){
           if(ratingsArray[k] == searchRating) index = k;
       }
       Double newRating = (((double)index * 0.5)+1) /5;
       weightedRatings.put(currAirline, newRating);
     }
     
     for(String key: weightedRatings.keySet()){
         println(key + ":" + weightedRatings.get(key)); 
     }
     
    //background gif is made here, using a splitter on online, I am able to turn a gif to our background
    // YCZ
    numberOfFrames = 61;
    background = new PImage [numberOfFrames];
    backG = new ArrayList();
    int p = 0;
    while (p < numberOfFrames)
    {
      background[p] = loadImage("frame_"+p+"_delay-0.07s.gif");
      backG.add(background[p]);
      p++;
    }
    double [] distanceData1 = getData("DISTANCE");
    histogram = new Histogram(distanceData1);
    
    histogram.calculateHistogram();
   
    //println("Mean distance: " + Math.round(distanceMean) + " miles. ");
    ////state with highest number of cancellations
    //double highestFreq = 0;
    //String highestState = ""; 
    //int count = 0;
    //for(String keys: cancellationsHM.frequencies.keySet()){
    //  println(keys); 
    //  count++;
    //  if(cancellationsHM.frequencies.get(keys) > highestFreq) {
    //    highestFreq = cancellationsHM.frequencies.get(keys);
    //    highestState = keys; 
    //  }
    //}
    //println(count);
    //println("The state with the highest number of cancellations is " + highestState + " with "+ highestFreq + " cancellations. ");
    
    //for(String HMKey:Co2HM.frequencies.keySet()){
    //  println(HMKey + ":" + Co2HM.frequencies.get(HMKey));
    //}
  
  //someMessage =  new Display[table.getRowCount()];
  //someMessage2 = new Display[table.getRowCount()];
  //someMessage3 = new Display[table.getRowCount()];
  //someMessage4 = new Display[table.getRowCount()];
  //someMessage5 = new Display[table.getRowCount()];
  //someMessage6 = new Display[table.getRowCount()];
  //someMessage7 = new Display[table.getRowCount()];
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
  //message = new Message();
  
  int i = 0;
  // get the data from the csv file
   while (i < table.getRowCount()){ 
     for (TableRow row : table.rows()) { 
       date = row.getString("FL_DATE");
       date = date.substring(0, 10);
       carrier = row.getString("MKT_CARRIER");
       flightNumber = row.getInt("MKT_CARRIER_FL_NUM");
       origin = row.getString("ORIGIN");
       originCity = row.getString("ORIGIN_CITY_NAME");
       orginCityAbr = row.getString("ORIGIN_STATE_ABR");
       originAirportWAC = row.getInt("ORIGIN_WAC");
       destination = row.getString("DEST");
       destinationCity = row.getString("DEST_CITY_NAME");
       destinationWAC = row.getInt("DEST_WAC");
       ScheduledDepTime = row.getInt("CRS_DEP_TIME");
       ActDepTime = row.getInt("DEP_TIME");
       ScheduledArrTime = row.getInt("CRS_ARR_TIME");
       ActARRTime = row.getInt("ARR_TIME");
       cancelled = row.getInt("CANCELLED");
       diverted = row.getInt("DIVERTED");
       distance = row.getInt("DISTANCE");
       onOfVDistance[i] = distance;
       niceFont = loadFont("AdelleSansDevanagari-Regular-20.vlw");
       
       //someMessage[i] = new Display(date, niceFont);
       //someMessage2[i] = new Display(carrier, niceFont);
       //someMessage3[i] = new Display(flightNumber, niceFont);
       //someMessage4[i] = new Display(origin, niceFont);
       //someMessage5[i] = new Display(originCity, niceFont);
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
       i++;
     }
   }
  // assign each state as PImages
  michigan = usa.getChild("MI");
  ohio = usa.getChild("OH");
  massachusetts = usa.getChild("MA");
  alabama = usa.getChild("AL");
  alaska = usa.getChild("AK");  // 5
  arizona = usa.getChild("AZ");  // 7
  arkansas = usa.getChild("AR"); // 8
  california = usa.getChild("CA"); //9
  colorado = usa.getChild("CO"); // 10
  connecticut = usa.getChild("CT"); // 11
  delaware = usa.getChild("DE"); // 12
  districtofColumbia = usa.getChild("DC"); //13
  florida = usa.getChild("FL"); //14
  georgia = usa.getChild("GA"); // 15
  hawaii = usa.getChild("HI"); // 17
  idaho = usa.getChild("ID");  // 18
  illinois = usa.getChild("IL"); // 19
  indiana = usa.getChild("IN"); // 20
  iowa = usa.getChild("IA"); // 21
  kansas = usa.getChild("KS"); // 22
  kentucky = usa.getChild("KY"); //23
  louisiana = usa.getChild("LA"); //24
  maine = usa.getChild("ME"); // 25
  maryland = usa.getChild("MD");
  minnesota = usa.getChild("MN"); //27
  mississippi = usa.getChild("MS");
  missouri = usa.getChild("MO"); // 29
  montana = usa.getChild("MT");
  nebraska = usa.getChild("NE"); //31
  nevada = usa.getChild("NV");
  newHampshire = usa.getChild("NH"); //33
  newJersey = usa.getChild("NJ");
  newMexico = usa.getChild("NM"); // 35
  newYork = usa.getChild("NY");
  northCarolina = usa.getChild("NC"); //37
  northDakota = usa.getChild("ND");
  oklahoma = usa.getChild("OK");
  oregon = usa.getChild("OR"); // 41
  pennsylvania = usa.getChild("PA");
  rhodeIsland = usa.getChild("RI"); // 45
  southCarolina = usa.getChild("SC");
  southDakota = usa.getChild("SD"); // 47
  tennessee = usa.getChild("TN");
  texas = usa.getChild("TX"); // 49
  utah = usa.getChild("UT");
  vermont = usa.getChild("VT"); // 51
  virginia = usa.getChild("VA");
  washington = usa.getChild("WA"); // 53
  westVirginia = usa.getChild("WV");
  wisconsin = usa.getChild("WI"); // 55
  wyoming = usa.getChild("WY"); // 56


// using the PImages to create widgets 
statesWidArray[0] = new widget(michigan, 150, "Michigan", "MI");
statesWidArray[1] = new widget (ohio, 195, "Ohio", "OH");
statesWidArray[2] = new widget (alabama, 210, "Alabama", "AL");
statesWidArray[3] = new widget (alaska, 93, "Alaska", "AK");
statesWidArray[4] = new widget (arizona, 94, "Arizona", "AZ");
statesWidArray[5] = new widget (arkansas, 246, "Arkansas", "AR");
statesWidArray[6] = new widget (california, 20, "California", "CA");
statesWidArray[7] = new widget (colorado, 134, "Colorado", "CO");
statesWidArray[8] = new widget (connecticut, 169, "Connecticut", "CT");
statesWidArray[9] = new widget (delaware, 99, "Delaware", "DE");
statesWidArray[10] = new widget (districtofColumbia, 100, "District of Columbia", "DC");
statesWidArray[11] = new widget (florida, 55, "Florida", "FL");
statesWidArray[12] = new widget (georgia, 102, "Georgia", "GA");
statesWidArray[13] = new widget (hawaii, 30, "Hawaii", "HI");
statesWidArray[14] = new widget (idaho, 180, "Idaho", "ID");
statesWidArray[15] = new widget (illinois, 105, "Illinois", "IL");
statesWidArray[16] = new widget (indiana, 197, "Indiana", "IN");
statesWidArray[17] = new widget (iowa, 245, "Iowa", "IA");
statesWidArray[18] = new widget (kansas, 230, "Kansas", "KS");
statesWidArray[19] = new widget (kentucky, 188, "Kentucky", "KY");
statesWidArray[20] = new widget (louisiana, 240, "Louisiana", "LA");
statesWidArray[21] = new widget (maine, 238, "Maine", "ME");
statesWidArray[22] = new widget (maryland, 192, "Maryland", "MD");
statesWidArray[23] = new widget (massachusetts, 113, "Massachusetts", "MA");
statesWidArray[24] = new widget (minnesota, 174, "Minnesota", "MN");
statesWidArray[25] = new widget (mississippi, 242, "Mississippi", "MS");
statesWidArray[26] = new widget (missouri, 236, "Missouri", "MO");
statesWidArray[27] = new widget (montana, 200, "Montana", "MT");
statesWidArray[28] = new widget (nebraska, 220, "Nebraska", "NE");
statesWidArray[29] = new widget (nevada, 60, "Nevada", "NV");
statesWidArray[30] = new widget (newHampshire, 229, "New Hampshire", "NH");
statesWidArray[31] = new widget (newJersey, 121, "New Jersey", "NJ");
statesWidArray[32] = new widget (newMexico, 182, "New Mexico", "NM");
statesWidArray[33] = new widget (newYork, 50, "New York", "NY");
statesWidArray[34] = new widget (northCarolina, 124, "North Carolina", "NC");
statesWidArray[35] = new widget (northDakota, 222, "North Dakota", "NK");
statesWidArray[36] = new widget (oklahoma, 232, "Oklahoma", "OK");
statesWidArray[37] = new widget (oregon, 127, "Oregon", "OR");
statesWidArray[38] = new widget (pennsylvania, 128, "Pennsylvania", "PA");
statesWidArray[39] = new widget (rhodeIsland, 249, "Rhode Island", "RI");
statesWidArray[40] = new widget (southCarolina, 130, "South Carolina", "SC");
statesWidArray[41]= new widget (southDakota, 224, "South Dakota", "SD");
statesWidArray[42] = new widget (tennessee, 132, "Tennessee", "TN");
statesWidArray[43] = new widget (texas, 123, "Texas", "TX");
statesWidArray[44] = new widget (utah, 178, "Utah", "UT");
statesWidArray[45] = new widget (vermont, 241, "Vermont", "VT");
statesWidArray[46] = new widget (virginia, 86, "Virginia", "VA");
statesWidArray[47] = new widget (washington, 46, "Washington", "WA");
statesWidArray[48] = new widget (westVirginia, 235, "West Virginia", "WV");
statesWidArray[50]= new widget (wisconsin, 139, "Wisconsin", "WI");
statesWidArray[49] = new widget (wyoming, 243, "Wyoming", "WY");
  
  String[] originArray = new String[51];
  int s = 0;
  for(widget w:statesWidArray){
    originArray[s] = w.origin;
    s++;
  }
     delaysHM = new heatMapMetrics("DIVERTED", originArray);
     cancellationsHM = new heatMapMetrics("CANCELLED", originArray); 
     Co2HM = new heatMapMetrics("DISTANCE", originArray);
     delaysHM.insertFrequencies();
     
     println(delaysHM.frequencies.get("AA")); 
     
     cancellationsHM.insertFrequencies();
     Co2HM.insertFrequencies(); 
     

  map = new Map(statesWidArray); 
  
  titleWidget = new widget(325, 40, 400, 100, 1, "", color(#123266), color(#123266), (1), titleFont);
  triangleWidget1 = new widget(950, 425, 950, 475, 975, 450, 1, color(#123266));
  triangleWidget2 = new widget(50, 425, 50, 475, 25, 450, 1, color(#123266));
  carrierWid1 = new widget(100, 200, 200, 125, 2, "American\nAirlines", color(#123266), color(#166bba), (0), titleFont);
  carrierWid2 = new widget(400, 200, 200, 125, 2, "Alaskan\nAirlines", color(#123266), color(#166bba), (0), titleFont);
  carrierWid3 = new widget(700, 200, 200, 125, 2, "JetBlue", color(#123266), color(#166bba), (0), titleFont);
  carrierWid4 = new widget(100, 358, 200, 125, 2, "Hawiian\nAirlines", color(#123266), color(#166bba), (0), titleFont);
  carrierWid5 = new widget(400, 358, 200, 125, 2, "Spirit", color(#123266), color(#166bba), (0), titleFont);
  carrierWid6 = new widget(700, 358, 200, 125, 2, "Allegiant\nAir", color(#123266), color(#166bba), (0), titleFont);
  carrierWid7 = new widget(100, 516, 200, 125, 2, "Southwest\nAirlines", color(#123266), color(#166bba), (0), titleFont);
  carrierWid8 = new widget(400, 516, 200, 125, 2, "Frontier\nAirlines", color(#123266), color(#166bba), (0), titleFont);
  carrierWid9 = new widget(700, 516, 200, 125, 2, "United\nAirlines", color(#123266), color(#166bba), (0), titleFont);
  carrierWid11 = new widget(400, 674, 200, 125, 2, "Delta", color(#123266), color(#166bba), (0), titleFont);
  messageWidget = new widget(20, 30, 50, 50, 2, "Press", color(0), color(255), 0, titleFont); 
  
  trustRatingWid1 = new widget(600, 20, 150, 40, RATINGTYPE1, "", color(#4287f5), titleFont);
  trustRatingWid2 = new widget(650, 70, 150, 40, RATINGTYPE1, "", color(#4287f5), titleFont);
  trustRatingWid3 = new widget(700, 120, 150, 40, RATINGTYPE1, "", color(#4287f5), titleFont);
  
  carrierWidgets = new ArrayList();
  carrierWidgets.add(carrierWid1);
  carrierWidgets.add(carrierWid2);
  carrierWidgets.add(carrierWid3);
  carrierWidgets.add(carrierWid4);
  carrierWidgets.add(carrierWid5);
  carrierWidgets.add(carrierWid6);
  carrierWidgets.add(carrierWid7);
  carrierWidgets.add(carrierWid8);
  carrierWidgets.add(carrierWid9);
  carrierWidgets.add(carrierWid11);
  carrierWidgets.add(titleWidget);

  carrierWidgets.add(triangleWidget1);
  carrierWidgets.add(triangleWidget2);
  
//  println(statesWidArray.length);
states = new ArrayList();
//widget[] copy = statesWidArray; 
for(int k = 0;k<statesWidArray.length;k++){
  states.add(statesWidArray[k]); 
}
states.add(triangleWidget1); 
states.add(triangleWidget2); 

delaysStates = new ArrayList(); 
delaysArray[0] = new widget(michigan, color(224, 158, 105), "Michigan", "MI");
delaysArray[1] = new widget (ohio, color(205, 138, 73), "Ohio", "OH");
delaysArray[2] = new widget (alabama, color(222, 158, 103), "Alabama", "AL");
delaysArray[3] = new widget (alaska, color(117, 46, 1), "Alaska", "AK");
delaysArray[4] = new widget (arizona, color(204, 88, 11), "Arizona", "AZ");
delaysArray[5] = new widget (arkansas, color(221, 160, 105), "Arkansas", "AR");
delaysArray[6] = new widget (california, color(203, 158, 105), "California", "CA");
delaysArray[7] = new widget (colorado, color(220, 155, 105), "Colorado", "CO");
delaysArray[8] = new widget (connecticut, color(240, 158, 102), "Connecticut", "CT");
delaysArray[9] = new widget (delaware, color(230, 154, 105), "Delaware", "DE");
delaysArray[10] = new widget (districtofColumbia, color(241, 153, 105), "District of Columbia", "DC");
delaysArray[11] = new widget (florida, color(199, 158, 105), "Florida", "FL");
delaysArray[12] = new widget (georgia, color(215, 158, 109), "Georgia", "GA");
delaysArray[13] = new widget (hawaii, color(236, 158, 105), "Hawaii", "HI");
delaysArray[14] = new widget (idaho, color(225, 158, 105), "Idaho", "ID");
delaysArray[15] = new widget (illinois, color(208, 88, 8), "Illinois", "IL");
delaysArray[16] = new widget (indiana, color(250, 158, 105), "Indiana", "IN");
delaysArray[17] = new widget (iowa, color(239, 158, 99), "Iowa", "IA");
delaysArray[18] = new widget (kansas, color(248, 158, 105), "Kansas", "KS");
delaysArray[19] = new widget (kentucky, color(217, 168, 105), "Kentucky", "KY");
delaysArray[20] = new widget (louisiana, color(253, 158, 113), "Louisiana", "LA");
delaysArray[21] = new widget (maine, color(254, 159, 105), "Maine", "ME");
delaysArray[22] = new widget (maryland, color(218, 158, 112), "Maryland", "MD");
delaysArray[23] = new widget (massachusetts, color(231, 155, 106), "Massachusetts", "MA");
delaysArray[24] = new widget (minnesota, color(252, 148, 105), "Minnesota", "MN");
delaysArray[25] = new widget (mississippi, color(243, 158, 107), "Mississippi", "MS");
delaysArray[26] = new widget (missouri, color(226, 159, 106), "Missouri", "MO");
delaysArray[27] = new widget (montana, color(209, 155, 103), "Montana", "MT");
delaysArray[28] = new widget (nebraska, color(247, 158, 103), "Nebraska", "NE");
delaysArray[29] = new widget (nevada, color(219, 157, 109), "Nevada", "NV");
delaysArray[30] = new widget (newHampshire, color(200, 158, 109), "New Hampshire", "NH");
delaysArray[31] = new widget (newJersey, color(242, 158, 109), "New Jersey", "NJ");
delaysArray[32] = new widget (newMexico, color(245, 155, 105), "New Mexico", "NM");
delaysArray[33] = new widget (newYork, color(168, 71, 10), "New York", "NY");
delaysArray[34] = new widget (northCarolina, color(241, 158, 107), "North Carolina", "NC");
delaysArray[35] = new widget (northDakota, color(251, 158, 111), "North Dakota", "NK");
delaysArray[36] = new widget (oklahoma, color(229, 168, 104), "Oklahoma", "OK");
delaysArray[37] = new widget (oregon,color(210, 158, 105), "Oregon", "OR");
delaysArray[38] = new widget (pennsylvania, color(246, 153, 105), "Pennsylvania", "PA");
delaysArray[39] = new widget (rhodeIsland, color(232, 158, 101), "Rhode Island", "RI");
delaysArray[40] = new widget (southCarolina, color(227, 157, 102), "South Carolina", "SC");
delaysArray[41] = new widget (southDakota, color(235, 156, 105), "South Dakota", "SD");
delaysArray[42] = new widget (tennessee, color(233, 154, 105), "Tennessee", "TN");
delaysArray[43] = new widget (texas, color(197, 86, 9), "Texas", "TX");
delaysArray[44] = new widget (utah, color(255, 156, 110), "Utah", "UT");
delaysArray[45] = new widget (vermont, color(230, 155, 105), "Vermont", "VT");
delaysArray[46] = new widget (virginia, color(228, 159, 105), "Virginia", "VA");
delaysArray[47] = new widget (washington, color(206, 88, 13), "Washington", "WA");
delaysArray[48] = new widget (westVirginia, color(237, 154, 106), "West Virginia", "WV");
delaysArray[50]= new widget (wisconsin, color(207, 88, 10), "Wisconsin", "WI");
delaysArray[49] = new widget (wyoming, color(244, 151, 108), "Wyoming", "WY"); 
 
 
  for(int k = 0;k<delaysArray.length;k++){
    delaysStates.add(delaysArray[k]);
  }
  delaysStates.add(triangleWidget1); 
  delaysStates.add(triangleWidget2); 
 
 
 //creating cancellations array 
 cancellationsStates = new ArrayList(); 
 //3rd map 
cancellationsA[0] = new widget(michigan, color(237, 109, 97), "Michigan", "MI");
cancellationsA[1] = new widget (ohio, color(237, 114, 97), "Ohio", "OH");
cancellationsA[2] = new widget (alabama, color(237, 83, 97), "Alabama", "AL");
cancellationsA[3] = new widget (alaska, color(153, 27, 15), "Alaska", "AK");
cancellationsA[4] = new widget (arizona, color(209, 56, 36), "Arizona", "AZ");
cancellationsA[5] = new widget (arkansas, color(237, 86, 97), "Arkansas", "AR");
cancellationsA[6] = new widget (california, color(153, 25, 15), "California", "CA");
cancellationsA[7] = new widget (colorado, color(242, 35, 10), "Colorado", "CO");
cancellationsA[8] = new widget (connecticut, color(237, 64, 38), "Connecticut", "CT");
cancellationsA[9] = new widget (delaware, color(237, 61, 38), "Delaware", "DE");
cancellationsA[10] = new widget (districtofColumbia, color(237, 60, 38), "District of Columbia", "DC");
cancellationsA[11] = new widget (florida, color(242, 19, 10), "Florida", "FL");
cancellationsA[12] = new widget (georgia, color(209, 59, 36), "Georgia", "GA");
cancellationsA[13] = new widget (hawaii, color(242, 29, 10), "Hawaii", "HI");
cancellationsA[14] = new widget (idaho, color(237, 118, 97), "Idaho", "ID");
cancellationsA[15] = new widget (illinois, color(242, 26, 10), "Illinois", "IL");
cancellationsA[16] = new widget (indiana, color(237, 84, 97), "Indiana", "IN");
cancellationsA[17] = new widget (iowa, color(237, 57, 38), "Iowa", "IA");
cancellationsA[18] = new widget (kansas, color(237, 88, 97), "Kansas", "KS");
cancellationsA[19] = new widget (kentucky, color(237, 115, 97), "Kentucky", "KY");
cancellationsA[20] = new widget (louisiana, color(237, 113, 97), "Louisiana", "LA");
cancellationsA[21] = new widget (maine, color(237, 112, 97), "Maine", "ME");
cancellationsA[22] = new widget (maryland, color(237, 108, 97), "Maryland", "MD");
cancellationsA[23] = new widget (massachusetts, color(242, 54, 10), "Massachusetts", "MA");
cancellationsA[24] = new widget (minnesota, color(237, 110, 97), "Minnesota", "MN");
cancellationsA[25] = new widget (mississippi, color(237, 111, 97), "Mississippi", "MS");
cancellationsA[26] = new widget (missouri, color(237, 89, 97), "Missouri", "MO");
cancellationsA[27] = new widget (montana, color(209, 53, 36), "Montana", "MT");
cancellationsA[28] = new widget (nebraska, color(237, 91, 97), "Nebraska", "NE");
cancellationsA[29] = new widget (nevada, color(242, 31, 10), "Nevada", "NV");
cancellationsA[30] = new widget (newHampshire, color(237, 92, 97), "New Hampshire", "NH");
cancellationsA[31] = new widget (newJersey, color(237, 93, 97), "New Jersey", "NJ");
cancellationsA[32] = new widget (newMexico, color(237, 94, 97), "New Mexico", "NM");
cancellationsA[33] = new widget (newYork, color(242, 33, 10), "New York", "NY");
cancellationsA[34] = new widget (northCarolina, color(209, 51, 36), "North Carolina", "NC");
cancellationsA[35] = new widget (northDakota, color(237, 96, 97), "North Dakota", "NK");
cancellationsA[36] = new widget (oklahoma, color(237, 85, 97), "Oklahoma", "OK");
cancellationsA[37] = new widget (oregon,color(242, 30, 10), "Oregon", "OR");
cancellationsA[38] = new widget (pennsylvania, color(209, 71, 36), "Pennsylvania", "PA");
cancellationsA[39] = new widget (rhodeIsland, color(237, 97, 97), "Rhode Island", "RI");
cancellationsA[40] = new widget (southCarolina, color(237, 98, 97), "South Carolina", "SC");
cancellationsA[41]= new widget (southDakota, color(237, 99, 97), "South Dakota", "SD");
cancellationsA[42] = new widget (tennessee, color(237, 100, 97), "Tennessee", "TN");
cancellationsA[43] = new widget (texas, color(242, 28, 10), "Texas", "TX");
cancellationsA[44] = new widget (utah, color(237, 101, 97), "Utah", "UT");
cancellationsA[45] = new widget (vermont, color(237, 102, 97), "Vermont", "VT");
cancellationsA[46] = new widget (virginia, color(209, 50, 36), "Virginia", "VA");
cancellationsA[47] = new widget (washington, color(171, 24, 10), "Washington", "WA");
cancellationsA[48] = new widget (westVirginia, color(237, 107, 97), "West Virginia", "WV");
cancellationsA[50]= new widget (wisconsin, color(237, 106, 97), "Wisconsin", "WI");
cancellationsA[49] = new widget (wyoming, color(237, 105, 97), "Wyoming", "WY"); 

for(int k = 0;k<cancellationsA.length;k++){
  cancellationsStates.add(cancellationsA[k]); 
}
cancellationsStates.add(triangleWidget1); 
cancellationsStates.add(triangleWidget2); 


empty = new ArrayList();
empty.add(triangleWidget1); 
empty.add(triangleWidget2); 
  mainScreen = new screen(255, carrierWidgets, backG);
  mapScreen = new screen (255, states, backG);
  mapScreen2 = new screen(255, delaysStates, backG); 
  mapScreen3 = new screen(255, cancellationsStates, backG); 
  sourceScreen = new screen (255, empty, backG);
  creditScreen = new screen(255, empty, backG);
  histoScreen = new screen(histogram, empty, backG);
  
}
