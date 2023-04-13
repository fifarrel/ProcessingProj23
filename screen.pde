
class screen {
  color bG;
  ArrayList<widget> w;
  int event;
  ArrayList<PImage> backG;
  int tmp;
  PFont TpFont;
  Histogram histogram;
  // screen constructor
  screen(Histogram histogram, ArrayList<widget> widget, ArrayList <PImage> backG){
    this.histogram = histogram;
    this.w = widget;
    this.backG = backG;
  }
  
  screen(color bG, ArrayList<widget> widget, ArrayList <PImage> backG){
    this.bG = bG;
    this.w = widget;
    this.backG = backG;
  }
  
  void draw() {                             // draw the main screens' widgets 
    image(backG.get(tmp), 0, 0, 1000, 850); // draw the background
    for (int i = 0; i < w.size(); i++){
      w.get(i).draw();
      if (i == w.size() - 1){
        w.get(i).drawTriangle();
      }
      if (i == w.size() - 2){
        w.get(i).drawTriangle();
      }
    }
    tmp++;
    if (tmp == 61) tmp =0;
  }
  void draw(int a){                          // draws the maps
    image(backG.get(tmp), 0, 0, 1000, 850);
    a = a - 1;
    int i = 0;
    for (i = 0; i < w.size() - 2; i++){
      w.get(i).draw(w.get(i).widgetShape);  
    }
     w.get(i).drawTriangle();
     i++;
     w.get(i).drawTriangle();
     tmp++;
     if (tmp == 61) tmp =0;
  }
  
  void addWidget(widget widget1) {
    w.add(widget1);
  }
  // credits 
  void message(){
    textSize(100);
    fill(0);
    text("Trust-Pilot 2023 Beta", 40, a);
    textSize(50);
    fill(0);
    text("CSU11013 - Group 46", 40, g);
    textSize(25);
    fill(0);
    text("Trust-Pilot 2023 - developed by Group 46:", 250, h);
    textSize(25);
    fill(0);
    text("Emma Murphy", 250, h + 30);
    textSize(25);
    fill(0);
    text("Finn Farrell", 250, h + 60);
    textSize(25);
    fill(0);
    text("Bhudhav Singh", 250, h + 90);
    textSize(25);
    fill(0);
    text("YuChen Zhuang", 250, h + 120);
    textSize(65);
    fill(0);
    text("Team 46 would like to thanks all  ", 40, h + 200);
    text("the demonstrators,", 40, h + 265);
    text("especially Ryan,", 40, h + 330);
    text("Professor Gavin Doherty and ", 40, h + 395);
    text("Dr. Alakarri", 40, h + 460);
    text("For the opportunity to work", 40, h + 525);
    text("on this project.", 40, h + 590);
    text("Much Gratitude", 40, h + 720);
    a--;
    g--;
    h--;
  }
  void draw(String s){
    s = " Histogram";
    image(backG.get(tmp), 0, 0, 1000, 850);
    a = a - 1;
    int i = 0;
    for (i = 0; i < w.size() - 2; i++){
      w.get(i).draw(w.get(i).widgetShape);  
    }
    histogram.drawHistogram();
     w.get(i).drawTriangle();
     i++;
     w.get(i).drawTriangle();
     tmp++;
     if (tmp == 61) tmp =0;
 
  }
  // different signature as the one before
  // sources
  void message(int a){
    a = a - 1;
    textSize(75);
    
    fill(0);
    text("Sources:", 75, 75);
    textSize(30);
    fill(0);
    text("Processing Website: ", 75, 150);
    if ((mouseX >= 375) && (mouseX <= 430) && (mouseY >= 115) && (mouseY <= 170)){
      fill(0, 0, 255);
      if (mousePressed){
        link("http://www.processing.org");
      }
    }else {
      fill(255);
    }
    stroke(0);
    rect(375, 115, 50, 50);
    fill(0);
    line(385, 155, 405, 135);
    line(390, 135, 405, 135);
    line(405, 135, 405, 150);
    
    
    fill(0);
    text("Data: ", 75, 210);
    if ((mouseX >= 375) && (mouseX <= 430) && (mouseY >= 170) && (mouseY <= 225)){
      fill(0, 0, 255);
      if (mousePressed){
        link("https://www.transtats.bts.gov/DL_SelectFields.aspx?gnoyr_VQ=FGK&QO_fu146_anzr=b0-gvzr");
      }
    }else {
      fill(255);
    }
    rect(375, 170, 50, 50);
    fill(0);
    line(385, 210, 405, 190);
    line(390, 190, 405, 190);
    line(405, 190, 405, 205);
    
    fill(0);
    text("Background Image: ", 75, 270);
    if ((mouseX >= 375) && (mouseX <= 430) && (mouseY >= 225) && (mouseY <= 280)){
      fill(0, 0, 255);
      if (mousePressed){
        link("https://www.google.com/url?sa=i&url=https%3A%2F%2Fgifer.com%2Fen%2FJFi&psig=AOvVaw0uulpkdpddwvCMiKTdz6GM&ust=1681071539928000&source=images&cd=vfe&ved=0CBEQjRxqFwoTCODhsNKNm_4CFQAAAAAdAAAAABAD");
      }
    }else {
      fill(255);
    }
    rect(375, 225, 50, 50);
    fill(0);
    line(385, 265, 405, 245);
    line(390, 245, 405, 245);
    line(405, 245, 405, 260);
    
    fill(0);
    text("Map (Usa.svg): ", 75, 325);
    if ((mouseX >= 375) && (mouseX <= 430) && (mouseY >= 280) && (mouseY <= 335)){
      fill(0, 0, 255);
      if (mousePressed){
        link("https://simplemaps.com/resources/svg-us");
      }
    }else {
      fill(255);
    }
    rect(375, 280, 50, 50);
    fill(0);
    line(385, 320, 405, 300);
    line(390, 300, 405, 300);
    line(405, 300, 405, 315);
  }
  // main screen selector
  void selection (){
    TpFont = loadFont("Calibri-BoldItalic-32.vlw");
    textFont(TpFont);
    textSize(55);
    text("TRUST-PILOT*", 362, 110);
    
    textFont(titleFont);
      textSize(30);
      if ((mouseX >= 40) && (mouseX <= 295) && (mouseY >= 10) && (mouseY <= 60)) { 
        fill(137, 207, 240);
        if (mousePressed){
          selector = true;
        }
      }
      else {
        fill(255);
      }
      rect(40, 10, 250, 45, 12);
      fill(#000000); // 0, 0, 90
      text("Press to select", 50, 45);
      
      if (selector){
      if ((mouseX >= 40) && (mouseX <= 295) && (mouseY >= 10) && (mouseY <= 60)) { 
        fill(#1c89ed); //  Trustwothyness button hover colour
      }
      else {
        fill(255);
      }
      rect(40, 10, 250, 45, 12);
      fill(#07092e);//
      text("Trustworthiness", 50, 45);
      
      if ((mouseX >= 40) && (mouseX <= 295) && (mouseY >= 68) && (mouseY <= 110)) { 
        fill(#fa4b2d); //  // CO2 button hover colour
      }
      else {
        fill(255);
      }
      rect(40, 65, 250, 45, 12);
      fill(#38020e);
      text("Delays", 50, 97);
      
      if ((mouseX >= 40) && (mouseX <= 295) && (mouseY >= 120) && (mouseY <= 164)) { 
        fill(#ec6efa); // punctuality button hover colour
      }
      else {
        fill(255);
      }
      rect(40, 120, 250, 45, 12);
      fill(#260238);
      text("Cancellations", 50, 150);
      }
  }
}
