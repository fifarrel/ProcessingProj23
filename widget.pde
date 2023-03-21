class widget {
  int x, y, width, height;
  String label; int event;
  color widgetColor, labelColor, StrokeColor;
  PFont widgetFont;
  PShape widgetShape;

  widget(int x,int y, int width, int height, String label,
  color widgetColor, PFont widgetFont, int event){
    this.x=x; this.y=y; this.width = width; this.height= height;
    this.label=label; this.event=event; 
    this.widgetColor=widgetColor; this.widgetFont=widgetFont;
    switch(label)
    {
      case("RED"):
        labelColor = color (255, 0, 0);
        break;
      case("GREEN"):
        labelColor = color (0, 255, 0);
        break;
      case("BLUE"):
        labelColor = color (0, 0, 255);
        break;
    }
    // labelColor= color(0);
    StrokeColor = color (0);
   }
   
    widget(PShape widgetShape){
    this.widgetShape = widgetShape;

   }
  void draw(){
    fill(widgetColor);
    stroke(StrokeColor);
    strokeWeight(5);
    rect(x,y,width,height);
    fill(labelColor);
    textSize(25);
    text(label, x+10, y+height-10);
  }
  
  void draw(PShape x) {
    fill(153, 0, 0);
    noStroke();
    // Draw a single state
    shape(x, -60, 25);
    
  }
}
  
