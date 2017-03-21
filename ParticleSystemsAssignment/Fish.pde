class Fish {

  /* properties */
  int x;
  int y;
  float size;

  /* methods */
  Fish (int newX, int newY, float newSize) {
    x = newX;
    y = newY;
    size = newSize;
  }

  void fish() {
    noStroke();
    fill(255, 165, 48);
    triangle(x+125, y+40, x+125, y-40, x+75, y);
    ellipse(x+50, y, size*100, size*75);
    fill(225);
    ellipse(x+25, y-10, size*20, size*20);
    fill(0);
    ellipse(x+25, y-10, size*10, size*10);
    x--;
  }
}