Table table;

String date , carrier, origin, originCity, orginCityAbr, 
destination, destinationCity, destinationStateAbr;

int flightNumber, originAirportWAC, destinationWAC, ScheduledDepTime, ActDepTime, ScheduledArrTime,
ActARRTime, distance, diverted, cancelled;

int screen, i;
screen screen1, screen2;
PFont font, niceFont;

widget a , b;

Message message;
float [] chart = new float [2000];
int [] onOfVDistance = new int [2000];

PShape usa;

Map map;

widget [] states;

void setup() {
  
  size (1000, 835);
  background (255);
  table = loadTable("flights2k(1).csv", "header");
  println(table.getRowCount() + " total rows in table");
  usa = loadShape("us.svg");
  
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
    
    //screen1 = new screen (color(150), new ArrayList<widget>());
    //screen2 = new screen(color(150), new ArrayList<widget>());
    //screen1.addWidget(a, b);
    //screen2.addWidget(a, null);
    
    //screen = 1;
    
  
  
  // from here it displays it on a screen
  int i = 0;
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
       someMessage16[i] = new Display(distance, 0 , 0, niceFont);
       someMessage17[i] = new Display(cancelled, 0, niceFont);
       someMessage18[i] = new Display(diverted, 0, niceFont );
       i++;
     }
   }

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


michiganWidget = new widget(michigan, 90, "Michigan");
ohioWidget = new widget (ohio, 90, "Ohio");
alabamaWidget = new widget (alabama, 90, "Alabama");
alaskaWidget = new widget (alaska, 90, "Alaska");
arizonaWidget = new widget (arizona, 90, "Arizona");
arkansasWidget = new widget (arkansas, 90, "Arkansas");
californiaWidget = new widget (california, 90, "California");
coloradoWidget = new widget (colorado, 90, "Colorado");
connecticutWidget = new widget (connecticut, 90, "Connecticut");
delawareWidget = new widget (delaware, 90, "Delaware");
districtofColumbiaWidget = new widget (districtofColumbia, 90, "District of Columbia");
floridaWidget = new widget (florida, 90, "Florida");
georgiaWidget = new widget (georgia, 90, "Georgia");
hawaiiWidget = new widget (hawaii, 90, "Hawaii");
idahoWidget = new widget (idaho, 90, "Idaho");
illinoisWidget = new widget (illinois, 90, "Illinois");
indianaWidget = new widget (indiana, 90, "Indiana");
iowaWidget = new widget (iowa, 90, "Iowa");
kansasWidget = new widget (kansas, 90, "Kansas");
kentuckyWidget = new widget (kentucky, 90, "Kentucky");
louisianaWidget = new widget (louisiana, 90, "Louisiana");
maineWidget = new widget (maine, 90, "Maine");
marylandWidget = new widget (maryland, 90, "Maryland");
massachusettsWidget = new widget (massachusetts, 90, "Massachusetts");
minnesotaWidget = new widget (minnesota, 90, "Minnesota");
mississippiWidget = new widget (mississippi, 90, "Mississippi");
missouriWidget = new widget (missouri, 90, "Missouri");
montanaWidget = new widget (montana, 90, "Montana");
nebraskaWidget = new widget (nebraska, 90, "Nebraska");
nevadaWidget = new widget (nevada, 90, "Nevada");
newHampshireWidget = new widget (newHampshire, 90, "New Hampshire");
newJerseyWidget = new widget (newJersey, 90, "New Jersey");
newMexicoWidget = new widget (newMexico, 90, "New Mexico");
newYorkWidget = new widget (newYork, 90, "New York");
northCarolinaWidget = new widget (northCarolina, 90, "North Carolina");
northDakotaWidget = new widget (northDakota, 90, "North Dakota");
oklahomaWidget = new widget (oklahoma, 90, "Oklahoma");
oregonWidget = new widget (oregon, 90, "Oregon");
pennsylvaniaWidget = new widget (pennsylvania, 90, "Pennsylvania");
rhodeIslandWidget = new widget (rhodeIsland, 90, "Rhode Island");
southCarolinaWidget = new widget (southCarolina, 90, "South Carolina");
southDakotaWidget = new widget (southDakota, 90, "South Dakota");
tennesseeWidget = new widget (tennessee, 90, "Tennessee");
texasWidget = new widget (texas, 90, "Texas");
utahWidget = new widget (utah, 90, "Utah");
vermontWidget = new widget (vermont, 90, "Vermont");
virginiaWidget = new widget (virginia, 90, "Virginia");
washingtonWidget = new widget (washington, 90, "Washington");
westVirginiaWidget = new widget (westVirginia, 90, "West Virginia");
wisconsinWidget = new widget (wisconsin, 90, "Wisconsin");
wyomingWidget = new widget (wyoming, 90, "Wyoming");
  
  map = new Map(michiganWidget, ohioWidget, alabamaWidget, alaskaWidget, arizonaWidget,
  arkansasWidget, californiaWidget, coloradoWidget, connecticutWidget, delawareWidget, districtofColumbiaWidget,
  floridaWidget, georgiaWidget, hawaiiWidget, idahoWidget, illinoisWidget, indianaWidget, iowaWidget,
  kansasWidget, kentuckyWidget, louisianaWidget, maineWidget, marylandWidget, massachusettsWidget, minnesotaWidget,
  mississippiWidget, missouriWidget, montanaWidget, nebraskaWidget, nevadaWidget, newHampshireWidget, newJerseyWidget,
  newMexicoWidget, newYorkWidget, northCarolinaWidget, northDakotaWidget,
  oklahomaWidget, oregonWidget, pennsylvaniaWidget, rhodeIslandWidget, southCarolinaWidget,
  southDakotaWidget, tennesseeWidget, texasWidget, utahWidget, vermontWidget, virginiaWidget,
  washingtonWidget, westVirginiaWidget, wisconsinWidget, wyomingWidget);
}

void draw() {
  background(255);
  fill(0);
  //message.draw();
  //frameRate(1);
  
  map.draw();
  
  //  below is not important
  //if (screen == 1){
  //  screen1.draw();
  //}
  //else {
  //  screen2.draw();
  //}
  //a.draw();
  //b.draw();
}

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

void mouseMoved(){
  if (mouseX > 596 && mouseX < 723 && mouseY > 80 && mouseY < 207){
      michiganWidget = new widget(michigan, 0, "Michagan" );
    }
    else {
      michiganWidget = new widget(michigan, 90, "Michagan" );
    }
}
