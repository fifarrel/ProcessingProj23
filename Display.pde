// This class was used to display the info from the csv file 
// It is not use at all in the main project 
// by YCZ
class Display {
  int gap = 20;
  int x = 50;

  String displayMessage;
  PFont f;
    //  display constructor is especially made for true or false (boolean) 
    //  value loaded form the csv, int b is used to seperate it of the other one 
    //  i.e. different signatures
    Display (int a, int b, PFont f ){
      b = b - 1;
      this.f = f;
      if (a == 0) {
        displayMessage = "False";
      }
      else {
        displayMessage = "True";
      }
    }
    // this display constructor is use to display the times from the csv file
    Display(Integer a, int b, int c, PFont f) {
       b = b - 1;
       c = c - 1;
       String unit = " metres";
       displayMessage = a.toString();
       displayMessage = displayMessage + unit;
       this.f = f;
    }
    
    // dusplay strings
    Display(Integer a, PFont f){
      displayMessage = a.toString();
      if (a > 100) {
        StringBuffer str = new StringBuffer(displayMessage);
        str.insert(displayMessage.length() - 2, ":");
        displayMessage = str.toString();
        
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
 
    //drawing the message on the screen
    void draw(int x, int y) {
    fill(0);
    textFont(f); 
    text(displayMessage, x , y);

    }
  
}
