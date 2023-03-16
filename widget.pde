class widget {
  int x, y, width, height, event;
  String label; 
  color widgetColor, labelColor, StrokeColor;
  PFont widgetFont;

  widget(int x,int y, int width, int height, String label,
  color widgetColor, PFont widgetFont, int event){
    this.x=x; this.y=y; this.width = width; this.height= height;
    this.label=label; this.event = event; 
    this.widgetColor=widgetColor; this.widgetFont=widgetFont;
    labelColor= color(0);
    StrokeColor = color (0);
   }
   
  void draw(){
    fill(widgetColor);
    stroke(StrokeColor);
    strokeWeight(2);
    rect(x,y,width,height);
    fill(labelColor);
    textSize(20);
    text(label, x+13, y+height-12);
  }
}
  
