int numWalkers = 8;
Walker[] walkers = new Walker[numWalkers];

void setup() {
    size(800, 600);
    for (int i = 0; i < numWalkers; i++) {
        float mass = i + 1; // Increasing mass
        float posY = map(i, 0, numWalkers - 1, 50, height - 50); // Adjusted spacing
        walkers[i] = new Walker(50, posY, mass);
    }
}

void draw() {
    background(0);

    // Draw the red "finish line" in the middle
    stroke(255, 0, 0);
    line(width / 2, 0, width / 2, height);
    noStroke(); // Disable stroke after drawing the line

    for (Walker w : walkers) {
        if (w.position.x < width) { // Only move if within screen bounds
            // Apply constant acceleration to the right
            PVector acceleration = new PVector(0.2 / w.mass, 0); 
            w.applyForce(acceleration);

            // Determine friction coefficient
            float mew = (w.position.x > width / 2) ? 0.4 : 0.01;
            PVector friction = w.calculateFriction(mew);
            w.applyForce(friction);
        }

        w.update();
        w.display();
    }
}

// Reset on mouse click
void mousePressed() {
    setup();
}

class Walker {
    PVector position, velocity, acceleration;
    float mass;
    color walkerColor;
    
    Walker(float x, float y, float m) {
        position = new PVector(x, y);
        velocity = new PVector(0, 0);
        acceleration = new PVector(0, 0);
        mass = m;
        walkerColor = color(random(255), random(255), random(255));
    }

    void applyForce(PVector force) {
        PVector f = PVector.div(force, mass);
        acceleration.add(f);
    }

    PVector calculateFriction(float mew) {
        PVector friction = velocity.copy();
        friction.normalize();
        friction.mult(-mew);
        return friction;
    }

    void update() {
        velocity.add(acceleration);
        position.add(velocity);
        acceleration.mult(0);

        // Stop at the right edge
        if (position.x >= width) {
            position.x = width;
            velocity.set(0, 0); // Stop movement
        }
    }

    void display() {
        fill(walkerColor);
        ellipse(position.x, position.y, mass * 9, mass * 9);
    }
}
