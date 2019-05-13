class Level4 extends Level {

  ArrayList<Box> boxes = new ArrayList<Box>(); //arraylist for boksene i banen

  int boxfrequency; //til styring af hvor ofte boksene falder


  Level4() {
    currentlevel = 4;
    spawnlocation = new PVector(30, 630); //hvor spilleren spawner
    p = new Player(spawnlocation.x, spawnlocation.y); //initialisere spillerklassen

    // teksten til spørgsmålene, samt til der hvor svaret skrives til de forskellige klassetrin dannes i switchen.
    switch(klassetrin) {
    case 1:
      question1 = mq.lvl4tal[0] + " + " + mq.lvl4tal[1] + " + " + mq.lvl4tal[2];
      question2 = mq.lvl4tal[3] + " + " + mq.lvl4tal[4] + " - " + mq.lvl4tal[5];
      break;
    case 5:
      question1 = mq.lvl4tal[0] + " - " + mq.lvl4tal[1];
      question2 = mq.lvl4tal[2] + " * " + mq.lvl4tal[3];
      break;
    case 9:
      question1 = mq.lvl4tal[0] + " + " + mq.lvl4tal[1];
      question2 = mq.lvl4tal[2] + " * " + mq.lvl4tal[3];
      break;
    }
    writeguess1 = "= ";
    writeguess2 = "= ";

    lines(); // linjerne til banen
    mq.questions(currentlevel);
  }

  void run() {
    backgroundimage();

    //tegner banen samt elevator funktionalitet
    stage();
    boxdrop(); //funktionalitet for boksene
    elevator();
    finishline(1180, 95); 

    //de blå bokse samt mat spørgsmål.
    blueBox(270, 520, 170, 100);
    mathQuestion(360, 430, 1);
    blueBox(2, 220, 98, 70);
    mathQuestion(150, 130, 2);

    //hvor spørgsmålene kan svares på
    if (p.location.x > 200 && p.location.x < 440) canType[0] = true;
    else canType[0] = false;
    if (p.location.x < 200 && p.location.y < 300) canType[1] = true;
    else canType[1] = false;

    //styring og bevægelse af spilleren
    playermovement();
    if (!pause) p.update();
    collision();
    p.display();

    respawn();

    pauseGame();
    if (pause) inGameMenu();

    //klaring af banen
    if (p.location.x > width) levelisComplete = true;
    if (levelisComplete)levelComplete();
  }


  void boxdrop() {
    for (int i = boxes.size()-1; i >= 0; i--) {
      Box b = boxes.get(i);
      b.boxesRun(); //bevægelse + teging af bokse

      //collision with player and boxes
      if (PVector.dist(p.location, b.location) <  p.radius + 15  && b.lifespan > 35) {
        dead = true; //spilleren dør ved kollision
      }

      if (b.location.y + 20 >= 620) b.speed.y = 0; //boksen stopper når den rammer gulvet

      if (b.lifespan <= 0) boxes.remove(i); //boksene fjernes efter noget tid.
    }

    int boxadd = 5; //hvor ofte boksene skal spawnes, ændres når man har klaret spørgsmålet for at gøre det letter,
    if (mq.guesscheck[0] != 1) boxadd = 5;
    if (mq.guesscheck[0] == 1) boxadd = 30;

    if (boxfrequency == boxadd) { //tilføjer en boks, når boxfrequency når boxadd, og restarter tælleren
      boxes.add(new Box(random(450, 800), 420));
      boxfrequency = 0;
    }

    boxfrequency ++; // tæller boxfq op
  }
  //elevator funktionalitet
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
  // danner alle linjerne til banen, hvori start og slutpunktet af linjen skrives, samt hvilken type linje for banen det er.
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
