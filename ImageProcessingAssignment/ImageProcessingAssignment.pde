PImage frog;
PImage fish;

int opacity = 255;

Presentation Pres1;
Vignette Vig1;

void setup() {
  size(500, 500);
  frog = loadImage("frog.jpg");
  fish = loadImage("fish.jpg");
  
  Pres1 = new Presentation();
  Vig1 = new Vignette(width/2, height/2, width);
  
}

void draw() {
  background(0);
  
  tint(255, 255);
  image(frog, 0, 0);
  tint(255, opacity);
  image(fish, 0, 0);
  
  
  if (mousePressed && (mouseButton == LEFT)) {
    opacity--;
    if (opacity < 0) {
      opacity = 0;
    }
  }
  
  if (mousePressed && (mouseButton == RIGHT)) {
    opacity++;
    if (opacity > 255) {
      opacity = 255;
    }
  }
  
  if (key == 'v' || key == 'V') {
    Vig1.display();
  }
  
  if (key == 'b' || key == 'B') {
    blend(frog, 50, 0, 50, 500, 50, 0, 50, 500, DARKEST);
    blend(fish, 50, 0, 50, 500, 50, 0, 50, 500, DARKEST);
    
    blend(frog, 150, 0, 50, 500, 150, 0, 50, 500, DARKEST);
    blend(fish, 150, 0, 50, 500, 150, 0, 50, 500, DARKEST);
    
    blend(frog, 250, 0, 50, 500, 250, 0, 50, 500, DARKEST);
    blend(fish, 250, 0, 50, 500, 250, 0, 50, 500, DARKEST);
    
    blend(frog, 350, 0, 50, 500, 350, 0, 50, 500, DARKEST);
    blend(fish, 350, 0, 50, 500, 350, 0, 50, 500, DARKEST);
    
    blend(frog, 450, 0, 50, 500, 450, 0, 50, 500, DARKEST);
    blend(fish, 450, 0, 50, 500, 450, 0, 50, 500, DARKEST);
  }
  
  Pres1.display();
}

void keyPressed() {
  if (key == 's' || key =='S') {
    save("remixed.jpg");
  }
  if (key == 32) {
    Pres1.disappear();
  }
}