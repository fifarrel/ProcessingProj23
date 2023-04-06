import java.util.*;
Table table;
String date, carrier, origin, originCity, orginCityAbr,
  destination, destinationCity, destinationStateAbr;
int flightNumber, originAirportWAC, destinationWAC, ScheduledDepTime, ActDepTime, ScheduledArrTime,
  ActARRTime, distance, diverted, cancelled, screen, i, flightDelay;
screen mainScreen, mapScreen;
double Co2Mean, delaysMean, cancellationsMean, Co2SD, delaysSD, cancellationsSD;
float trustRating;
PShape usa, triangle;
PFont font, niceFont, titleFont, dataFont;
ArrayList carrierWidgets, states;
float [] chart = new float [2000];
int [] onOfVDistance = new int [2000];
//z scores for each airline
HashMap<String, Double> co2Map, delaysMap, cancellationsMap;
String[] airlineNames = {"AA", "AS", "B6", "HA", "NK", "G4", "WN", "F9", "UA", "DL"};
//ratings for each airline
TreeMap<String, Double> ratings, weightedRatings;
heatMapMetrics delaysHM, cancellationsHM, Co2HM;

widget titleWidget, triangleWidget1, triangleWidget2,
  carrierWid1, carrierWid2, carrierWid3, carrierWid4,
  carrierWid5, carrierWid6, carrierWid7, carrierWid8, carrierWid9, carrierWid10, carrierWid11, carrierWid12, trustRatingWid1, trustRatingWid2, trustRatingWid3, statesWidArray[];
Message message;
Map map;

void setup() {

  size (1000, 835);
  background (255);
  table = loadTable("flights2k(1).csv", "header");
  println(table.getRowCount() + " total rows in table");
  usa = loadShape("us.svg");
  titleFont = loadFont("AdelleSansDevanagari-Regular-48.vlw");
  dataFont = loadFont("Arial-ItalicMT-15.vlw");


  statesWidArray = new widget[51];

  cancellationsMap = new HashMap<String, Double>();
  delaysMap = new HashMap<String, Double>();
  co2Map = new HashMap<String, Double>();
  ratings =  new TreeMap<String, Double>();
  weightedRatings = new TreeMap<String, Double>();

  //Creating objects for each data point
  delaysHM = new heatMapMetrics("DIVERTED");
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
  println("The following is a rating out of 5 for each airline");
  float[] ratingsArray = new float[10];
  int t = 0;
  for (String key : ratings.keySet()) {
    float currRating = (float)(double)ratings.get(key);
    ratingsArray[t] = currRating;
    t++;
  }
  ratingsArray = sort(ratingsArray);

  for (int j = 0; j<ratingsArray.length-1; j++) {
    String currAirline = airlineNames[j];
    float searchRating = (float)(double)ratings.get(currAirline);
    int index = 0;
    for (int k = 0; k<ratingsArray.length-1; k++) {
      if (ratingsArray[k] == searchRating) index = k;
    }
    Double newRating = (((double)index * 0.5)+1) /5;
    weightedRatings.put(currAirline, newRating);
  }

  for (String key : weightedRatings.keySet()) {
    println(key + ":" + weightedRatings.get(key));
  }


  println("Mean distance: " + Math.round(distanceMean) + " miles. ");
  //state with highest number of cancellations
  double highestFreq = 0;
  String highestState = "";
  for (String keys : cancellationsHM.frequencies.keySet()) {
    if (cancellationsHM.frequencies.get(keys) > highestFreq) {
      highestFreq = cancellationsHM.frequencies.get(keys);
      highestState = keys;
    }
  }
  println("The state with the highest number of cancellations is " + highestState + " with "+ highestFreq + " cancellations. ");

  for (String HMKey : Co2HM.frequencies.keySet()) {
    println(HMKey + ":" + Co2HM.frequencies.get(HMKey));
  }

  someMessage =  new Display[table.getRowCount()];
  someMessage2 = new Display[table.getRowCount()];
  someMessage3 = new Display[table.getRowCount()];
  someMessage4 = new Display[table.getRowCount()];
  someMessage5 = new Display[table.getRowCount()];
  someMessage6 = new Display[table.getRowCount()];
  someMessage7 =  new Display[table.getRowCount()];
  someMessage8 = new Display[table.getRowCount()];
  someMessage9 = new Display[table.getRowCount()];
  someMessage10 = new Display[table.getRowCount()];
  someMessage11 = new Display[table.getRowCount()];
  someMessage12 = new Display[table.getRowCount()];
  someMessage13 = new Display[table.getRowCount()];
  someMessage14 = new Display[table.getRowCount()];
  someMessage15 = new Display[table.getRowCount()];
  someMessage16 = new Display[table.getRowCount()];
  someMessage17 = new Display[table.getRowCount()];
  someMessage18 = new Display[table.getRowCount()];

  message = new Message();
  int i = 0;
  while (i < table.getRowCount()) {
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

      someMessage[i] = new Display(date, niceFont);
      someMessage2[i] = new Display(carrier, niceFont);
      someMessage3[i] = new Display(flightNumber, niceFont);
      someMessage4[i] = new Display(origin, niceFont);
      someMessage5[i] = new Display(originCity, niceFont);
      someMessage7[i] = new Display(originAirportWAC, niceFont);
      someMessage8[i] = new Display(destination, niceFont);
      someMessage9[i] = new Display(destinationCity, niceFont);
      someMessage10[i] = new Display(destinationWAC, niceFont);
      someMessage11[i] = new Display(ScheduledDepTime, niceFont);
      someMessage12[i] = new Display(ActDepTime, niceFont);
      someMessage13[i] = new Display(ScheduledArrTime, niceFont);
      someMessage14[i] = new Display(ActARRTime, niceFont);
      someMessage15[i] = new Display(destinationWAC, niceFont);
      someMessage16[i] = new Display(distance, 0, 0, niceFont);
      someMessage17[i] = new Display(cancelled, 0, niceFont);
      someMessage18[i] = new Display(diverted, 0, niceFont );
      i++;
    }
  }

  // State Widgets
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

  // Add states to widget array
  statesWidArray[0] = new widget(michigan, 150, "Michigan", "MI");
  statesWidArray[1] = new widget (ohio, 195, "Ohio", "OH");
  statesWidArray[2] = new widget (alabama, 210, "Alabama", "AL");
  statesWidArray[3] = new widget (alaska, 93, "Alaska", "AK");
  statesWidArray[4] = new widget (arizona, 94, "Arizona", "AZ");
  statesWidArray[5] = new widget (arkansas, 243, "Arkansas", "AR");
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
  statesWidArray[49] = new widget (wyoming, 140, "Wyoming", "WY");

  map = new Map(statesWidArray);

  // Home Screen Widgets
  titleWidget = new widget(325, 40, 400, 100, 1, "TRUST-PILOT*", color(#123266), color(#123266), (1), RATINGTYPE1, titleFont);
  triangleWidget1 = new widget(950, 425, 950, 475, 975, 450, 1, color(#123266));
  triangleWidget2 = new widget(50, 425, 50, 475, 25, 450, 1, color(#123266));

  // Airline Widgets
  carrierWid1 = new widget(100, 200, 200, 125, 2, "AA", color(#123266), color(#166bba), (0), RATINGTYPE1, titleFont);
  carrierWid2 = new widget(400, 200, 200, 125, 2, "AS", color(#123266), color(#166bba), (0), RATINGTYPE1, titleFont);
  carrierWid3 = new widget(700, 200, 200, 125, 2, "B6", color(#123266), color(#166bba), (0), RATINGTYPE1, titleFont);
  carrierWid4 = new widget(100, 358, 200, 125, 2, "HA", color(#123266), color(#166bba), (0), RATINGTYPE1, titleFont);
  carrierWid5 = new widget(400, 358, 200, 125, 2, "NK", color(#123266), color(#166bba), (0), RATINGTYPE1, titleFont);
  carrierWid6 = new widget(700, 358, 200, 125, 2, "G4", color(#123266), color(#166bba), (0), RATINGTYPE1, titleFont);
  carrierWid7 = new widget(100, 516, 200, 125, 2, "WN", color(#123266), color(#166bba), (0), RATINGTYPE1, titleFont);
  carrierWid8 = new widget(400, 516, 200, 125, 2, "F9", color(#123266), color(#166bba), (0), RATINGTYPE1, titleFont);
  carrierWid9 = new widget(700, 516, 200, 125, 2, "UA", color(#123266), color(#166bba), (0), RATINGTYPE1, titleFont);
  carrierWid11 = new widget(400, 674, 200, 125, 2, "DL", color(#123266), color(#166bba), (0), RATINGTYPE1, titleFont);

  // Data Changing Widgets
  trustRatingWid1 = new widget(100, 20, 150, 40, RATINGTYPE1, "", color(#4287f5), dataFont);
  trustRatingWid2 = new widget(100, 70, 150, 40, RATINGTYPE1, "", color(#4287f5), dataFont);
  trustRatingWid3 = new widget(100, 120, 150, 40, RATINGTYPE1, " ", color(#4287f5), dataFont);

  // Homescreen Widgets
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
  carrierWidgets.add(trustRatingWid1);
  carrierWidgets.add(trustRatingWid2);
  carrierWidgets.add(trustRatingWid3);

  states = new ArrayList();
  for (int k = 0; k<statesWidArray.length; k++) {
    states.add(statesWidArray[k]);
  }

  // Screens
  mainScreen = new screen(255, carrierWidgets);
  mapScreen = new screen (255, states);
}

void draw() {
  background(#ffffff);
  fill(0);

  if (screen != 1) {
  mainScreen.draw();
  textFont(dataFont);
  fill(#166bba);
  text("TrustWorthyness", 115, 45);
  fill(#fcba03);
  text("co2", 160, 97);
  fill(#e303fc);
  text("Punctuality", 140, 145);
  textFont(titleFont);
  } else {
    mapScreen.draw(1);

    for (int i = 0; i < states.size() - 2; i++) {
      widget cur = (widget) states.get(i);
      if (cur.widgetColor == 0) {
        fill(0);
        long frequency = Math.round(Co2HM.calculateFrequency(cur.origin));
        text(cur.widgetName + " Co2 emissions = " +  frequency + ((frequency == 1) ? " tonne" : " tonnes"), 90, 700);
      }
    }
  }

  // Mouse hover to display ratings
  int event;
  for (int i = 0; i < carrierWidgets.size(); i++) {
    widget currentWidget = (widget) carrierWidgets.get(i);
    event = currentWidget.getEvent(mouseX, mouseY);
    if (carrierWid1.trustRatingType == 1) {
      switch(event) {
      case BUTTON1:
        carrierWid1.trustRating = 0.3; //  <<<<<<<<<<<<<<<<< emmas get function
        carrierWid1.shadeColour = (#166bba);
        break;
      case BUTTON2:
        carrierWid2.trustRating = 0.8;
        carrierWid2.shadeColour = (#166bba);
        break;
      case BUTTON3:
        carrierWid3.trustRating = 0.28;
        carrierWid3.shadeColour = (#166bba);
        break;
      case BUTTON4:
        carrierWid4.trustRating = 0.45;
        carrierWid4.shadeColour = (#166bba);
        break;
      case BUTTON5:
        carrierWid5.trustRating = 0.33;
        carrierWid5.shadeColour = (#166bba);
        break;
      case BUTTON6:
        carrierWid6.trustRating = 0.56;
        carrierWid6.shadeColour = (#166bba);
        break;
      case BUTTON7:
        carrierWid7.trustRating = 0.77;
        carrierWid7.shadeColour = (#166bba);
        break;
      case BUTTON8:
        carrierWid8.trustRating = 0.452;
        carrierWid8.shadeColour = (#166bba);
        break;
      case BUTTON9:
        carrierWid9.trustRating = 0.79;
        carrierWid9.shadeColour = (#166bba);
        break;
      case BUTTON11:
        carrierWid11.trustRating = 0.90;
        carrierWid11.shadeColour = (#166bba);
        break;
      }
    }
    if (carrierWid1.trustRatingType == 2) {
      switch(event) {
      case BUTTON1:
        carrierWid1.trustRating = 0.6;
        carrierWid1.shadeColour = (#fcba03);
        break;
      case BUTTON2:
        carrierWid2.trustRating = 0.2;
        carrierWid2.shadeColour = (#fcba03);
        break;
      case BUTTON3:
        carrierWid3.trustRating = 0.9;
        carrierWid3.shadeColour = (#fcba03);
        break;
      case BUTTON4:
        carrierWid4.trustRating = 0.15;
        carrierWid4.shadeColour = (#fcba03);
        break;
      case BUTTON5:
        carrierWid5.trustRating = 0.23;
        carrierWid5.shadeColour = (#fcba03);
        break;
      case BUTTON6:
        carrierWid6.trustRating = 0.76;
        carrierWid6.shadeColour = (#fcba03);
        break;
      case BUTTON7:
        carrierWid7.trustRating = 0.37;
        carrierWid7.shadeColour = (#fcba03);
        break;
      case BUTTON8:
        carrierWid8.trustRating = 0.6;
        carrierWid8.shadeColour = (#fcba03);
        break;
      case BUTTON9:
        carrierWid9.trustRating = 0.19;
        carrierWid9.shadeColour = (#fcba03);
        break;
      case BUTTON11:
        carrierWid11.trustRating = 0.5;
        carrierWid11.shadeColour = (#fcba03);
        break;
      }
    }
    if (carrierWid1.trustRatingType == 3) {
      switch(event) {
      case BUTTON1:
        carrierWid1.trustRating = 0.7;
        carrierWid1.shadeColour = (#e303fc);
        break;
      case BUTTON2:
        carrierWid2.trustRating = 0.6;
        carrierWid2.shadeColour = (#e303fc);
        break;
      case BUTTON3:
        carrierWid3.trustRating = 0.48;
        carrierWid3.shadeColour = (#e303fc);
        break;
      case BUTTON4:
        carrierWid4.trustRating = 0.65;
        carrierWid4.shadeColour = (#e303fc);
        break;
      case BUTTON5:
        carrierWid5.trustRating = 0.73;
        carrierWid5.shadeColour = (#e303fc);
        break;
      case BUTTON6:
        carrierWid6.trustRating = 0.64;
        carrierWid6.shadeColour = (#e303fc);
        break;
      case BUTTON7:
        carrierWid7.trustRating = 0.54;
        carrierWid7.shadeColour = (#e303fc);
        break;
      case BUTTON8:
        carrierWid8.trustRating = 0.2;
        carrierWid8.shadeColour = (#e303fc);
        break;
      case BUTTON9:
        carrierWid9.trustRating = 0.9;
        carrierWid9.shadeColour = (#e303fc);
        break;
      case BUTTON11:
        carrierWid11.trustRating = 0.21;
        carrierWid11.shadeColour = (#e303fc);
        break;
      }
    }
  }

  widget previousWidget = null;
  int previousColor = 0;
  color x = get(mouseX, mouseY);

  for (widget state : statesWidArray) {
    if ((int)blue(x) == state.widgetColor) {
      if (previousWidget != null && previousColor != 0) previousWidget.widgetColor = previousColor;
      previousWidget = state;
      previousColor = state.widgetColor;
      state.widgetColor = 0;
    }
  }
}

void mousePressed() {
  int event;
  for (int i = 0; i < carrierWidgets.size(); i++) {
    widget currentWidget = (widget) carrierWidgets.get(i);
    event = currentWidget.getEvent(mouseX, mouseY);
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
      println("HOME");
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
      println("TRIANGLE LEFT");
      screen = 0;
      break;
    case triRight:
      println("TRIANGLE RIGHT");
      screen = 1;
      break;
    case TYPEEVENT1:
      println("111111111");
      carrierWid1.trustRatingType = RATINGTYPE1;
      trustRatingWid1.widgetColour = #ffffff;
      trustRatingWid2.widgetColour = #4287f5;
      trustRatingWid3.widgetColour = #4287f5;
      break;
    case TYPEEVENT2:
      println("2222222222");
      carrierWid1.trustRatingType = RATINGTYPE2;
      trustRatingWid1.widgetColour = #4287f5;
      trustRatingWid2.widgetColour = #ffffff;
      trustRatingWid3.widgetColour = #4287f5;
      break;
    case TYPEEVENT3:
      println("333333333");
      carrierWid1.trustRatingType = RATINGTYPE3;
      trustRatingWid1.widgetColour = #4287f5;
      trustRatingWid2.widgetColour = #4287f5;
      trustRatingWid3.widgetColour = #ffffff;
      break;
    }
  }
}

public void combineCancellations() {
  for (int i = 0; i<airlineNames.length; i++) {
    double[] currData = getData("CANCELLED", airlineNames[i], "MKT_CARRIER");
    AirlineMetrics currMetrics = new AirlineMetrics(currData, cancellationsMean, cancellationsSD, false);
    double currZScore = currMetrics.calculateZScore();
    cancellationsMap.put(airlineNames[i], currZScore);
  }
}

public void combinedelays() {
  for (int i = 0; i<airlineNames.length; i++) {
    double[] currData = getData("DIVERTED", airlineNames[i], "MKT_CARRIER");
    AirlineMetrics currMetrics = new AirlineMetrics(currData, delaysMean, delaysSD, false);
    double currZScore = currMetrics.calculateZScore();
    delaysMap.put(airlineNames[i], currZScore);
  }
}

public void combineCo2() {
  for (int i = 0; i<airlineNames.length; i++) {
    double[] currData = getData("DISTANCE", airlineNames[i], "MKT_CARRIER");
    AirlineMetrics currMetrics = new AirlineMetrics(currData, Co2Mean, Co2SD, true);
    double currZScore = currMetrics.calculateZScore();
    co2Map.put(airlineNames[i], currZScore);
  }
}

//get data for data point
public double[] getData(String column) {
  double[] data = new double[table.getRowCount()];
  for (int i = 0; i<table.getRowCount(); i++) {
    data[i] = table.getDouble(i, column);
  }
  return data;
}

//get data for airline
public double[] getData(String columnName, String airlineName, String airlinecol) {
  double[] data = new double[table.getRowCount()];
  int i = 0;
  for (TableRow row : table.findRows(airlineName, airlinecol)) {
    //println(row.getInt(columnName));
    data[i] = row.getInt(columnName);
    i++;
  }
  return data;
}

//Calculate rating for each airline
public void calculateRating() {
  for (int i = 0; i<airlineNames.length; i++) {
    String currAirline = airlineNames[i];
    double co2Score = 6 - (co2Map.get(currAirline) + 3);
    double cancScore = 6 - (cancellationsMap.get(currAirline) + 3);
    double delaysScore =6 -  (delaysMap.get(currAirline) + 3);
    //assuming the weights for time-being, eventually get input from user
    Double rating = (WEIGHT_1 * (co2Score) + WEIGHT_2 * cancScore + WEIGHT_3 * delaysScore) * 5/6 ;
    ratings.put(currAirline, rating);
  }
}
