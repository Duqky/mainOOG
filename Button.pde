class Button {
  float x, y, w, h;
  String label;

  Button(float px, float py, float pw, float ph, String lbl) {
    x = px;
    y = py;
    w = pw;
    h = ph;
    label = lbl;
  }
//displaying the buttons along with changing the fill if the button is hovered
//to show the player that the button is selected
  void display() {
    if (isHovered()) {
      fill(200);
    } else {
      fill(100);
    }
    rect(x, y, w, h, 10);

    fill(0);
    textAlign(CENTER, CENTER);
    textSize(16);
    text(label, x + w / 2, y + h / 2);
  }
//detecting if the button is hovered on or not
  boolean isHovered() {
    return mouseX > x && mouseX < x + w && mouseY > y && mouseY < y + h;
  }
}
