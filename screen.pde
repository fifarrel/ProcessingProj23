class screen {
  color bG;
  ArrayList<widget> w;
  int event;
  
  screen(color bG, ArrayList<widget> widget){
    this.bG = bG;
    this.w = widget;
  }
  
  //int getEvent(int mX, int mY){
  //  for (int i = 0; i < w.size(); i++){ // width of widget
  //   if(mX>w.get(i).x && mX < w.get(i).x+w.get(i).width 
  //   && mY >w.get(i).y && mY < w.get(i).y+w.get(i).height){
  //      return w.get(i).event;
  //   }
  //  }
  //  return EVENT_NULL;
  //}
  
  void draw() {
    background(#000000); // bG
    for (int i = 0; i < w.size(); i++){
      w.get(i).draw();
      if (i == w.size() - 1){
        w.get(i).drawTriangle();
      }
      if (i == w.size() - 2){
        w.get(i).drawTriangle();
      }
    }
  }
  void draw(int a){
    background(bG);
    a = a - 1;
    int i = 0;
    for (i = 0; i < w.size() - 2; i++){
      w.get(i).draw(w.get(i).widgetShape);  
    }
     w.get(i).drawTriangle();
     i++;
     w.get(i).drawTriangle();
  }
  
  void addWidget(widget widget1) {
    w.add(widget1);
  }
}
