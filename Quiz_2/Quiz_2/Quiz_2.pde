Walker walker1, walker2;

void setup() {
  size(600, 600);
  background(0);
  walker1 = new Walker(width/3, height/2);
  walker2 = new Walker(2*width/3, height/2);
}

void draw() {
  walker1.randomWalk();
  walker2.randomWalkBiased();
  walker1.display();
  walker2.display();
}

class Walker {
  float x, y;
  
  Walker(float startX, float startY) {
    x = startX;
    y = startY;
  }
  
  void randomWalk() {
    float choice = random(8);
    if (choice < 1) x += 5;  // Right
    else if (choice < 2) x -= 5;  // Left
    else if (choice < 3) y += 5;  // Down
    else if (choice < 4) y -= 5;  // Up
    else if (choice < 5) { x += 5; y += 5; }  // Bottom right
    else if (choice < 6) { x -= 5; y += 5; }  // Bottom left
    else if (choice < 7) { x += 5; y -= 5; }  // Top right
    else { x -= 5; y -= 5; }  // Top left
    constrainPos();
  }
  
  void randomWalkBiased() {
    float choice = random(100);
    if (choice < 40) x += 5;  // 40% chance to move right
    else if (choice < 60) x -= 5;  // 20% left
    else if (choice < 80) y -= 5;  // 20% up
    else y += 5;  // 20% down
    constrainPos();
  }
  
  void constrainPos() {
    x = constrain(x, 0, width);
    y = constrain(y, 0, height);
  }
  
  void display() {
    noStroke();
    fill(random(255), random(255), random(255), random(50, 100));
    ellipse(x, y, 10, 10);
  }
}
