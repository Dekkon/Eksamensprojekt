class Box {
  
  PVector location; // boxes location
  PVector speed; // hastigheden
  
  float angle; // vinklen
  
  int lifespan = 255; // til hvor lang tid boksen lever
  
  //constructor til Box, hvor variablerne er til boxenes location.
  Box(float x, float y) {
    location = new PVector(x, y);
    speed = new PVector(0, 3);
  }
  
  // run funktion for boxene
  void boxesRun() {
    update();
    display();
    
    lifespan -= 2.5; // reducere lifespan, som bruges til transparency for boksene, og til at fjerne dem når lifespan når 0.
  } 
  // til movement af boks, både i form af rotation og fald.
  void update() {
    location.add(speed);
    angle += 0.05;
  }  
  // tegner boksene
  void display() {
    rectMode(CENTER);
    
    pushMatrix();
    translate(location.x, location.y);
    stroke(0, lifespan);
    fill(255, 0, 0, lifespan);
    rotate(angle);
    rect(0, 0, 40, 40);
    popMatrix();
       
  } 
}
