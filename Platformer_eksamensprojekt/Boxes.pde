class Box {
  
  PVector location;
  PVector speed;
  
  color boxc = color(0, 0, 255);
  
  float angle;
  float angles = 0.05;
  
  
  int lifespan = 255;
  
  Box(float x, float y) {
    location = new PVector(x, y);
    speed = new PVector(0, 3);
  }
  
  void boxesrun() {
    update();
    display();
    
    lifespan -= 2.5;
  }
  
  void update() {
    
    location.add(speed);
    
    angle += angles;
  }
  
  void display() {
    rectMode(CENTER);
    
    pushMatrix();
    translate(location.x, location.y);
    stroke(0, lifespan);
    fill(boxc, lifespan);
    rotate(angle);
    rect(0, 0, 40, 40);
    popMatrix();
    
    
  }
  
  
  
}
