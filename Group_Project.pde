Table table;

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

void setup() {
  
  size (1000, 835);
  background (255);
  table = loadTable("flights2k(1).csv", "header");
  println(table.getRowCount() + " total rows in table");
  
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
  

  for (TableRow row : table.rows()) {  // this prints out some info on to the terminal 
    date = row.getString("FL_DATE");
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
    
    cancelled = row.getInt("CANCELLED");
    diverted = row.getInt("DIVERTED");
   
    distance = row.getInt("DISTANCE");
    
    
    
    println(date.substring(0, 10) + " "+ carrier + " " + flightNumber + " " 
      + origin + " (" + originCity + ") " + orginCityAbr + originAirportWAC);
    
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
    
  }
  
  // from here it displays it on a screen
  int i = 0;
   while ( i < table.getRowCount()){ 
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
       
       niceFont = loadFont("AdelleSansDevanagari-Regular-20.vlw");
       
       someMessage[i] = new Display(date, niceFont);
       someMessage2[i] = new Display(carrier, niceFont);
       someMessage3[i] = new Display(flightNumber, niceFont);
       someMessage4[i] = new Display(origin, niceFont);
       someMessage5[i] = new Display(originCity, niceFont);
       // someMessage6[i] = new Display(orginCityAbr, niceFont); // dont think we need this one
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
}

void draw() {
  background(255);
  fill(0);
  int tmp = i+2;
  text("The flight date for the " + tmp + "th row in the table is: ", 5, 25);
  someMessage[i].draw(770, 25);
  text("The Carrier Initials for the " + tmp + "th row in the table is: ", 5, 75);
  someMessage2[i].draw(770, 75);
  text("The flight number for the " + tmp + "th row in the table is: ", 5, 125);
  someMessage3[i].draw(770, 125);
  text("The orgin airport's initials for the " + tmp + "th row in the table is: ", 5, 175);
  someMessage4[i].draw(770, 175);
  text("The orgin city for the " + tmp + "th row in the table is: ", 5, 225);
  someMessage5[i].draw(770, 225);
  
  text("The World Area Code of orgin airport for the " + tmp + "th row in the table is: ", 5, 275);
  someMessage7[i].draw(770, 275);
  text("The destination airport's initials  " + tmp + "th row in the table is: ", 5, 325);
  someMessage8[i].draw(770, 325);
  text("The destination city for the " + tmp + "th row in the table is: ", 5, 375);
  someMessage9[i].draw(770, 375);
  text("The World Area Code of destination airport " + tmp + "th row in the table is: ", 5, 425);
  someMessage10[i].draw(770, 425);
  
  text("The Scheduled Dep. time for the " + tmp + "th row in the table is: ", 5, 475);
  someMessage11[i].draw(770, 475);
  text("The Actual Dep. time for the " + tmp + "th row in the table is: ", 5, 525);
  someMessage12[i].draw(770, 525);
  text("The Scheduled Arr. time for the " + tmp + "th row in the table is: ", 5, 575);
  someMessage13[i].draw(770, 575);
  text("The Actual Arr. time for the " + tmp + "th row in the table is: ", 5, 625);
  someMessage14[i].draw(770, 625);
  
  text("The World Area Code of destination airport for the " + tmp + " th row in the table is: ", 5, 675);
  someMessage15[i].draw(770, 675);
  
  text("The distance of flight in the " + tmp + "th row in the table is: ", 5, 725);
  someMessage16[i].draw(770, 725);
  
  text("The flight in the " + tmp + "th row in the table is cancelled: ", 5, 775);
  someMessage17[i].draw(770, 775);
  
  text("The flight in the " + tmp + "th row in the table is diverted: ", 5, 825);
  someMessage18[i].draw(770, 825);
  
  
  
  
  i++;
  frameRate(1);
  


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
