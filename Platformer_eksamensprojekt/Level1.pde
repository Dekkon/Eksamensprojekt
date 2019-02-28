class Level1 extends Level {

  MathQuestions mq;
  boolean gothekey = false;
  boolean gateopen = false;
  int klassetrin = 9;
  int numberofwrongguesses;


  Level1() {
    spawnlocation = new PVector(30, 600);
    mq = new MathQuestions();
    p = new Player(spawnlocation.x, spawnlocation.y, radius);
    mq.keylocation = new PVector(40, 80);


    floor1s = new PVector(0, 600); //floor 1 starting point
    floor1e = new PVector(300, 600); // floor 1 ending point

    floor2s = new PVector(300, 500);
    floor2e = new PVector(600, 500);

    floor3s = new PVector(0, 400);
    floor3e = new PVector(150, 400);

    floor4s = new PVector(600, 550);
    floor4e = new PVector(750, 550);

    floor5s = new PVector(200, 440);
    floor5e = new PVector(230, 440);

    floor6s = new PVector(750, 500);
    floor6e = new PVector(850, 500);

    tline1s = new PVector(850, 500);
    tline1e = new PVector(1280, 622.856);
    tangle1 = 0.2857;

    roof1s = new PVector(0, 430); // roof 1 starting point
    roof1e = new PVector(150, 430); // roof 1 ending point

    // roof2s = new PVector(150, 200);
    // roof2e = new PVector(600, 200);

    rwall1s = new PVector(300, 600); // right wall 1 starting point
    rwall1e = new PVector(300, 500); // right wall 1 ending point

    rwall2s = new PVector(600, 350);
    rwall2e = new PVector(600, 300);

    rwall3s = new PVector(1279, 520);
    rwall3e = new PVector(1279, 0);

    gate1s = new PVector(600, 500);
    gate1e = new PVector(600, 350);

    lwall1s = new PVector(0, height); // left wall 1 starting point
    lwall1e = new PVector(0, 0);      // left wall 1 ending point

    lwall2s = new PVector(150, 430);
    lwall2e = new PVector(150, 400);
  }


  void run() { 
    p.update();
    collision();
    mq.display();

    if (p.location.x > 0 && p.location.x < 150 && p.location.y < 400) {
      mq.typeanswer();
    }
    level1specific();
    mq.level1Question(klassetrin);

    collectkey();
    gates();

    stage();
    respawn();
    playermovement();

    p.display();
    
    if (level == 2)levelComplete();
  }

  void level1specific() {
    if (p.location.x > width) level = 2;

    fill(0, 0, 255);
    stroke(0, 0, 255);
    rectMode(CORNER);
    rect(30, 20, 140, 50);

    textSize(20);
    textAlign(CENTER);
    fill(255);
    if (klassetrin == 1) text(mq.kl1tal1 + " + " + mq.kl1tal2, 100, 50);
    if (klassetrin == 5) text(mq.kl5tal1 + " * " + mq.kl5tal2, 100, 50);
    if (klassetrin == 9) text(mq.kl9tal1 + "(x + " + mq.kl9tal2 + ") = " + mq.kl9tal3, 100, 50);

    if (mq.guesscheck == 1) fill(0, 255, 0);
    if (klassetrin == 1 || klassetrin == 5) text("= " +mq.guess, 100, 95);
    if (klassetrin == 9) text("x = " +mq.guess, 100, 95);


    mq.redbox--;
    if (mq.guesscheck == 2) {
      numberofwrongguesses ++;
      mq.testguess = -234;
      mq.guesscheck = 0;

      mq.redbox = 30;
    }
    if (mq.redbox > 0) {
      fill(255, 0, 0);
      noStroke();
      rectMode(CENTER);
      rect(100, 90, 60, 20);
    }
  }

  void collectkey() {


    if (mq.guesscheck == 1 && !gothekey) {
      if (mq.keylocation.y + radius < p.location.y) {
        mq.keylocation.y += 2;
      }
      if (mq.keylocation.y + radius > p.location.y) gothekey = true;
    }
    // println(gothekey);

    if (gothekey && !gateopen) {
      mq.keylocation.y = p.location.y - radius;
      mq.keylocation.x = p.location.x + radius;
    }
  }

  void gates() {

    // draw the gate
    stroke(0, 0, 255);
    line(gate1s.x, gate1s.y, gate1e.x, gate1e.y);

    // unit colission with gate
    if (p.location.x > gate1s.x-radius && p.location.x < gate1s.x-radius+30 && p.location.y > gate1e.y && p.location.y < gate1s.y) p.location.x = gate1s.x - radius;

    // key to gate
    if (mq.keylocation.x > gate1s.x - 50 && mq.keylocation.x <= gate1s.x && mq.keylocation.y > gate1e.y && mq.keylocation.y < gate1s.y) gateopen = true;
    if (gateopen && gate1s.y > gate1e.y && mq.keytogate) {
      gate1s.y -= 2;
    }
    if (gateopen) {
      mq.seekKeyhole(gate1e);
    }
  }

  void levelComplete() {
    background(0, 255, 0);
    
    textSize(50);
    textAlign(CENTER, CENTER);
    fill(25);
    
    text("Level 1 Complete", width/2, height/2);
    
    textSize(35);
    text("Press space to continue", width/2, height/2+50);
    
  }
}
