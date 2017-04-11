// Elizabeth Parent
// CART353 Final Project: MountainScape

int cols, rows;
//size of each cell
int scl = 3;
int w = 800;
int h = 800;

//boolean for day and night
boolean day = true;

//boolean for trail
boolean rTrail = false;

//boolean for leanto's
boolean bLeanto = false;

//image of the map and trails
PImage img;
PImage img2;

//instantiating buttons
Button buttonSummer;
Button buttonWinter;
Button buttonTrailsOn;
Button buttonTrailsOff;

//trees
Tree[][] treeArray = new Tree[500][500];

//terrain array
float[][] terrain;
float[][] trails;
float[][] leantos;

//minor color changes for each cell
int[][] alphaTerrain;

//peasy cam for mouse interactivity
import peasy.*;
PeasyCam cam;

void setup() {
  size(1200, 800, P3D);

  buttonSummer = new Button(250, 15, 75, 25, "Trails", 16);
  buttonWinter = new Button(370, 15, 75, 25, "Lean-to's", 16);

  img = loadImage("map.jpg");
  img2 = loadImage("trail2.jpg");

  cam = new PeasyCam(this, 800);
  cam.setMinimumDistance(500);
  cam.setMaximumDistance(1000);
  cols = w/scl;
  rows = h/scl;
  terrain = new float[cols][rows];
  trails = new float[cols][rows];
  leantos = new float[cols][rows];

  alphaTerrain = new int[cols][rows];
  for (int x = 0; x< cols; x++) {
    for (int y = 0; y < rows; y++) {
      alphaTerrain[x][y] = int (random(-10, 10));
    }
  }
}


void draw() {
  background(122, 230, 255);
  cam.setActive(false);  // false to make this camera stop responding to mouse
  pushMatrix();
  translate(0, -200, 0);
  
  rectMode(CORNER);
  buttonSummer.Draw();
  buttonWinter.Draw();
  
  rectMode(CENTER);
  fill(255, 100, 0);
  ellipse(235, 28, 6, 6);
  fill(0);
  rect(355, 28, 6, 6);
  
  popMatrix();
  cam.setActive(true);  // false to make this camera stop responding to mouse
  cam.setYawRotationMode();   // like spinning a globe
  cam.lookAt(mouseX, mouseY, 0);

  //load pixels but do not display the image
  //image(img, 0, 0);
  img.loadPixels();
  pushMatrix();
  rotateX(PI/4);
  //image(img2, 0, 0);
  img2.loadPixels();
  popMatrix();

  //getting pixel colors from the image for every point in the mesh
  for (int y = 0; y < rows; y++) {
    for (int x = 0; x < cols; x++) {
      color pixelColor = img.pixels[(x*3) + ((y*3)*img.width)];
      //getting the 'R' value (B+W image means RGB are all the same)
      float pixel = red(pixelColor);
      terrain[x][y] = pixel/2.1;
    }
  }
  //pixel color red for trails using "trail.jpg"
  for (int y = 0; y < rows; y++) {
    for (int x = 0; x < cols; x++) {
      color pixelColor = img2.pixels[(x*3) + ((y*3)*img2.width)];
      //getting the 'R' value
      float Rpixel = red(pixelColor);
      float Gpixel = green(pixelColor);
      float Bpixel = blue(pixelColor);
      if (Rpixel <= 255 && Rpixel > 180 && Gpixel < 30 && Bpixel < 30) {
        trails[x][y] = terrain[x][y]+1;
        rTrail = true;
      }
      if (Rpixel > 250 && Gpixel > 250 && Bpixel < 5) {
        leantos[x][y] = terrain[x][y]+1;
        bLeanto = true;
      }
    }
  }

  //rotate and translate for a better view
  rotateX(PI/4);
  //drawing strips of triangles as the mesh
  //mesh from Daniel Shiffman
  for (int y = 0; y < rows-1; y++) {
    beginShape(TRIANGLE_STRIP);
    for (int x = 0; x < cols; x++) {

      color a = color(0, 60, 0); //dark green
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
        fill(e, 200+alphaTerrain[x][y]);
      }
      if (terrain[x][y]*3 > 250) {
        for (float i = 0; i < terrain[x][y]*0.25; i++) {
          color f = lerpColor(b, c, inter);
          fill(f);
        }
      }
      if (terrain[x][y]*3 > 280) {
        for (float i = 0; i < terrain[x][y]*0.25; i++) {
          color g = lerpColor(c, d, inter);
          fill(g);
        }
      }
      vertex(x*scl, y*scl, terrain[x][y]);
      vertex(x*scl, (y+1)*scl, terrain[x][y+1]);
    }
    endShape();
  }
  for (int x = 0; x < cols; x++) {
    for (int y = 0; y < rows; y++) {
      if (rTrail == true && trails[x][y] > 2) {
        fill(255, 100, 0);
        pushMatrix();
        translate(x*scl, y*scl, trails[x][y]);
        ellipse(0, 0, 2.5, 2.5);
        popMatrix();
      }
      if (bLeanto == true && leantos[x][y] > 2) {
        fill(0);
        pushMatrix();
        translate(x*scl, y*scl, leantos[x][y]);
        rect(0, 0, 3, 3);
        popMatrix();
      }
      //tree array
      //for (int i = 0; i < cols; i++) {
      //  for (int j = 0; j < rows; j++) {
      //    if (terrain[x][y] > 2) {
      //      treeArray[cols][rows] = new Tree(0, 0);
      //    }
      //  }
      //}
    }
  }
}