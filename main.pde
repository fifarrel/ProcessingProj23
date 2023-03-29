Table table;
String date, carrier, origin, originCity, orginCityAbr,
  destination, destinationCity, destinationStateAbr;
int flightNumber, originAirportWAC, destinationWAC, ScheduledDepTime, ActDepTime, ScheduledArrTime,
  ActARRTime, distance, diverted, cancelled;
PShape triangle;
ArrayList carrierWidgets;
final int BUTTON1 = 1;
final int BUTTON2 = 2;
final int BUTTON3 = 3;
final int BUTTON4 = 4;
final int BUTTON5 = 5;
final int BUTTON6 = 6;
final int BUTTON7 = 7;
final int BUTTON8 = 8;
final int BUTTON9 = 9;
final int BUTTON10 = 10;
final int BUTTON11 = 11;
final int BUTTON12 = 12;
final int triLeft = 20;
final int triRight = 21;
final int home = 22;
widget titleWidget;
widget triangleWidget1, triangleWidget2;
widget carrierWid1, carrierWid2, carrierWid3, carrierWid4, carrierWid5, carrierWid6,
  carrierWid7, carrierWid8, carrierWid9, carrierWid10, carrierWid11, carrierWid12;

void setup() {
  size(1000, 835);
  background(255);
  triangle = loadShape("triangle.svg");
  scale(0.2);
  PFont titleFont;
  titleFont = loadFont("Calibri-BoldItalic-48.vlw");
  textFont(titleFont);

  titleWidget = new widget(325, 40, 400, 100, 1, "TRUST-PILOT*", color(#123266), titleFont);
  triangleWidget1 = new widget(950, 425, 950, 475, 975, 450, 1, color(#7494fc));
  triangleWidget2 = new widget(50, 425, 50, 475, 25, 450, 1, color(#7494fc));

  carrierWid1 = new widget(100, 200, 200, 125, 2, "", color(#123266), titleFont);
  carrierWid2 = new widget(400, 200, 200, 125, 2, "", color(#123266), titleFont);
  carrierWid3 = new widget(700, 200, 200, 125, 2, "", color(#123266), titleFont);

  carrierWid4 = new widget(100, 358, 200, 125, 2, "", color(#123266), titleFont);
  carrierWid5 = new widget(400, 358, 200, 125, 2, "", color(#123266), titleFont);
  carrierWid6 = new widget(700, 358, 200, 125, 2, "", color(#123266), titleFont);

  carrierWid7 = new widget(100, 516, 200, 125, 2, "", color(#123266), titleFont);
  carrierWid8 = new widget(400, 516, 200, 125, 2, "", color(#123266), titleFont);
  carrierWid9 = new widget(700, 516, 200, 125, 2, "", color(#123266), titleFont);

  carrierWid10 = new widget(100, 674, 200, 125, 2, "", color(#123266), titleFont);
  carrierWid11 = new widget(400, 674, 200, 125, 2, "", color(#123266), titleFont);
  carrierWid12 = new widget(700, 674, 200, 125, 2, "", color(#123266), titleFont);

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
  carrierWidgets.add(carrierWid10);
  carrierWidgets.add(carrierWid11);
  carrierWidgets.add(carrierWid12);


  carrierWidgets.add(titleWidget);
  carrierWidgets.add(triangleWidget1);
  carrierWidgets.add(triangleWidget2);
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
      break;
    case triLeft:
      println("TRIANGLE LEFT");
      break;
    case triRight:
      println("TRIANGLE RIGHT");
      break;
    }
  }
}

void draw() {
  titleWidget.draw();

  triangleWidget1.drawTriangle();
  triangleWidget2.drawTriangle();

  carrierWid1.draw();
  carrierWid2.draw();
  carrierWid3.draw();
  carrierWid4.draw();
  carrierWid5.draw();
  carrierWid6.draw();
  carrierWid7.draw();
  carrierWid8.draw();
  carrierWid9.draw();
  carrierWid10.draw();
  carrierWid11.draw();
  carrierWid12.draw();
}
