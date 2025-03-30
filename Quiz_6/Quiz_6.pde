void setup() {
  size(600, 400);
  background(50);
  
  PVector hiltStart = new PVector(width / 2 - 50, height / 2);
  PVector hiltEnd = new PVector(width / 2 + 50, height / 2);
  
  PVector saberLeft = new PVector(width / 2 - 200, height / 2);
  PVector saberRight = new PVector(width / 2 + 200, height / 2);
  
  // Red Outer Glow
  stroke(255, 0, 0, 150); // Red with transparency
  strokeWeight(20);
  line(saberLeft.x, saberLeft.y, hiltStart.x, hiltStart.y);
  line(hiltEnd.x, hiltEnd.y, saberRight.x, saberRight.y);
  
  // White Inner Core
  stroke(255); // White
  strokeWeight(8);
  line(saberLeft.x, saberLeft.y, hiltStart.x, hiltStart.y);
  line(hiltEnd.x, hiltEnd.y, saberRight.x, saberRight.y);
  
  // Black Handle (Hilt)
  stroke(0); // Black
  strokeWeight(17);
  line(hiltStart.x, hiltStart.y, hiltEnd.x, hiltEnd.y);
  
  // Hilt Details (Add Gray Bands for Style)
  stroke(100);
  strokeWeight(6);
  for (int i = -40; i <= 40; i += 20) {
    line(width / 2 + i, height / 2 - 10, width / 2 + i, height / 2 + 10);
  }
  
  // Compute & Print Magnitude of One Side
  PVector sideVector = PVector.sub(saberRight, hiltEnd);
  println("Magnitude of one side:", sideVector.mag());
}
