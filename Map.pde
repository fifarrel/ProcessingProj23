 PShape alabama, alaska, arizona, arkansas, california,
  colorado, connecticut, delaware, districtofColumbia, florida, georgia,
  hawaii, idaho, illinois, indiana, iowa, kansas, kentucky, louisiana,
  maine, maryland, massachusetts, michigan, minnesota, mississippi, missouri, montana,
  nebraska, nevada, newHampshire, newJersey,
  newMexico, newYork, northCarolina, northDakota,
  ohio, oklahoma, oregon, pennsylvania, virginIsland, rhodeIsland, southCarolina,
  southDakota, tennessee, texas, utah, vermont, virginia,
  washington, westVirginia, wisconsin, wyoming;
  
class Map {
  widget mapWidArray[] = new widget[51];

  
  Map(widget[] statesArray){
    for(int i =0;i<statesArray.length;i++){
        mapWidArray[i] = statesArray[i];
    }
  }
  
  void draw(){
    for(widget state: mapWidArray){
      state.draw(state.widgetShape); 
    }
        
    triangleWidget1.drawTriangle();
    triangleWidget2.drawTriangle();
  }

}
