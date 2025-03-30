int numParticles = 200;  // Minimum 100 particles
BlackHole blackHole;
ArrayList<Matter> particles;

void setup() {
  size(800, 600);
  resetSimulation();  // Initialize the first scene
}

void draw() {
  background(0);
  
  // Draw the black hole
  blackHole.display();
  
  // Update and draw particles
  for (int i = particles.size() - 1; i >= 0; i--) {
    Matter p = particles.get(i);
    p.move(blackHole);
    p.display();
    
    // If particle is close enough, "suck" it in (remove)
    if (PVector.dist(p.position, blackHole.position) < blackHole.size / 2) {
      particles.remove(i);
    }
  }
  
  // If all particles are gone, reset everything
  if (particles.isEmpty()) {
    resetSimulation();
  }
}

// ======================== RESET FUNCTION ========================
void resetSimulation() {
  blackHole = new BlackHole(); // Respawn black hole
  particles = new ArrayList<Matter>(); // Clear & respawn particles
  for (int i = 0; i < numParticles; i++) {
    particles.add(new Matter());
  }
}

// ======================== BLACK HOLE CLASS ========================
class BlackHole {
  PVector position;
  float size = 50;

  BlackHole() {
    position = new PVector(random(width), random(height)); // Random spawn
  }

  void display() {
    fill(255); // White
    noStroke();
    ellipse(position.x, position.y, size, size);
  }
}

// ======================== MATTER CLASS ========================
class Matter {
  PVector position;
  PVector velocity;
  float size;
  color col;

  Matter() {
    // Gaussian distribution for spawning (centered around screen)
    float meanX = width / 2;
    float meanY = height / 2;
    float stdDev = width / 6; // Spread
    position = new PVector(constrain(randomGaussian() * stdDev + meanX, 0, width),
                           constrain(randomGaussian() * stdDev + meanY, 0, height));
    velocity = new PVector(0, 0);
    size = random(5, 15);
    col = color(random(255), random(255), random(255)); // Random color
  }

  void move(BlackHole bh) {
    PVector direction = PVector.sub(bh.position, position); // Move towards black hole
    direction.normalize();
    direction.mult(0.5); // Speed factor
    velocity.add(direction);
    position.add(velocity);
  }

  void display() {
    fill(col);
    noStroke();
    ellipse(position.x, position.y, size, size);
  }
}
