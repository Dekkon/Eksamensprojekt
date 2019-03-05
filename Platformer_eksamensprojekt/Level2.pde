class Level2 extends Level {
  MathQuestions mq;

  Level2() {
    spawnlocation = new PVector(30, 600);
    mq = new MathQuestions();
    p = new Player(spawnlocation.x, spawnlocation.y, radius);

    floor1s = new PVector(0, 630); //floor 1 starting point
    floor1e = new PVector(200, 630); // floor 1 ending point

    floor2s = new PVector(900, 630);
    floor2e = new PVector(1100, 630);

    floor3s = new PVector(0, 0);
    floor3e = new PVector(0, 0);

    floor4s = new PVector(0, 0);
    floor4e = new PVector(0, 0);

    floor5s = new PVector(0, 0);
    floor5e = new PVector(0, 0);

    floor6s = new PVector(0, 0);
    floor6e = new PVector(0, 0);

    elevator1s = new PVector(1100, 630);
    elevator1e = new PVector(width, 630);
    el1speed = -1;


    mvfloor1s = new PVector(380, 600); // moving floor 1 starting point
    mvfloor1e = new PVector(480, 600); // moving floor 1 ending point
    mvf1speed = 2;                     // moving floor 1 speed

    mvfloor2s = new PVector(560, 600);
    mvfloor2e = new PVector(660, 600);
    mvf2speed = 2;


    tline1s = new PVector(0, 0);
    tline1e = new PVector(0, 0);
    tangle1 = 0.2857;

    roof1s = new PVector(0, 450); // roof 1 starting point
    roof1e = new PVector(1100, 450); // roof 1 ending point

    rwall1s = new PVector(1100, 560); // right wall 1 starting point
    rwall1e = new PVector(1100, 450); // right wall 1 ending point

    rwall2s = new PVector(0, 0);
    rwall2e = new PVector(0, 0);

    rwall3s = new PVector(0, 0);
    rwall3e = new PVector(0, 0);

    gate1s = new PVector(0, 0);
    gate1e = new PVector(0, 0);

    lwall1s = new PVector(0, height); // left wall 1 starting point
    lwall1e = new PVector(0, 0);      // left wall 1 ending point

    lwall2s = new PVector(1100, 560);
    lwall2e = new PVector(1100, 450);
  }

  void run() {



    movingFloors();

    p.update();
    stage();
    elevator();
    respawn();
    playermovement();
    collision();



    p.display();
  }

  void movingFloors() {
    if (mvfloor1s.x < 260 && mvf1speed < 0 ) {
      mvf1speed *= -1;
    } 
    if (mvfloor1s.x > 380 && mvf1speed > 0) {
      mvf1speed *= -1;
    } 

    if (mvfloor2s.x < 560 && mvf2speed < 0 ) {
      mvf2speed *= -1;
    } 
    if (mvfloor2s.x > 680 && mvf2speed > 0) {
      mvf2speed *= -1;
    }
  }

  void elevator() {
    // draw the elevator
    stroke(0, 0, 255);
    line(elevator1s.x, elevator1s.y, elevator1e.x, elevator1e.y);

    // unit collision with the elevator
    if (p.location.x > elevator1s.x  - radius+1 && p.location.x < elevator1e.x + radius-1 && p.location.y >= elevator1s.y-radius && p.location.y <= elevator1s.y-radius+30 && p.speed.y > 0) {
      p.location.y = elevator1s.y-radius;
      onPlatform = true;
      p.speed.y = 0;
    }

    // elevator movement
    if (elevator1s.y > 630 && el1speed > 0) el1speed *= -1;
    if (elevator1s.y < 450 && el1speed < 0) el1speed *= -1;

    elevator1s.y += el1speed;
    elevator1e.y += el1speed;
  }
}
