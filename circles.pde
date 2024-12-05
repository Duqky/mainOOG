class Circle {
  PVector position;        // Position of the circle
  float size = 40;         // Diameter of the circle
  float outlineSize;       // Current size of the outline
  PVector outlineVelocity; // Velocity of the shrinking outline
  PVector outlineAcceleration; // Acceleration of the outline
  boolean shrinking = true;

  Circle(PVector pos) {
    position = pos.copy();
    outlineSize = size + 100; // Initial outline size
    outlineVelocity = new PVector(0, -1); // Start shrinking at a constant rate
    outlineAcceleration = new PVector(0, -0.1); // Slowly accelerate the shrinking
  }

  void update() {
    if (shrinking) {
      outlineVelocity.add(outlineAcceleration);
      outlineSize += outlineVelocity.y;
      if (outlineSize <= size) {
        outlineSize = size;
        shrinking = false;
      }
    }
  }

  void display() {
    // Draw the shrinking outline
    noFill();
    stroke(255);
    strokeWeight(2);
    ellipse(position.x, position.y, outlineSize, outlineSize);

    // Draw the main circle
    fill(255, 0, 0);
    noStroke();
    ellipse(position.x, position.y, size, size);
  }

  boolean isClicked(float mx, float my) {
    float radius = size / 2;
    return dist(mx, my, position.x, position.y) <= radius;
  }
}
