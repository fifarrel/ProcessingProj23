class Message {
  void draw(){
    int tmp = i+2;
    text("The flight date for the " + tmp + "th row in the table is: ", 5, 25);
    someMessage[i].draw(770, 25);
    text("The Carrier Initials for the " + tmp + "th row in the table is: ", 5, 75);
    someMessage2[i].draw(770, 75);
    text("The flight number for the " + tmp + "th row in the table is: ", 5, 125);
    someMessage3[i].draw(770, 125);
    text("The orgin airport's initials for the " + tmp + "th row in the table is: ", 5, 175);
    someMessage4[i].draw(770, 175);
    text("The orgin city for the " + tmp + "th row in the table is: ", 5, 225);
    someMessage5[i].draw(770, 225);
    
    text("The World Area Code of orgin airport for the " + tmp + "th row in the table is: ", 5, 275);
    someMessage7[i].draw(770, 275);
    text("The destination airport's initials  " + tmp + "th row in the table is: ", 5, 325);
    someMessage8[i].draw(770, 325);
    text("The destination city for the " + tmp + "th row in the table is: ", 5, 375);
    someMessage9[i].draw(770, 375);
    text("The World Area Code of destination airport " + tmp + "th row in the table is: ", 5, 425);
    someMessage10[i].draw(770, 425);
    
    text("The Scheduled Dep. time for the " + tmp + "th row in the table is: ", 5, 475);
    someMessage11[i].draw(770, 475);
    text("The Actual Dep. time for the " + tmp + "th row in the table is: ", 5, 525);
    someMessage12[i].draw(770, 525);
    text("The Scheduled Arr. time for the " + tmp + "th row in the table is: ", 5, 575);
    someMessage13[i].draw(770, 575);
    text("The Actual Arr. time for the " + tmp + "th row in the table is: ", 5, 625);
    someMessage14[i].draw(770, 625);
    
    text("The World Area Code of destination airport for the " + tmp + " th row in the table is: ", 5, 675);
    someMessage15[i].draw(770, 675);
    
    text("The distance of flight in the " + tmp + "th row in the table is: ", 5, 725);
    someMessage16[i].draw(770, 725);
    
    text("The flight in the " + tmp + "th row in the table is cancelled: ", 5, 775);
    someMessage17[i].draw(770, 775);
    text("The flight in the " + tmp + "th row in the table is diverted: ", 5, 825);
    someMessage18[i].draw(770, 825);
    i++;
  }
}
