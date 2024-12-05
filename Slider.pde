class Slider {
  //This is the pvector for the start position
  PVector startPosition;   
  //This is the length of the slider
  float length;            
  //This is the set width of the line
  float lineWidth = 10;    
  // this boolean will detect if its vertical or not
  boolean isVertical;      
  // tracking when the slider is active and when its completed
  boolean active = false;   
  boolean completed = false;
  // mouse progress for the slider
  float progress = 0;       
  int spawnTime;            

  Slider(PVector start, float len, boolean vertical) {
    startPosition = start.copy();
    length = len;
    isVertical = vertical;
    spawnTime = millis();
  }

  void display() {
    // Drawing the slider line
    stroke(0, 0, 0);
    strokeWeight(lineWidth);

    if (isVertical) {
      //this detects if the line is vertical or not and changing the position of it if it is
      line(startPosition.x, startPosition.y, startPosition.x, startPosition.y + length); 
    } else {
      line(startPosition.x, startPosition.y, startPosition.x + length, startPosition.y); 
    }

    // Draw the sliding circle
    noStroke();
    fill(255);
    if (isVertical) {
      //this is the progress for both the vertical and horizontal sliders
      ellipse(startPosition.x, startPosition.y + progress, 40, 40); 
    } else {
      ellipse(startPosition.x + progress, startPosition.y, 40, 40); 
    }
  }

  boolean isStartClicked(float mx, float my) {
    if (isVertical) {
      // Check if the mouse is within the radius of the circle for vert
      return dist(mx, my, startPosition.x, startPosition.y) <= 20;
    } else {
      // Check if the mouse is within the radius of the circle for hor
      return dist(mx, my, startPosition.x, startPosition.y) <= 20;
    }
  }

  void activate() {
    active = true; 
  }

  void deactivate() {
    active = false; 
  }

  boolean isActive() {
    return active; 
  }
// This is the main function to track the overall progress of the mouse
  void track(float mx, float my) {
    if (active) {
      if (isVertical) {
        // Update progress based on the vert pos for the mouse
        float distance = constrain(my - startPosition.y, 0, length);
        progress = distance;
      } else {
        // Update progress based on the hor pos of the mouse
        float distance = constrain(mx - startPosition.x, 0, length);
        progress = distance;
      }
    }
  }

  boolean isCompleted() {
    // Check if the slider has been fully completed
    return progress >= length;
  }

  boolean isMissed() {
    // Slider is missed if it is not completed within 2 seconds
    return !active && !completed && millis() - spawnTime > 2000;
  }
}
