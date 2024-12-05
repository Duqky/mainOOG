ArrayList<Circle> circles;
Button playButton, settingsButton, creditsButton;

String currentScreen = "menu"; // "menu", "play", "settings", "credits"
int score = 0;
int spawnInterval = 1000; // Time interval (in ms) to spawn new circles
int lastSpawnTime = 0;

void setup() {
  size(600, 600);

  // Initialize menu buttons
  playButton = new Button(width / 2 - 50, 100, 100, 40, "Play");
  settingsButton = new Button(width / 2 - 50, 160, 100, 40, "Settings");
  creditsButton = new Button(width / 2 - 50, 220, 100, 40, "Credits");

  // Initialize circle list
  circles = new ArrayList<Circle>();
}

void draw() {
  background(51);

  if (currentScreen.equals("menu")) { // Menu Screen
    playButton.display();
    settingsButton.display();
    creditsButton.display();
  } else if (currentScreen.equals("play")) { // Play Screen
    // Spawn circles randomly at intervals
    if (millis() - lastSpawnTime > spawnInterval) {
      spawnCircle();
      lastSpawnTime = millis();
    }

    // Update and display circles
    for (int i = circles.size() - 1; i >= 0; i--) {
      Circle c = circles.get(i);
      c.update();
      c.display();
    }

    // Display score
    fill(255);
    textAlign(LEFT, TOP);
    textSize(16);
    text("Score: " + score, 10, 10);

    // Game Over Condition
    if (circles.isEmpty() && millis() - lastSpawnTime > spawnInterval * 2) {
      fill(255, 0, 0);
      textAlign(CENTER, CENTER);
      textSize(32);
      text("Game Over", width / 2, height / 2);
      textSize(16);
      text("Press 'R' to Restart", width / 2, height / 2 + 40);
    }
  } else if (currentScreen.equals("settings")) { // Settings Screen
    fill(255);
    textAlign(CENTER, CENTER);
    textSize(32);
    text("Settings Screen", width / 2, height / 2);
  } else if (currentScreen.equals("credits")) { // Credits Screen
    fill(255);
    textAlign(CENTER, CENTER);
    textSize(32);
    text("Credits Screen", width / 2, height / 2);
  }
}

void mousePressed() {
  if (currentScreen.equals("menu")) { // Menu Screen
    if (playButton.isHovered()) {
      currentScreen = "play";
      initializeGame();
    } else if (settingsButton.isHovered()) {
      currentScreen = "settings";
    } else if (creditsButton.isHovered()) {
      currentScreen = "credits";
    }
  } else if (currentScreen.equals("play")) { // Play Screen
    for (int i = circles.size() - 1; i >= 0; i--) {
      Circle c = circles.get(i);
      if (c.isClicked(mouseX, mouseY)) {
        circles.remove(i);
        score += 100; // Increase score when circle is clicked
        break;
      }
    }
  }
}

void keyPressed() {
  if (key == 'r' || key == 'R') {
    initializeGame(); // Restart game
  } else if (key == 'm' || key == 'M') {
    currentScreen = "menu"; // Return to menu
  }
}

void initializeGame() {
  score = 0;
  circles.clear();
  lastSpawnTime = millis(); // Reset spawn timer
}

void spawnCircle() {
  // Spawn a new circle at a random position
  float x = random(100, width - 100);
  float y = random(100, height - 100);
  circles.add(new Circle(new PVector(x, y)));
}
