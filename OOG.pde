
// the list for circles and sliders
ArrayList<Circle> circles;
ArrayList<Slider> sliders;
// all the buttons used in the game
Button playButton, settingsButton, creditsButton, playAgainButton, mainMenuButton;


String currentScreen = "menu"; 
int score = 0;
int spawnInterval = 1000; // milliseconds to spawn new objects
int lastSpawnTime = 0;

void setup() {
  size(600, 600);

  // creating the menu buttons
  playButton = new Button(width / 2 - 50, 100, 100, 40, "Play");
  settingsButton = new Button(width / 2 - 50, 160, 100, 40, "Settings");
  creditsButton = new Button(width / 2 - 50, 220, 100, 40, "Credits");
  playAgainButton = new Button(width / 2 - 50, 200, 100, 40, "Play Again");
  mainMenuButton = new Button(width / 2 - 50, 260, 100, 40, "Main Menu");

  // empty object lists for da circles and sliders
  circles = new ArrayList<Circle>();
  sliders = new ArrayList<Slider>();
}

void draw() {
  background(65);

  if (currentScreen.equals("menu")) { // Menu Screen
    playButton.display();
    settingsButton.display();
    creditsButton.display();
    fill(255);
    text("Circle Clicking Game", width/2, height/2);
    // Play Screen
  } else if (currentScreen.equals("play")) { 
    // Spawn circles or sliders randomly
    if (millis() - lastSpawnTime > spawnInterval) {
      if (random(1) < 0.5) {
        spawnCircle();
      } else {
        spawnSlider();
      }
      lastSpawnTime = millis();
    }

    // Update and display circles
    for (int i = circles.size() - 1; i >= 0; i--) {
      Circle c = circles.get(i);
      c.update();
      c.display();
      if (c.isMissed()) {
        // Go to the Game Over screen
        currentScreen = "gameover"; 
      }
    }

    // Update and display sliders
    for (int i = sliders.size() - 1; i >= 0; i--) {
      Slider s = sliders.get(i);
      s.display();
      if (s.isMissed()) {
        // Go to Game Over screen
        currentScreen = "gameover"; 
      }
    }

    // Display score
    fill(255);
    textAlign(LEFT, TOP);
    textSize(30);
    text("Score: " + score, 10, 10);

// Game Over Screen display
  } else if (currentScreen.equals("gameover")) { 
    fill(255);
    textAlign(CENTER, CENTER);
    textSize(32);
    text("Game Over", 300, 100);
    playAgainButton.display();
    mainMenuButton.display();
    // Settings Screen display
  } else if (currentScreen.equals("settings")) { 
    fill(255);
    textAlign(CENTER, CENTER);
    textSize(32);
    text("There are no settings dum dum", width / 2, height / 2);
    // Credits Screen
  } else if (currentScreen.equals("credits")) { 
    fill(255);
    textAlign(CENTER, CENTER);
    textSize(32);
    text("Made by Christopher Bader... No one else", width / 2, height / 2);
  }
}

void mousePressed() {
  // Mouse pressed functions for the menu screen only
  if (currentScreen.equals("menu")) { 
    if (playButton.isHovered()) {
      currentScreen = "play";
      initializeGame();
    } else if (settingsButton.isHovered()) {
      currentScreen = "settings";
    } else if (creditsButton.isHovered()) {
      currentScreen = "credits";
    }
    // Mouse pressed functions for the game
  } else if (currentScreen.equals("play")) { // Play Screen
    for (int i = circles.size() - 1; i >= 0; i--) {
      Circle c = circles.get(i);
      if (c.isClicked(mouseX, mouseY)) {
        circles.remove(i);
        // Increase score when the circle is clicked
        score += 100; 
        break;
      }
    }

    for (int i = sliders.size() - 1; i >= 0; i--) {
      Slider s = sliders.get(i);
      if (s.isStartClicked(mouseX, mouseY)) {
        // Start tracking the slider progress
        s.activate(); 
      }
    }
    // Game Over Screen if lost
  } else if (currentScreen.equals("gameover")) { 
    if (playAgainButton.isHovered()) {
      currentScreen = "play";
      initializeGame();
    } else if (mainMenuButton.isHovered()) {
      currentScreen = "menu";
    }
  }
}

void mouseDragged() {
  // Check to see if any sliders are active
  for (Slider s : sliders) {
    if (s.isActive()) {
      s.track(mouseX, mouseY);
    }
  }
}

void mouseReleased() {
  // Finish the active sliders when mouse drags fully
  for (int i = sliders.size() - 1; i >= 0; i--) {
    Slider s = sliders.get(i);
    if (s.isActive()) {
      // If the slider is completed...
      if (s.isCompleted()) {
        sliders.remove(i);
        // Increase score when slider is finished
        score += 150; 
      } else {
        // Stop tracking if not completed
        s.deactivate(); 
      }
    }
  }
}
//Main code to initialize the game
void initializeGame() {
  // Reset the score, clear all circles and sliders.
  score = 0;
  circles.clear();
  sliders.clear();
  //This is to track the spawn time of every circle and slider
  lastSpawnTime = millis(); 
}
//this function will randomly spawn each circle
void spawnCircle() {
  float x = random(100, width - 100);
  float y = random(100, height - 100);
  circles.add(new Circle(new PVector(x, y)));
}
//This function randomly spawns in the sliders
void spawnSlider() {
  float x = random(100, width - 100);
  float y = random(100, height - 100);

  // Randomly decide if the slider is vertical or horizontal
  boolean isVertical = random(1) < 0.5;
 // Vertical Slider
  if (isVertical) {
    sliders.add(new Slider(new PVector(x, y), 200, true));
  } else {
    // Horizontal Slider
    sliders.add(new Slider(new PVector(x, y), 200, false)); 
  }
}
