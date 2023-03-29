class widget {
  int x, y;
  int x1, x2, x3, y1, y2, y3;
  int width, height;
  int direction;
  String label;
  color widgetColour, fontColour;
  PFont widgetFont;
  PShape triangle;

  widget(int x1, int y1, int x2, int y2, int x3, int y3, int direction, color widgetColour) {
    this.x1 = x1;
    this.y1 = y1;
    this.x2 = x2;
    this.y2 = y2;
    this.x3 = x3;
    this.y3 = y3;
    this.direction = direction;
    this.widgetColour = widgetColour;
  }

  widget(int x, int y, int width, int height, int direction, String label,
    color widgetColour, PFont widgetFont) {
    this.x=x;
    this.y=y;
    this.width = width;
    this.height= height;
    this.label=label;
    this.direction = direction;
    this.widgetColour=widgetColour;
    this.widgetFont=widgetFont;
  }

  int getEvent(int mouseX, int mouseY) {
    if ((mouseX >= 100) && (mouseX <= 300) && (mouseY >= 200) && (mouseY <= 325)) {
      return 1;
    }
    if ((mouseX >= 400) && (mouseX <= 600) && (mouseY >= 200) && (mouseY <= 325)) {
      return 2;
    }
    if ((mouseX >= 700) && (mouseX <= 900) && (mouseY >= 200) && (mouseY <= 325)) {
      return 3;
    }
    if ((mouseX >= 100) && (mouseX <= 300) && (mouseY >= 358) && (mouseY <= 483)) {
      return 4;
    }
    if ((mouseX >= 400) && (mouseX <= 600) && (mouseY >= 358) && (mouseY <= 483)) {
      return 5;
    }
    if ((mouseX >= 700) && (mouseX <= 900) && (mouseY >= 358) && (mouseY <= 483)) {
      return 6;
    }
    if ((mouseX >= 100) && (mouseX <= 300) && (mouseY >= 516) && (mouseY <= 641)) {
      return 7;
    }
    if ((mouseX >= 400) && (mouseX <= 600) && (mouseY >= 516) && (mouseY <= 641)) {
      return 8;
    }
    if ((mouseX >= 700) && (mouseX <= 900) && (mouseY >= 516) && (mouseY <= 641)) {
      return 9;
    }
    if ((mouseX >= 100) && (mouseX <= 300) && (mouseY >= 674) && (mouseY <= 799)) {
      return 10;
    }
    if ((mouseX >= 400) && (mouseX <= 600) && (mouseY >= 674) && (mouseY <= 799)) {
      return 11;
    }
    if ((mouseX >= 700) && (mouseX <= 900) && (mouseY >= 674) && (mouseY <= 799)) {
      return 12;
    }
    if ((mouseX >= 25) && (mouseX <= 50) && (mouseY >= 425) && (mouseY <= 475)) {
      return 20;
    }
    if ((mouseX >= 950) && (mouseX <= 975) && (mouseY >= 425) && (mouseY <= 475)) {
      return 21;
    }
    if ((mouseX >= 325) && (mouseX <= 725) && (mouseY >= 40) && (mouseY <= 140)) {
      return 22;
    }
    return 0;
  }

  void draw() {
    fill(widgetColour);
    rect(x, y, width, height, 28);
    fill(#39994a);
    text(label, 410, 105);
  }
  void drawTriangle() {
    triangle(x1, y1, x2, y2, x3, y3);
  }
}
