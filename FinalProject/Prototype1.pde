// Elizabeth Parent
// CART353 Prototype 1

int cols, rows;
//size of each cell
int scl = 4;
int w = 1400;
int h = 1000;

//image of the map
PImage img;

//terrain array
float[][] terrain;

//peasy cam for mouse interactivity
import peasy.*;
PeasyCam cam;

void setup() {
  size(1400, 1000, P3D);
  img = loadImage("map.jpg");
  cam = new PeasyCam(this, 500);
  cam.setMinimumDistance(50);
  cam.setMaximumDistance(1000);
  cols = w / scl;
  rows = h/ scl;
  terrain = new float[cols][rows];
}


void draw() {
  background(200, 230, 255);
  //load pixels but do not display the image
  //image(img, 0, 0);
  img.loadPixels();

  //getting pixel colors from the image for every point in the mesh
  for (int y = 0; y < rows; y++) {
    for (int x = 0; x < cols; x++) {
      color pixelColor = img.pixels[(x*4) + ((y*4)*img.width)];
      //getting the 'R' value (B+W image means RGB are all the same)
      float pixel = red(pixelColor);
      terrain[x][y] = pixel/3;

      if (terrain[x][y] >= 45) {
        //snow-capped peaks
      }
    }
  }

  stroke(255, 100);
  fill(0, 220);

  //translate(width/2, height/4+50);
  //rotate and translate for a better view
  rotateX(PI/4);
  translate(-w/2, -h/4);
  //drawing strips of triangles as the mesh
  //mesh from Daniel Shiffman
  for (int y = 0; y < rows-1; y++) {
    beginShape(TRIANGLE_STRIP);
    for (int x = 0; x < cols; x++) {
      vertex(x*scl, y*scl, terrain[x][y]);
      vertex(x*scl, (y+1)*scl, terrain[x][y+1]);
    }
    endShape();
  }
}