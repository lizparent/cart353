// The Nature of Code
// Daniel Shiffman
// http://natureofcode.com

class Mover {

  PVector position;
  PVector velocity;
  PVector acceleration;
  float mass;
  float g = 0.4;
  float ballSize;

  Mover(float m, float x, float y) {
    mass = m;
    position = new PVector(x, y);
    velocity = new PVector(0, 0);
    acceleration = new PVector(0, 0);
    ballSize = 20;
  }

  void applyForce(PVector force) {
    PVector f = PVector.div(force, mass);
    acceleration.add(f);
  }

  // our attract method, which takes a mover as well as a multiplier (which impacts on direction)
  PVector attract(Mover m, float multiplier) {
    PVector force = PVector.sub(position, m.position);             // Calculate direction of force
    float distance = force.mag();                                 // Distance between objects
    distance = constrain(distance, 5.0, 25.0);                             // Limiting the distance to eliminate "extreme" results for very close or very far objects
    force.normalize();                                            // Normalize vector (distance doesn't matter here, we just want this vector for direction

    float strength = (g * mass * m.mass) / (distance * distance); // Calculate gravitional force magnitude
    force.mult(strength * multiplier);                                         // Get force vector --> magnitude * direction
    return force;
  }

  // an overloaded version of the attract method that takes a plain PVector as an argument, which we can use for the mouse
  PVector attract(PVector v, float multiplier) {
    PVector force = PVector.sub(v, position);             // Calculate direction of force
    float distance = force.mag();                                 // Distance between objects
    distance = constrain(distance, 5.0, 8.0);                    // Limiting the distance to eliminate "extreme" results for very close or very far objects
    force.normalize();                                            // Normalize vector (distance doesn't matter here, we just want this vector for direction

    float strength = (g * mass * 20) / (distance * distance); // let's say mouse mass is 20
    force.mult(strength * multiplier);                                         // Get force vector --> magnitude * direction
    return force;
  }

  void update() {
    velocity.add(acceleration);
    position.add(velocity);
    acceleration.mult(0);
  }

  void display() {
    noStroke();
    fill(255);
    ellipse(position.x, position.y, ballSize, ballSize);
  }
  
  boolean collidesWith(Snow other) {
    float distance = dist(position.x, position.y, other.location.x, other.location.y);
    float sumRadius = ballSize/2 + other.snowHeight/2;

    if (distance < sumRadius) {
      return true;
    }
    return false;
  }
  
  boolean magnetStop() {
    float distance = dist(position.x, position.y, mouseX, mouseY);
    if (distance > 150) {
      return true;
    }
    else{
      return false;
    }
  }
}