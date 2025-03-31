int numWalkers = 100;
ArrayList<Walker> walkers;

void setup() {
  size(1780, 980);
  walkers = new ArrayList<Walker>();
  for (int i = 0; i < numWalkers; i++) {
    walkers.add(new Walker());
  }
}

void draw() {
  background(0);
  
  for (Walker w : walkers) {
    w.move();
    w.display();
  }
}

// ======================== WALKER CLASS ========================
class Walker {
  PVector position;
  PVector velocity;
  PVector acceleration;
  float size;
  color col;

  Walker() {
    position = new PVector(random(width), random(height)); // Random spawn
    velocity = new PVector(0, 0); // Starts still
    acceleration = new PVector(0, 0);
    size = random(5, 15); // Random size
    col = color(random(255), random(255), random(255)); // Random color
  }

  void move() {
    // Get direction towards mouse
    PVector direction = PVector.sub(new PVector(mouseX, mouseY), position);
    direction.normalize(); // Normalize to unit vector
    direction.mult(0.2); // Scale acceleration
    
    acceleration.set(direction); // Set acceleration
    velocity.add(acceleration); // Update velocity
    position.add(velocity); // Update position
  }

  void display() {
    fill(col);
    noStroke();
    ellipse(position.x, position.y, size, size);
  }
}
