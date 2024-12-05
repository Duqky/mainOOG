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

  boolean isHovered() {
    return mouseX > x && mouseX < x + w && mouseY > y && mouseY < y + h;
  }
}
