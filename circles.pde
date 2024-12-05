class Circle {
  //Same exact variables except no vertical or horizontal settings since its not a slider
  PVector position;
  float size = 40;
  // These are the variables for the outline
  float outlineSize;
  PVector outlineVelocity;
  PVector outlineAcceleration;
  boolean shrinking = true;
  int spawnTime;
//This are the set positions of the circle and the speed/velocity for the outline
  Circle(PVector pos) {
    position = pos.copy();
    outlineSize = size + 50;
    outlineVelocity = new PVector(0, -2);
    outlineAcceleration = new PVector(0, -0.1);
    //Tracks how long the circle's been spawned for
    spawnTime = millis();
  }
//This function updates the shrinking for the outline
  void update() {
    if (shrinking) {
      outlineVelocity.add(outlineAcceleration);
      outlineSize += outlineVelocity.y;
      if (outlineSize <= size) {
        // Stops the outline when it hits the circle size
        outlineSize = size;
        shrinking = false;
      }
    }
  }
//Main display of the circle and outline
  void display() {
    noFill();
    stroke(255);
    strokeWeight(2);
    ellipse(position.x, position.y, outlineSize, outlineSize);
    fill(0, 0, 0);
    noStroke();
    ellipse(position.x, position.y, size, size);
  }

  boolean isClicked(float mx, float my) {
    return dist(mx, my, position.x, position.y) <= size / 2;
  }

  boolean isMissed() {
    return shrinking == false && millis() - spawnTime > 2000;
  }
}
