class Button {

  PVector location; // knappens location
  PVector size; // dens størelse
  String buttontext; // teksten som står på knappen
  
  // constructor til knappen, hvori variablerne er til dens location, størrelse og teksten på knappen.
  Button(float x, float y, float wx, float wy, String bt) {
    location = new PVector(x, y);
    size = new PVector(wx, wy);
    buttontext = bt;
  }
  
  // tegner knappen, med variabel til farven, da farven skal ændres når musen holdes over knappen.
  void drawbutton(color buttonc) {
    rectMode(CENTER);
    textAlign(CENTER, CENTER);

    fill(buttonc);
    rect(location.x, location.y, size.x, size.y);
    fill(255);
    text(buttontext, location.x, location.y-5);
  }
  
  // boolean funktion, som returnere sandt hvis musen holdes over en knap
  boolean mouseOverButton() {
    if (mouseX > location.x - size.x/2 && mouseX < location.x + size.x/2 && mouseY > location.y - size.y/2 && mouseY < location.y + size.y/2) {
      return true;
    } else {
      return false;
    }
  }
}
