/**
 * Title: ASSIGNMENT 3 <br>
 * Name: ELIZABETH PARENT <br>
 * Date: MARCH 17, 2017 <br>
 **/

/* global variables */
Fish Fish1;
final int nb = 30;
SeaWeed[] weeds;
PVector rootNoise = new PVector(random(123456), random(123456));
int mode = 0;

void setup() {
  size(800, 800);
  background(50,100,200);
  Fish1 = new Fish(200, 200, 1);
  weeds = new SeaWeed[nb];
  for (int i = 0; i < nb; i++)
  {
    weeds[i] = new SeaWeed(random(0, width), height);
  }
}

void draw() {
  background(50,100,200);
  Fish1.fish();
  for (int i = 0; i < nb; i++)
  {
    weeds[i].update();
  }
}

void keyPressed()
{
  mode = (mode + 1) % 2;
}