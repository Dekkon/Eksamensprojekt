class Level4 extends Level {

  ArrayList<Box> boxes = new ArrayList<Box>();

  int boxfrequency;


  Level4() {
    currentlevel = 4;
    spawnlocation = new PVector(30, 630);
    p = new Player(spawnlocation.x, spawnlocation.y, radius);

    lines();
  }

  void run() {
    if (mousePressed) p.location = new PVector(mouseX, mouseY);
    stage();
    boxdrop();
    elevator();

    mathQuestion();
    if (p.location.x > 200 && p.location.x < 440) mq.typeanswer(1);
    if (p.location.x < 200 && p.location.y < 300) mq.typeanswer(2);
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

  void mathQuestion() {
    rectMode(CORNER);
    
    noStroke();
    fill(0, 0, 255, 120);
    rect(300, 520, 140, 100);    
    
    rect(2, 220, 98, 70);
    
    textSize(20);
    textAlign(CENTER);

    // question 1
    fill(0, 0, 255);
    stroke(0, 0, 255);
    rect(300, 400, 140, 50);

    fill(255);
    if (klassetrin == 1) text(mq.kl1lvl4tal[0] + " + " + mq.kl1lvl4tal[1] + " + " + mq.kl1lvl4tal[2], 370, 430);
    if (klassetrin == 5) text(mq.kl5lvl2tal[0] + " + " + mq.kl5lvl2tal[1], 370, 430);
    if (klassetrin == 9) text(mq.kl9lvl2tal[0] + "min, " + mq.kl9lvl2tal[1] + " sek.", 370, 430);

    if (mq.guesscheck[0] == 1) fill(0, 255, 0);
    if (klassetrin == 1 || klassetrin == 5) text("= " +mq.guess1, 370, 475);
    if (klassetrin == 9) text("= " + mq.guess1 + "  sek.", 370, 475);

    mq.redbox--;
    if (mq.guesscheck[0] == 2) {
      // numberofwrongguesses ++;
      mq.testguess[0] = -234;
      mq.guesscheck[0] = 0;

      mq.redbox = 30;
    }
    if (mq.redbox > 0) {
      fill(255, 0, 0);
      noStroke();
      rectMode(CENTER);
      rect(370, 472, 80, 30);
    }
    
    // question 2
    fill(0, 0, 255);
    stroke(0, 0, 255);
    rectMode(CORNER);
    rect(100, 190, 140, 50);

    fill(255);
    if (klassetrin == 1) text(mq.kl1lvl4tal[3] + " + " + mq.kl1lvl4tal[4] + " - " + mq.kl1lvl4tal[5], 170, 220);
    if (klassetrin == 5) text(mq.kl5lvl2tal[0] + " + " + mq.kl5lvl2tal[1], 170, 220);
    if (klassetrin == 9) text(mq.kl9lvl2tal[1] + "min, " + mq.kl9lvl2tal[1] + " sek.", 170, 220);

    if (mq.guesscheck[1] == 1) fill(0, 255, 0);
    if (klassetrin == 1 || klassetrin == 5) text("= " +mq.guess2, 170, 265);
    if (klassetrin == 9) text("= " + mq.guess2 + "  sek.", 170, 265);

    mq.redbox--;
    if (mq.guesscheck[1] == 2) {
      // numberofwrongguesses ++;
      mq.testguess[1] = -234;
      mq.guesscheck[1] = 0;

      mq.redbox = 30;
    }
    if (mq.redbox > 0) {
      fill(255, 0, 0);
      noStroke();
      rectMode(CENTER);
      rect(170, 262, 80, 30);
    }
    
    
  }


  void boxdrop() {
    for (int i = boxes.size()-1; i >= 0; i--) {
      Box b = boxes.get(i);
      b.boxesrun();


      if (PVector.dist(p.location, b.location) <  radius + 15) {
        dead = true;
      }

      if (b.location.y + 20 >= 620) b.speed.y = 0;


      if (b.lifespan <= 0) boxes.remove(i);
    }

    int boxadd = 5;
    if (mq.guesscheck[0] != 1) boxadd = 5;
    if (mq.guesscheck[0] == 1) boxadd = 25;

    if (boxfrequency == boxadd) {
      boxes.add(new Box(random(450, 800), 420));
      boxfrequency = 0;
    }

    boxfrequency ++;
  }
  void elevator() {

    for (Line l : lines) {
      if (l.wallType == "elevator") {
        if (l.y1 > 620 && l.elespeed > 0) l.elespeed *= -1;
        if (l.y1 < 400 && l.elespeed < 0) l.elespeed *= -1;

        l.y1 += l.elespeed;
        l.y2 += l.elespeed;
      }
    }
  }

  void lines() {
    //floors 
    lines.add(new Line(0, 620, 1050, 620, "floor"));
    lines.add(new Line(450, 400, 1050, 400, "floor"));
    lines.add(new Line(270, 330, 340, 330, "floor"));
    lines.add(new Line(90, 370, 150, 370, "floor"));
    lines.add(new Line(0, 290, 40, 290, "floor"));
    lines.add(new Line(100, 70, 350, 70, "floor"));
    lines.add(new Line(350, 120, 600, 120, "floor"));
    lines.add(new Line(600, 170, 850, 170, "floor"));
    lines.add(new Line(850, 220, width, 220, "floor"));
    
    
    //activateable floors
    lines.add(new Line(60, 210, 100, 210, "activatefloor"));
    lines.add(new Line(2, 100, 40, 100, "activatefloor"));

    //left walls
    lines.add(new Line(0, height, 0, 0, "leftwall"));
    lines.add(new Line(100, 220, 100, 70, "leftwall"));
    lines.add(new Line(350, 120, 350, 70, "leftwall"));
    lines.add(new Line(600, 170, 600, 120, "leftwall"));
    lines.add(new Line(850, 220, 850, 170, "leftwall"));
    
    // right walls
    lines.add(new Line(100, 220, 100, 70, "rightwall"));
    lines.add(new Line(width-1, 140, width-1, 0, "rightwall"));
    lines.add(new Line(width-1, height, width-1, 220, "rightwall"));

    // elevatores
    lines.add(new Line(1050, 620, width, 620, "elevator"));
  }
}
