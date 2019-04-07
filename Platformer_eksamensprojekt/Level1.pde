class Level1 extends Level {

  
  boolean gothekey = false;
  boolean gateopen = false;
  int numberofwrongguesses;

  PImage keyhole;


  Level1() {
    currentlevel = 1;
    spawnlocation = new PVector(30, 600);
    
    p = new Player(spawnlocation.x, spawnlocation.y, radius);
    mq.keylocation = new PVector(40, 80);

    keyhole = loadImage("keyhole.png");
    keyhole.resize(10, 30);

    lines();
  }


  void run() { 
    
    collision();
    stage();
    gates();
    
    mq.display();
    collectkey();    
    if (p.location.x > 0 && p.location.x < 150 && p.location.y < 400) mq.typeanswer(1);
    mathQuestion();
    mq.level1Question(klassetrin);
        
    playermovement();
    p.update();
    p.display();
    
    respawn();
    
    pauseGame();
    if (pause) inGameMenu();

    if (p.location.x > width) levelisComplete = true;
    if (levelisComplete)levelComplete();
  }


  void mathQuestion() {



    fill(0, 0, 255);
    stroke(0, 0, 255);
    rectMode(CORNER);
    rect(30, 20, 140, 50);

    textSize(20);
    textAlign(CENTER);
    fill(255);
    if (klassetrin == 1) text(mq.kl1lvl1tal[0] + " + " + mq.kl1lvl1tal[1], 100, 50);
    if (klassetrin == 5) text(mq.kl5lvl1tal[0] + " * " + mq.kl5lvl1tal[1], 100, 50);
    if (klassetrin == 9) text(mq.kl9lvl1tal[0] + "(x + " + mq.kl9lvl1tal[1] + ") = " + mq.kl9lvl1tal[2], 100, 50);

    if (mq.guesscheck[0] == 1) fill(0, 255, 0);
    if (klassetrin == 1 || klassetrin == 5) text("= " +mq.guess1, 100, 95);
    if (klassetrin == 9) text("x = " +mq.guess1, 100, 95);


    mq.redbox--;
    if (mq.guesscheck[0] == 2) {
      numberofwrongguesses ++;
      mq.testguess[0] = -234;
      mq.guesscheck[0] = 0;

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


    if (mq.guesscheck[0] == 1 && !gothekey) {
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

    for (Line l : lines) {
      if (l.wallType == "gate") {
        imageMode(CENTER);
        tint(0, 0, 255);
        image(keyhole, l.x2, l.y2);

        // key to gate
        if (mq.keylocation.x > l.x1 - 50 && mq.keylocation.x <= l.x1 && mq.keylocation.y > l.y2 && mq.keylocation.y < l.y1) gateopen = true;
        if (gateopen && l.y1 > l.y2 && mq.keytogate) {
          l.y1 -= 2;
        }
        if (gateopen) {
          PVector keyholelocation = new PVector(l.x2, l.y2);
          mq.seekKeyhole(keyholelocation);
        }
      }
    }
  }
  void lines() {

    //floors
    lines.add(new Line(0, 600, 300, 600, "floor"));
    lines.add(new Line(300, 500, 600, 500, "floor"));
    lines.add(new Line(0, 400, 150, 400, "floor"));
    lines.add(new Line(600, 550, 750, 550, "floor"));
    lines.add(new Line(200, 440, 230, 440, "floor"));
    lines.add(new Line(750, 500, 850, 500, "floor"));

    //roofs 
    lines.add(new Line(0, 430, 150, 430, "roof"));

    //walls to the left of the player
    lines.add(new Line(0, height, 0, 0, "leftwall"));
    lines.add(new Line(150, 430, 150, 400, "leftwall"));

    //walls to the right for the player
    lines.add(new Line(300, 600, 300, 500, "rightwall"));
    lines.add(new Line(600, 350, 600, 300, "rightwall"));
    lines.add(new Line(1279, 520, 1279, 0, "rightwall"));

    // tilted line
    lines.add(new Line(850, 500, 1280, 623, "tline"));

    // gate
    lines.add(new Line(600, 500, 600, 350, "gate"));
  }
}
