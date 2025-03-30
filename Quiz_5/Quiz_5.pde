PVector walkerPos, biasedWalkerPos;
PVector walkerVel;
int walkerSize = 8;

void setup() {
  size(1780, 980);
  walkerPos = new PVector(width / 2, height / 2);
  biasedWalkerPos = new PVector(width / 2, height / 2);
  walkerVel = PVector.random2D().mult(3);
  background(50);
}

void draw() {
  fill(random(255), random(255), random(255), random(50, 100));
  noStroke();
  
  // Move both walkers
  randomWalk();
  randomWalkBiased();
  moveAndBounce();
}

void randomWalk() {
  PVector step = new PVector(int(random(-1, 2)), int(random(-1, 2)));
  walkerPos.add(step.mult(5));
  
  // Keep inside the screen
  walkerPos.x = constrain(walkerPos.x, 0, width);
  walkerPos.y = constrain(walkerPos.y, 0, height);
  
  ellipse(walkerPos.x, walkerPos.y, walkerSize, walkerSize);
}

void randomWalkBiased() {
  float r = random(1);
  PVector step = new PVector();
  
  if (r < 0.4) step.set(1, 0);  
  else if (r < 0.6) step.set(-1, 0);
  else if (r < 0.8) step.set(0, 1);
  else step.set(0, -1);

  biasedWalkerPos.add(step.mult(5));

  // Keep inside the screen
  biasedWalkerPos.x = constrain(biasedWalkerPos.x, 0, width);
  biasedWalkerPos.y = constrain(biasedWalkerPos.y, 0, height);
  
  ellipse(biasedWalkerPos.x, biasedWalkerPos.y, walkerSize, walkerSize);
}

void moveAndBounce() {
  walkerPos.add(walkerVel);
  
  // Bounce off walls
  if (walkerPos.x <= 0 || walkerPos.x >= width) walkerVel.x *= -1;
  if (walkerPos.y <= 0 || walkerPos.y >= height) walkerVel.y *= -1;

  ellipse(walkerPos.x, walkerPos.y, walkerSize, walkerSize);
}
