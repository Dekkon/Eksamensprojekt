class Player {

  PVector location; 
  PVector speed; 
  PVector acceleration; // accelerationen, som bruges som tyngdekraft

  static final float radius = 17.5;

  float angle;
  float anglespeed;

  //constructor hvor der er variabler til dens lokation.
  Player(float x, float y) {
    location = new PVector(x, y);
    speed = new PVector(0, 0);
    acceleration = new PVector(0, 0.7); //accelerationen sættes til dette

  }
  //tegner spilleren
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
  }
  //styrer den bevægelse der sker af spilleren
  void update() {

    location.add(speed); //flytter spilleren i dens hastighed
    speed.add(acceleration); //tyngdekraften
    
    //roterer spilleren som den bevæger sig
    anglespeed = speed.x/radius; 
    angle += anglespeed;

    speed.x = 0; //sætter hastigheden i x-retningen til 0, i slutningen af hvert loop, så den stopper når man slipper piletasterne
  }

}
