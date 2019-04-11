class Level4 extends Level {

  ArrayList<Box> boxes = new ArrayList<Box>();

  int boxfrequency;


  Level4() {
    currentlevel = 4;
    spawnlocation = new PVector(30, 630);
    p = new Player(spawnlocation.x, spawnlocation.y, radius);

    switch(klassetrin) {
    case 1:
      question1 = mq.kl1lvl4tal[0] + " + " + mq.kl1lvl4tal[1] + " + " + mq.kl1lvl4tal[2];
      question2 = mq.kl1lvl4tal[3] + " + " + mq.kl1lvl4tal[4] + " - " + mq.kl1lvl4tal[5];
      break;
    case 5:
      question1 = mq.kl5lvl4tal[0] + " - " + mq.kl5lvl4tal[1];
      question2 = mq.kl5lvl4tal[2] + " * " + mq.kl5lvl4tal[3];
      break;
    case 9:
      question1 = mq.kl9lvl4tal[0] + " + " + mq.kl9lvl4tal[1];
      question2 = mq.kl9lvl4tal[2] + " * " + mq.kl9lvl4tal[3];
      break;
    }
    writeguess1 = "= ";
    writeguess2 = "= ";

    lines();
  }

  void run() {
    backgroundimage();

    stage();
    boxdrop();
    elevator();
    finishline(1180, 95); 

    blueBox(270, 520, 170, 100);
    mathQuestion(360, 430, 1);
    blueBox(2, 220, 98, 70);
    mathQuestion(150, 130, 2);

    if (p.location.x > 200 && p.location.x < 440) canType[0] = true;
    else canType[0] = false;
    if (p.location.x < 200 && p.location.y < 300) canType[1] = true;
    else canType[1] = false;
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


  void boxdrop() {
    for (int i = boxes.size()-1; i >= 0; i--) {
      Box b = boxes.get(i);
      b.boxesrun();

      //collision with player and boxes
      if (PVector.dist(p.location, b.location) <  radius + 15) {
        dead = true;
      }

      if (b.location.y + 20 >= 620) b.speed.y = 0;

      if (b.lifespan <= 0) boxes.remove(i);
    }

    int boxadd = 5;
    if (mq.guesscheck[0] != 1) boxadd = 5;
    if (mq.guesscheck[0] == 1) boxadd = 30;

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

    //roofs
    lines.add(new Line(0, 1, width, 1, "roof"));


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
    lines.add(new Line(width-2, 140, width-2, 0, "rightwall"));
    lines.add(new Line(width-2, height, width-2, 220, "rightwall"));

    // elevatores
    lines.add(new Line(1050, 620, width, 620, "elevator"));
  }
}
