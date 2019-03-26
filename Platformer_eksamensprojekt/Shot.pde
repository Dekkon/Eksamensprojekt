class Shot {
  
  PVector location;
  PVector speed;
  
  int lifespan = 98;
  
  Shot(float x, float y) {
    location = new PVector(x, y);
    speed = new PVector(-5, 0);
  }
  
  void display() {
    
    stroke(255, 255, 0);
    strokeWeight(5);
    line(location.x+12, location.y, location.x-12, location.y);
    
    lifespan --;
  }
  
  void movement() {
    
    location.add(speed);
    
  }
  
}
