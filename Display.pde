

class Display {
  int gap = 20;
  int x = 50;

  String displayMessage;
  PFont f;

    Display (int a, int b, PFont f ){
      this.f = f;
      if (a == 0) {
        displayMessage = "False";
      }
      else {
        displayMessage = "True";
      }
    }
    
    Display(Integer a, int b, int c, PFont f) {
       String unit = " metres";
       displayMessage = a.toString();
       displayMessage = displayMessage + unit;
       this.f = f;
    }
    
    Display(Integer a, PFont f){
      displayMessage = a.toString();
      if (a > 100) {
        StringBuffer str = new StringBuffer(displayMessage);
        str.insert(displayMessage.length() - 2, ":");
        displayMessage = str.toString();
        
        ;
      }
     
      this.f = f;
    }
    
    Display(String a, PFont f){
      displayMessage = a;
      this.f = f;
      }
    
    
    String toString() {
      return displayMessage;
    }
  
  
    
    void draw(int x, int y) {
    fill(0);
    textFont(f); 
    text(displayMessage, x , y);
    
    //for (int k = 0; k < arrayOfMessages.length; k++)
    //{
    //  text(arrayOfMessages[k], 50 , 50 + (k * gap));
    //}

    //int x = 10;
    //for (int i = 0; i < displayMessage.length(); i++) {
    //  textSize(15);
    //  text(displayMessage.charAt(i),x,height/2);
    //  x += textWidth(displayMessage.charAt(i));
    //}
    //text(displayMessage,50,50 + (gap * x)); make the message move
    //x++;
    }
  
}
