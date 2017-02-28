//Snowflake Eater

//"Snow" by Michael Pinn
import java.util.*;

ArrayList<Snow> snows;
Mover[] movers = new Mover[1];

boolean gravity = false;

void setup() {
  size(600, 600);
  snows = new ArrayList<Snow>();
  loadSnow();
  for (int i = 0; i < movers.length; i++) {
    movers[i] = new Mover(1, random(width), random(height));
  }
}

void draw() {
  background(220, 230, 255);
  if ((frameCount % 10) == 0) {
    addSnow();
  }
textSize(32);
text("Snowflake Collector", 10, 30); 
  drawSnow();
  for (int i = 0; i < snows.size(); i++) {
    Snow s = snows.get(i);
    if (s.death) {
      snows.remove(s);
    }
  }

  for (int i = 0; i < movers.length; i++) {
    //finegrain sand
    float c = 0.13;
    PVector sandpaper = movers[i].velocity.get();
    sandpaper.mult(-1);
    sandpaper.normalize();
    sandpaper.mult(c);
    //ice
    c = 0.05;
    PVector antifriction = movers[i].velocity.get();
    // this is antifriction - so our direction is the same as velocity
    antifriction.mult(1); 
    antifriction.normalize();
    antifriction.mult(c);

    // check if movers[i] is in the zone of sandpaper 2: 350-450 //  && movers[i].position.y >= 170 && movers[i].position.y <= 200
    if (movers[i].position.x >= 350 && movers[i].position.x <= 450 && movers[i].position.y <= 200) {
      movers[i].applyForce(sandpaper);
    } 

    // check if movers[i] is in the zone of antifriction: 500-600 //  && movers[i].position.y >= 170 && movers[i].position.y <= 200
    else if (movers[i].position.x >= 500 && movers[i].position.x <= 600 && movers[i].position.y <= 200) {
      movers[i].applyForce(antifriction);
    }

    for (int j=0; j<snows.size(); j++) {
      if (movers[i].collidesWith(snows.get(j))) {
        movers[i].ballSize = movers[i].ballSize+0.5;
        Snow s = snows.get(j);
        s.death = true;
        break;
      }
    }
    if (movers[i].position.x >= width){
      movers[i].position.x = width;
    }
    if (movers[i].position.x <= 0){
      movers[i].position.x = 0;
    }
    if (movers[i].position.y >= height){
      movers[i].position.y = height;
    }
    if (movers[i].position.y <= 0){
      movers[i].position.y = 0;
    }
    
    if (movers[i].magnetStop()){
      gravity = true;
      movers[i].position.y = movers[i].position.y+1;
    }
    else{
    gravity = false;
    }
  }

  // draw sandpaper:
  fill(230, 200, 100);
  rect(350, 0, 100, 200);

  // draw antifriction:
  fill(210, 225, 255);
  stroke(255);
  rect(500, 0, 100, 200);

  for (Mover i : movers) {

    // look at every other mover
    for (Mover j : movers) {
      if (i != j) {

        // work out the force the other mover is having on mover i
        PVector force = j.attract(i, -0.1);

        // apply that force to mover i
        i.applyForce(force);
      }
    }
if (gravity == false) {
    // next, work out the force the mouse exerts on mover i
    PVector mouse = new PVector(mouseX, mouseY);
    PVector mforce = i.attract(mouse, 1);

    // apply that force to mover i
    i.applyForce(mforce);
}
    // finally, update and display mover i
    i.update();
    i.display();
  }

}

void loadSnow() {
  for (int i = 0; i < 1; i++) {
    snows.add(new Snow());
  }
}

void drawSnow() {
  for (Snow s : snows) {
    s.display();
  }
}

void addSnow() {
  snows.add(new Snow());
}