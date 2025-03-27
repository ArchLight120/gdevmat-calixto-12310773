// Processing Sketch for Quiz #1
float amplitude = 50; // Initial amplitude
float frequency = 0.1; // Initial frequency
float phase = 0;

void setup() {
  size(1280, 720, P3D);
}

void draw() {
  background(100);
  drawAxes();
  drawParabola();
  drawLineFunction();
  drawSineWave();
}

void drawAxes() {
  stroke(255);
  line(width/2, 0, width/2, height); // y-axis
  line(0, height/2, width, height/2); // x-axis
}

void drawParabola() {
  stroke(255, 255, 0);
  noFill();
  beginShape();
  for (float x = -width/2; x < width/2; x += 1) {
    float y = sq(x / 20) - 15 * (x / 20) - 3;
    vertex(width/2 + x, height/2 - y);
  }
  endShape();
}

void drawLineFunction() {
  stroke(128, 0, 128);
  beginShape();
  for (float x = -width/2; x < width/2; x += 1) {
    float y = -5 * (x / 20) + 30;
    vertex(width/2 + x, height/2 - y);
  }
  endShape();
}

void drawSineWave() {
  stroke(0, 0, 255);
  noFill();
  beginShape();
  for (float x = -width/2; x < width/2; x += 1) {
    float y = amplitude * sin(frequency * x + phase);
    vertex(width/2 + x, height/2 - y);
  }
  endShape();
  phase += 0.1; // Move sine wave over time
}

void keyPressed() {
  if (key == 'w') amplitude += 5;
  if (key == 's') amplitude -= 5;
  if (key == 'd') frequency += 0.01;
  if (key == 'a') frequency -= 0.01;
}
