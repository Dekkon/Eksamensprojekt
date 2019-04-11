class Player {

  PVector location;
  PVector speed;
  PVector acceleration;

  float radius;

  float angle = 0;
  float anglespeed = 0;


  Player(float x, float y, float r) {
    location = new PVector(x, y);
    speed = new PVector(0, 0);
    acceleration = new PVector(0, 0.7);

    radius = r;
  }

  void display() {

    pushMatrix();
    translate(location.x, location.y);

    noStroke();
    fill(255, 114, 0);
    rotate(angle);
    ellipse(0, 0, radius*2, radius*2);
    stroke(255);
    strokeWeight(2);
    line(0, 0, 0, radius);

    popMatrix();

    //location.y = height/2;
  }

  void update() {

    location.add(speed);
    speed.add(acceleration);

    anglespeed = speed.x/radius; 
    angle += anglespeed;

    speed.x = 0;
  }

}
