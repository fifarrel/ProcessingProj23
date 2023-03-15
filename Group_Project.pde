Table table;
String date , carrier, origin, originCity, orginCityAbr, 
destination, destinationCity, destinationStateAbr;

int flightNumber, originAirportWAC, destinationWAC, ScheduledDepTime, ActDepTime, ScheduledArrTime,
ActARRTime, distance, cancelled ;

int screen;
screen screen1, screen2;
PFont font;

widget a , b;

void setup() {
  
  size (640, 320);
  background (255);
  table = loadTable("flights2k(1).csv", "header");
  println(table.getRowCount() + " total rows in table");
  for (TableRow row : table.rows()) { 
  
    date = row.getString("FL_DATE");
    carrier = row.getString("MKT_CARRIER");
    flightNumber = row.getInt("MKT_CARRIER_FL_NUM");
    origin = row.getString("ORIGIN");
    originCity = row.getString("ORIGIN_CITY_NAME");
    orginCityAbr = row.getString("ORIGIN_STATE_ABR");
    
    println(date.substring(0, 10) + " "+ carrier + " " + flightNumber + " " 
      + origin + " (" + originCity + ") " + orginCityAbr );
    
    a = new widget (10, 15, 100, 40,
    "FL_DATE", color(255),
    font, FLIGHTDATE_BUTTON);
    
    b = new widget (150, 15, 150, 40,
    "MKT_CARRIER", color(255),
    font, EVENT_BUTTON2);
    
    screen1 = new screen (color(150), new ArrayList<widget>());
    screen2 = new screen(color(150), new ArrayList<widget>());
    screen1.addWidget(a, b);
    screen2.addWidget(a, null);
    
    screen = 1;
  }
}

void draw() {
  background(255);
  if (screen == 1){
    screen1.draw();
  }
  else {
    screen2.draw();
  }
  //a.draw();
  //b.draw();
}

void mousePressed() {
  int event;
  if (screen ==1){
    event = screen1.getEvent(mouseX, mouseY);
        switch(event) {
    case FLIGHTDATE_BUTTON:
      screen = 0;
      println("button 1 is pressed");
      break;
    case EVENT_BUTTON3:
      println("forward is pressed");
      break;
    }
  }
  else {
    event = screen2.getEvent(mouseX, mouseY);
    switch(event) {
    case EVENT_BUTTON2:
      println("button 2 is pressed");
      break;
    case EVENT_BUTTON4:
      screen = 1;
      println("backward is pressed");
      break;
    }
  }
}
