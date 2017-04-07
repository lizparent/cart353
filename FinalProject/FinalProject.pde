// Elizabeth Parent
// CART353 Final Project: MountainScape

int cols, rows;
//size of each cell
int scl = 6;
int w = 1400;
int h = 1000;

//boolean for day and night
boolean day = true;

//image of the map
PImage img;

//number of stars
int numPulses = 500;
//an array of pulse objects/instances
Pulse[] pulseArray = new Pulse[numPulses];

//instantiating buttons
Button buttonDay;
Button buttonNight;
Button buttonSummer;
Button buttonWinter;
Button buttonTrailsOn;
Button buttonTrailsOff;

//terrain array
float[][] terrain;

//minor color changes for each cell
int[][] alphaTerrain;

//peasy cam for mouse interactivity
import peasy.*;
PeasyCam cam;

void setup() {
  size(1400, 1000, P3D);
  background(200, 230, 255);
  //traversing the pulseArray, creating a new Pulse instance at each element, using random location
  for (int i = 0; i < numPulses; i++) {
    //Pulse(int newX, int newY);
    pulseArray[i] = new Pulse(int(random(width)), int(random(height)));
  }
  buttonDay = new Button(15, 15, 75, 25, "Day", 14);
  buttonNight = new Button(105, 15, 75, 25, "Night", 14);
  buttonSummer = new Button(250, 15, 75, 25, "Summer", 14);
  buttonWinter = new Button(340, 15, 75, 25, "Winter", 14);

  img = loadImage("map.jpg");
  cam = new PeasyCam(this, 1000);
  cam.setMinimumDistance(100);
  cam.setMaximumDistance(2000);
  cols = w/scl;
  rows = h/scl;
  terrain = new float[cols][rows];
  alphaTerrain = new int[cols][rows];
  for (int x = 0; x< cols; x++){
    for (int y = 0; y < rows; y++){
      alphaTerrain[x][y] = int (random(-10, 10));
    }
  }
}


void draw() {
  background(200, 230, 255);
  cam.setActive(false);  // false to make this camera stop responding to mouse
  pushMatrix();
  translate(0, -200, 0);
  buttonDay.Draw();
  buttonNight.Draw();
  buttonSummer.Draw();
  buttonWinter.Draw();
  popMatrix();
  cam.setActive(true);  // false to make this camera stop responding to mouse
  cam.setYawRotationMode();   // like spinning a globe
  cam.lookAt(mouseX, mouseY, 0);
  if (buttonDay.IsPressed() == true) {
    background(200, 230, 255);
  }
  if (buttonNight.IsPressed() == true) {
    background(0);
  }
  //draw the stars
  for (int i = 0; i < numPulses; i++) {
    pulseArray[i].drawPulse();
  }

  
  //load pixels but do not display the image
  //image(img, 0, 0);
  img.loadPixels();

  //getting pixel colors from the image for every point in the mesh
  for (int y = 0; y < rows; y++) {
    for (int x = 0; x < cols; x++) {
      color pixelColor = img.pixels[(x*4) + ((y*4)*img.width)];
      //getting the 'R' value (B+W image means RGB are all the same)
      float pixel = red(pixelColor);
      terrain[x][y] = pixel/2.1;
    }
  }

  //translate(width/2, height/4+50);
  //rotate and translate for a better view
  rotateX(PI/4);
  //translate(-w/2, -h/4);
  //drawing strips of triangles as the mesh
  //mesh from Daniel Shiffman
  for (int y = 0; y < rows-1; y++) {
    beginShape(TRIANGLE_STRIP);
    for (int x = 0; x < cols; x++) {

      color a = color(16, 84, 10); //dark green
      color b = color(0, 206, 17); //light green
      color c = color(201, 208, 184); //grey/brown
      color d = color(255, 255, 250); //white-ish
      float inter = 0;

      stroke(16, 84, 10, 100);
      strokeWeight(0.25);

      for (float i = 0; i < terrain[x][y]*0.25; i++) {
        color e = lerpColor(a, b, inter);
        inter += 0.08;
        //random change to colors to see triangles
        //int randomCol = int (random(-20, 20));
        fill(e, 200+alphaTerrain[x][y]);
      }
      if (terrain[x][y]*3 > 170) {
        for (float i = 0; i < terrain[x][y]*0.25; i++) {
          color f = lerpColor(b, c, inter);
          fill(f, 200+alphaTerrain[x][y]);
        }
      }
      if (terrain[x][y]*3 > 200) {
        for (float i = 0; i < terrain[x][y]*0.25; i++) {
          color g = lerpColor(c, d, inter);
          fill(g);
        }
      }
      vertex(x*scl, y*scl, terrain[x][y]);
      vertex(x*scl, (y+1)*scl, terrain[x][y+1]);
      //float eColor = terrain[x][y]*3;
      //fill(eColor, eColor, eColor);
    }
    endShape();
  }
}