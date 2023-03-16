class screen {
  color bG;
  ArrayList<widget> w;
  int event;
  
  screen(color bG, ArrayList<widget> widget){
    this.bG = bG;
    this.w = widget;
  }
  
  int getEvent(int mX, int mY){
    for (int i = 0; i < w.size(); i++){ // width of widget
     if(mX>w.get(i).x && mX < w.get(i).x+w.get(i).width 
     && mY >w.get(i).y && mY < w.get(i).y+w.get(i).height){
        return w.get(i).event;
     }
    }
    return EVENT_NULL;
  }
  
  void draw() {
    background(bG);
    for (int i = 0; i < w.size(); i++){
      w.get(i).draw();
    }
  }
  
  void addWidget(widget widget1, widget widget2) {
    w.add(widget1);
    w.add(widget2);
  }
}
