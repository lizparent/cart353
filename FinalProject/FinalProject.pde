// Elizabeth Parent
// CART353 Final Project: MountainScape

//columns and rows of cells
int cols, rows;
//size of each cell
int scl = 3;
int w = 800;
int h = 800;

//boolean for trail
boolean rTrail = false;

//boolean for leanto's
boolean bLeanto = false;

//boolean for labels on/off
boolean labels = true;

//image of the map and trails/lean-to's
PImage img;
PImage img2;

//instantiating legend labels
Button legend;
Button buttonTrail;
Button buttonLeanto;

//instantiating peak labels
Button marcy;
Button gray;
Button algonquin;
Button saddleback;
Button basin;
Button haystack;
Button wright;
Button colden;
Button phelps;
Button allen;

//trees
Tree[][] treeArray = new Tree[cols][rows];

//terrain array
float[][] terrain;
//trails array
float[][] trails;
//lean-to's array
float[][] leantos;

//minor color changes for each cell
int[][] alphaTerrain;

//peasy cam for mouse interactivity
import peasy.*;
PeasyCam cam;

void setup() {
  size(1200, 800, P3D);
  
  //legend labels location, size, label, font
  legend = new Button(230, 70, 250, 30, "Press space to hide labels", 18);
  buttonTrail = new Button(250, 15, 75, 25, "Trails", 16);
  buttonLeanto = new Button(370, 15, 75, 25, "Lean-to's", 16);
  
  //prominent mountains location, label size, font
  marcy = new Button(410, 360, 55, 15, "Marcy", 10);
  gray = new Button(370, 380, 55, 15, "Gray", 10);
  algonquin = new Button(200, 250, 55, 15, "Algonquin", 10);
  saddleback = new Button(625, 300, 65, 15, "Saddleback", 10);
  basin = new Button(550, 330, 65, 15, "Basin", 10);
  haystack = new Button(520, 400, 65, 15, "Haystack", 10);
  wright = new Button(220, 220, 55, 15, "Wright", 10);
  colden = new Button(320, 320, 65, 15, "Colden", 10);
  phelps = new Button(450, 240, 65, 15, "Phelps", 10);
  allen = new Button(390, 550, 65, 15, "Allen", 10);
  
  //load two images, one b&w for elevation, one trail & lean-to map
  img = loadImage("map.jpg");
  img2 = loadImage("trail2.jpg");
  
  //set start zoom to 800
  cam = new PeasyCam(this, 800);
  //zoom in limit: 500
  cam.setMinimumDistance(500);
  //zoom-out limit: 1000
  cam.setMaximumDistance(1000);
  //number of rows and columns is width or height / scale of cell
  cols = w/scl;
  rows = h/scl;
  
  //2d arrays for terrain, trails & lean-to's
  terrain = new float[cols][rows];
  trails = new float[cols][rows];
  leantos = new float[cols][rows];

  //getting a random alpha value for each cell
  alphaTerrain = new int[cols][rows];
  for (int x = 0; x< cols; x++) {
    for (int y = 0; y < rows; y++) {
      alphaTerrain[x][y] = int (random(-10, 10));
    }
  }
}


void draw() {
  background(122, 230, 255);
  
  //legend labels are not warped
  pushMatrix();
  //raising on y-axis
  translate(0, -200, 0);
  rectMode(CORNER);
  legend.Draw();
  buttonTrail.Draw();
  buttonLeanto.Draw();
  rectMode(CENTER);
  //legend markers
  fill(255, 100, 0);
  ellipse(235, 28, 6, 6);
  fill(0);
  rect(355, 28, 6, 6);
  popMatrix();
  
  //mountain labels are warped like the terrain and elevated
  pushMatrix();
  translate(0, 0, 175);
  rectMode(CORNER);
  rotateX(PI/6);
  //if labels are not hidden
  if (labels == true) {
    marcy.Draw();
    gray.Draw();
    algonquin.Draw();
    saddleback.Draw();
    basin.Draw();
    haystack.Draw();
    wright.Draw();
    colden.Draw();
    phelps.Draw();
    allen.Draw();
  }
  popMatrix();
  
  //to disable user from flipping the terrain on the x-axis
  //like spinning a globe
  cam.setYawRotationMode();
  //camera follows mouse position for easy navigation
  cam.lookAt(mouseX, mouseY, 0);

  //load pixels but do not display the image
  img.loadPixels();
  img2.loadPixels();

  //getting pixel colors from the image for every point in the mesh
  for (int y = 0; y < rows; y++) {
    for (int x = 0; x < cols; x++) {
      //getting the pixel color for each cell of the elevation map
      color pixelColor = img.pixels[(x*3) + ((y*3)*img.width)];
      //getting the 'R' value (B+W image means RGB are all the same)
      float pixel = red(pixelColor);
      //dividing for a realistic elevation
      terrain[x][y] = pixel/2.1;
    }
  }
  //pixel color red for trails using "trail.jpg"
  for (int y = 0; y < rows; y++) {
    for (int x = 0; x < cols; x++) {
      //getting the pixel color for each cell of the trail/lean-to map
      color pixelColor = img2.pixels[(x*3) + ((y*3)*img2.width)];
      //getting each RGB value to target red trails only
      float Rpixel = red(pixelColor);
      float Gpixel = green(pixelColor);
      float Bpixel = blue(pixelColor);
      //if colour is close enough to red
      if (Rpixel <= 255 && Rpixel > 180 && Gpixel < 30 && Bpixel < 30) {
        //map markers are higher than map by 1px for visibility
        trails[x][y] = terrain[x][y]+1;
        //boolean is true for that cell
        rTrail = true;
      }
      //if colour is close to yellow, marking lean-to locations
      if (Rpixel > 250 && Gpixel > 250 && Bpixel < 5) {
        //map markers are higher than map by 1px for visibility
        leantos[x][y] = terrain[x][y]+1;
        //boolean is true for that cell
        bLeanto = true;
      }
    }
  }

  //rotate and translate for a better view
  rotateX(PI/6);
  //drawing strips of triangles as the mesh
  //mesh from Daniel Shiffman
  for (int y = 0; y < rows-1; y++) {
    beginShape(TRIANGLE_STRIP);
    for (int x = 0; x < cols; x++) {
      
      //colours of the mountain gradient
      color a = color(0, 60, 0); //dark green
      color b = color(0, 206, 17); //light green
      color c = color(201, 208, 184); //grey/brown
      color d = color(255, 255, 250); //white-ish
      float inter = 0;

      stroke(16, 84, 10, 100);
      strokeWeight(0.25);
      
      //combining two colours and the difference goes up by 'inter'
      for (float i = 0; i < terrain[x][y]*0.25; i++) {
        color e = lerpColor(a, b, inter);
        //increase 'inter' with each step
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
      //drawing the vertices of the triangles in the mesh
      vertex(x*scl, y*scl, terrain[x][y]);
      vertex(x*scl, (y+1)*scl, terrain[x][y+1]);
    }
    endShape();
  }
  //using same columns and rows
  for (int x = 0; x < cols; x++) {
    for (int y = 0; y < rows; y++) {
      //checks boolean and only displays ellipses that have an elevation
      if (rTrail == true && trails[x][y] > 2) {
        fill(255, 100, 0);
        pushMatrix();
        //translates to height of mountains
        translate(x*scl, y*scl, trails[x][y]);
        ellipse(0, 0, 2.5, 2.5);
        popMatrix();
      }
      //checks boolean and only displays rectangles that have an elevation
      if (bLeanto == true && leantos[x][y] > 2) {
        fill(0);
        pushMatrix();
        //translates to height of mountains
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
void keyPressed() {
  //If the spacebar is pressed, turn off labels
  if (key == 32) {
    if (labels == true) {
      labels = false;
    }
    else {
      labels = true;
    }
  }
}