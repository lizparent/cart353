class Vignette {

  PImage testVignette;
  int x;
  int y;
  int radius;
  
  Vignette(int x, int y, int radius) {
  this.x = x;
  this.y = y;
  this.radius = radius;
  }
  
  void display(){
    testVignette = createImage(width, height, ARGB);

    testVignette.loadPixels();
    int a =255;
    // decrease radius each time
    for (int i= radius; i>0; i-=1)
    {
      a-=.25;
      //println(a);
      // draw a circle by points
      for (float theta =0; theta<TWO_PI; theta+=0.001)
      {
        //stroke(255,0,0,a);
        int xPos = (int)(x+ (cos((theta))*i));
        int yPos = (int)(y+ (sin((theta))*i));
        // calculate position in array
        int loc  = (int)xPos+yPos*width;
        // point(xPos,yPos);
        if (loc >0 && loc <width*height)
          testVignette.pixels[loc] = color(0, 0, 0, a);
      }
    }
    testVignette.updatePixels();
    image(testVignette, 0, 0);
  }
}