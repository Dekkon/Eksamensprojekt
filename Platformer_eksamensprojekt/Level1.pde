class Level1 extends Level {


  boolean gotthekey = false;
  boolean gateopen = false;
  int numberofwrongguesses;

  boolean startedmoving = false;
  int moveguideremoval = 90;

  boolean startedtyping = false;
  int questionguideremoval = 90;

  PImage keyhole;
  PImage moveguide;
  PImage questionguide;


  Level1() {
    currentlevel = 1;
    spawnlocation = new PVector(30, 600);

    p = new Player(spawnlocation.x, spawnlocation.y, radius);
    mq.keylocation = new PVector(40, 80);

    keyhole = loadImage("keyhole.png");
    keyhole.resize(10, 30);
    moveguide = loadImage("moveguide.png");
    moveguide.resize(413, 220);
    questionguide = loadImage("questionguide.png");
    questionguide.resize(368, 49);
    
    
    switch(klassetrin) {
    case 1:
      question1 = mq.kl1lvl1tal[0] + " + " + mq.kl1lvl1tal[1];
      writeguess1 = "= ";
      break;
    case 5:
      question1 = mq.kl5lvl1tal[0] + " * " + mq.kl5lvl1tal[1];
      writeguess1 = "= ";
      break;
    case 9:
      question1 = mq.kl9lvl1tal[0] + "(x + " + mq.kl9lvl1tal[1] + ") = " + mq.kl9lvl1tal[2];
      writeguess1 = "x = ";
      break;
    }

    lines();
  }


  void run() { 
    backgroundimage();

    stage();
    gates();
    finishline(1180, 463);
    guide();
    


    mq.display();
    collectkey();    
    if (p.location.x > 0 && p.location.x < 150 && p.location.y < 400) canType[0] = true;
    else canType[0] = false;
    mathQuestion(100, 45, 1);
    blueBox(2, 280, 148, 120);
    mq.questions(klassetrin, currentlevel);

    playermovement();
    if (!pause) p.update();
    collision();
    p.display();

    respawn();

    pauseGame();
    if (pause) inGameMenu();

    if (p.location.x > width) levelisComplete = true;
    if (levelisComplete)levelComplete();
  }
  


  void collectkey() {


    if (mq.guesscheck[0] == 1 && !gotthekey) {      
      mq.seekKeyhole(p.location);

      if (PVector.dist(p.location, mq.keylocation) < 15) gotthekey = true;
    }


    if (gotthekey && !gateopen) {
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

  void guide() {
    if (moveguideremoval > 0) {
      image(moveguide, 400, 40);        
      if (keys[0] || keys[1] || keys[2] && moveguideremoval < 0) startedmoving = true;      
      if (startedmoving) moveguideremoval --;
    }

    if (questionguideremoval > 0) {
      image(questionguide, 40, 100);
      if (mq.guess1.length() > 0) startedtyping = true;
      if (startedtyping) questionguideremoval --;
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
