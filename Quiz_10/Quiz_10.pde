int numWalkers = 10;
Walker[] walkers = new Walker[numWalkers];
Liquid water;

void setup() {
    size(800, 600);

    // Initialize walkers
    for (int i = 0; i < numWalkers; i++) {
        float mass = random(2, 5); // Random mass between 2 and 5
        float posX = map(i, 0, numWalkers - 1, 50, width - 50); // Space evenly
        walkers[i] = new Walker(posX, -20, mass); // Start slightly above the screen
    }

    // Initialize liquid (water)
    water = new Liquid(0, height / 2, width, height / 2, 0.2); // Stronger drag effect
}

void draw() {
    background(0);
    
    // Draw water
    water.display();

    for (Walker w : walkers) {
        if (!w.stopped) { // Apply forces only if the walker hasn't stopped
            // Apply wind
            PVector wind = new PVector(0.1, 0);
            w.applyForce(wind);

            // Apply gravity (pulls downward)
            PVector gravity = new PVector(0, 0.15 * w.mass);
            w.applyForce(gravity);

            // Apply drag if the walker is in the liquid
            if (water.contains(w)) {
                PVector drag = water.calculateDrag(w);
                w.applyForce(drag);
            }

            w.update();
        }
        
        w.display();
    }
}

// Reset on mouse click
void mousePressed() {
    setup();
}

// Walker class
class Walker {
    PVector position, velocity, acceleration;
    float mass;
    color walkerColor;
    boolean stopped = false; // New variable to track if it has stopped

    Walker(float x, float y, float m) {
        position = new PVector(x, y);
        velocity = new PVector(0, 0);
        acceleration = new PVector(0, 0);
        mass = m;
        walkerColor = color(random(255), random(255), random(255)); // Random color for each walker
    }

    void applyForce(PVector force) {
        PVector f = PVector.div(force, mass);
        acceleration.add(f);
    }

    void update() {
        if (!stopped) {
            velocity.add(acceleration);
            position.add(velocity);
            acceleration.mult(0);

            // Boundary checks to keep the walker within screen bounds
            float radius = mass * 10 / 2;

            // Prevent walker from going off the left or right edges
            if (position.x - radius < 0) {
                position.x = radius;  // Set to left edge
                velocity.x *= -0.5;    // Reverse and reduce velocity (bounce effect)
            } else if (position.x + radius > width) {
                position.x = width - radius; // Set to right edge
                velocity.x *= -0.5;          // Reverse and reduce velocity (bounce effect)
            }

            // Prevent walker from going off the top or bottom edges
            if (position.y - radius < 0) {
                position.y = radius;  // Set to top edge
                velocity.y *= -0.5;    // Reverse and reduce velocity (bounce effect)
            } else if (position.y + radius > height) {
                position.y = height - radius; // Set to bottom edge
                velocity.y *= -0.5;           // Reverse and reduce velocity (bounce effect)
                if (position.y >= height - radius) { // Stop if at the bottom
                    velocity.set(0, 0); // Stop movement
                    stopped = true;
                }
            }
        }
    }

    void display() {
        fill(walkerColor);
        ellipse(position.x, position.y, mass * 10, mass * 10); // Use mass to determine size
    }
}

// Liquid class
class Liquid {
    float x, y, w, h, dragCoefficient;

    Liquid(float x, float y, float w, float h, float c) {
        this.x = x;
        this.y = y;
        this.w = w;
        this.h = h;
        dragCoefficient = c;
    }

    boolean contains(Walker w) {
        return w.position.y >= y; // Walker enters liquid
    }

    PVector calculateDrag(Walker w) {
        float speed = w.velocity.mag();
        float dragMagnitude = dragCoefficient * speed * speed; // Quadratic drag

        PVector drag = w.velocity.copy();
        drag.normalize();
        drag.mult(-dragMagnitude); // Oppose motion
        return drag;
    }

    void display() {
        fill(0, 0, 255, 150); // Semi-transparent blue
        rect(x, y, w, h);
    }
}
