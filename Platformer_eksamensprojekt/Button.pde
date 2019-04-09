class Button {

  PVector location;
  PVector size;
  String buttontext;

  Button(float x, float y, float wx, float wy, String bt) {
    location = new PVector(x, y);
    size = new PVector(wx, wy);
    buttontext = bt;
  }

  void drawbutton(color buttonc) {
    rectMode(CENTER);
    textAlign(CENTER, CENTER);

    fill(buttonc);
    rect(location.x, location.y, size.x, size.y);
    fill(255);
    text(buttontext, location.x, location.y-5);
  }

  boolean overbutton() {

    if (mouseX > location.x - size.x/2 && mouseX < location.x + size.x/2 && mouseY > location.y - size.y/2 && mouseY < location.y + size.y/2) {
      return true;
    } else {
      return false;
    }
  }
}
