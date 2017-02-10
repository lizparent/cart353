class Walker {
  int x;
  int y;
  
  Walker() {
  }
  
  void display() {
    noStroke();
    fill(241, 196, 15);
    ellipse(x, y, 8, 8);
  }
  
  void step() {
    float stepx = montecarlo() * 10;
    float stepy = montecarlo() * 10;

    x += stepx;
    y += stepy;
  }
}