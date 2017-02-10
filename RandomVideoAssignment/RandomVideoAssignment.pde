import processing.video.*;
Capture video;

int cols;
int rows;
int scl = 20;
int w = 500;
int h = 500;

float[][] terrain;
Walker w1;


void setup() {
  size(500, 500);
  background(100, 160, 130);
  frameRate(1);

  video = new Capture(this, 640, 480);
  video.start();

  cols = w/scl;
  rows = h/scl;
  terrain = new float[cols][rows];
  float yoff = 0;
  for (int y = 0; y < rows; y++) {
    float xoff = 0;
    for (int x = 0; x < cols; x++) {
      terrain[x][y] = map(noise(xoff, yoff), 0, 1, -30, 30);
      xoff += 0.05;
    }
    yoff += 0.05;
  }
  w1 = new Walker();
}

void mousePressed() {
  video.read();
}

void captureEvent(Capture video) {
}

void draw() {
  tint(255, 50);
  image(video, 0, 0);

  stroke(175);
  //noFill();
  fill(190, 75, 60, 50);
  for (int y = 0; y < rows; y++) {
    for (int x = 0; x < cols; x++) {
      rect((x*scl)+terrain[x][y], (y*scl)+terrain[x][y], scl, scl);
    }
  }

  w1.step();
  w1.display();

  fill(255);
  text("CLICK TO CAPTURE", width/2, 465);
}

float montecarlo() {
  while (true) {
    float r1 = random(1);
    float probability = r1;
    float r2 = random(1);
    if (r2 < probability) {
      return r1;
    }
  }
}