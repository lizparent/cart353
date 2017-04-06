//---------------------Class for the Pulse (stars)--------------//
class Pulse {
  //x and y coordinates
  int x;
  int y;

  //used to drive the pulsing cycle
  float pulseCounter;

  //Size of the star
  int scale;

  //Speed of pulsing
  float speed = random(0.01, 0.04);

  //---------------------CONSTRUCTOR--------------//  
  //Make accessible: x and y coordinates, speed of pulsing and size of the star (scale)
  Pulse(int newX, int newY) {

    //access:
    //x and y coordinates
    x = newX;
    y = newY;

    //scale
    scale = int(random(1, 3));

    //Initialize counter
    pulseCounter = 0;
  }

  //Function to draw the stars
  void drawPulse() {

    //Draw them white
    fill(175, 175, 255);
    noStroke();

    //Use sin and scale for width AND height
    ellipse(x, y, sin(pulseCounter)*scale, sin(pulseCounter)*scale);
    pulseCounter += speed;
  }
}