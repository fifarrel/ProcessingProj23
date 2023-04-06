class screen {
  color bG;
  ArrayList<widget> w;
  int event;
  ArrayList<PImage> backG;
  int tmp;
  
  screen(color bG, ArrayList<widget> widget, ArrayList <PImage> backG){
    this.bG = bG;
    this.w = widget;
    this.backG = backG;
  }
  
  void draw() {
    background(255);
    image(backG.get(tmp), 0, 0, 1000, 850);
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
  void draw(int a){
    background(bG);
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
  
}
