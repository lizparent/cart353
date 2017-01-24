int black=0;
int trans=255;

class Presentation {

  Presentation() {
  } 

  void display() { 
    fill(black, trans);
    rect(0, 0, width, height);
    
    fill(121, 213, 247, trans);
    text("INSTRUCTIONS:", width/4-20, height/4+44);
    fill(255, trans);
    text("1. Left click to see more frog", width/4-20, height/4+68);
    text("2. Right click to see more fish", width/4-20, height/4+82);
    text("3. Press 'V' to add a vignette", width/4-20, height/4+96);
    text("4. Press 'B' for a cool effect", width/4-20, height/4+110);
    text("5. Press 'S' to save your creation", width/4-20, height/4+124);
    
    fill(121, 213, 247, trans);
    text("PRESS SPACE BAR TO BEGIN", width/4-20, height/4+152);
  }
  
  void disappear() { 
    trans=0;
  }
}