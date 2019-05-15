class Level3 extends Level {

  ArrayList<Shot> shots = new ArrayList<Shot>(); // arrayliste for skudene i banen.
  PImage stickman, spikes; // billede af stickman enemyen. og et billede af spikes
  int shotfq; // int-værdi til brug af hvor ofte der skal skydes.

  Level3() { 
    currentlevel = 3; // sætter det nuværende level til 2
    spawnlocation = new PVector(30, 120); // hvor spilleren spawner
    p = new Player(spawnlocation.x, spawnlocation.y); // initialisere spiller klassen.

    //loader billeder
    stickman = loadImage("Stickman.png");
    stickman.resize(50, 50);
    spikes = loadImage("spikes.png");
    spikes.resize(100, 40);   

    // teksten til spørgsmålene, samt til der hvor svaret skrives til de forskellige klassetrin dannes i switchen.
    switch(klassetrin) {
    case 1:
      question1 = mq.lvl3tal[0] + " * " + mq.lvl3tal[1];
      question2 = mq.lvl3tal[2] + " + " + mq.lvl3tal[3];
      writeguess1 = "= ";
      writeguess2 = "= ";
      break;
    case 5:
      question1 = mq.lvl3tal[0] + " * x = " + mq.lvl3tal[1];
      question2 = mq.lvl3tal[2] + "x = " + mq.lvl3tal[3];
      writeguess1 = "x = ";
      writeguess2 = "x = ";
      break;
    case 9:
      question1 = mq.lvl3tal[0] + "(x + " + mq.lvl3tal[1] + ") = " + mq.lvl3tal[2] + "(" + mq.lvl3tal[3] + " + x)";
      question2 = "√" + mq.lvl3tal[4] + " - √" + mq.lvl3tal[5];
      writeguess1 = "x = ";
      writeguess2 = "= ";
      break;
    }

    lines(); // linjerne til banen
    mq.questions(currentlevel); // spørgsmålene til det nuværende level.
  }

  void run() {
    backgroundimage();

    stage(); // banen tegnes
    elevator(); // elevator funktionalitet
    movingFloors(); //bevægene gulve funktionalitet
    enemy(); //tegning af enemy, samt skud
    pit(); //pit med spikes, man kan falde ned i
    finishline(1180, 545); // finishline billede

    blueBox(50, 40, 150, 100); // blå boks til sprg 1
    mathQuestion(170, 30, 1); // visning af sprg 1
    blueBox(800, 250, 150, 100); // blå boks til sprg 2
    mathQuestion(860, 190, 2); // visning af sprg 2

    //steder hvor man kan svarer på spørgsmålene
    if (p.location.x < 200) canType[0] = true;
    else canType[0] = false;
    if (p.location.x > 800 && p.location.x < 1050 && p.location.y > 200 && p.location.y < 400) canType[1] = true;
    else canType[1] = false;

    //bevægelse, styring og visning af spiller samt kollision mellem spiller og bane.
    playermovement();
    if (!pause) p.update();
    collision();
    p.display();

    respawn(); // respawn når spilleren dør

    //pausning af spillet
    pauseGame();
    if (pause) inGameMenu();

    //når man klarer banen.
    if (p.location.x > width) levelisComplete = true;
    if (levelisComplete)levelComplete();
  }

  //modstanderen som skyder mod spilleren
  void enemy() {
    shotfq ++; //tæller shotfrequency op en per frame
    int nuoshots = 15;
    //ændrer nuoshots, baseret på om man har svaret på spørgsmålet eller ej, for at gøre det lettere at passere når man har svaret rigtigt.
    if (mq.guesscheck[0] != 1) nuoshots = 15;
    if (mq.guesscheck[0] == 1) nuoshots = 55;

    if (shotfq == nuoshots) { // hver gang shotfq, når værdien nuoshots, tilføjes et Shot objekt.
      shots.add(new Shot(700, 155));
      shotfq = 0;
    }
    imageMode(CENTER);
    image(stickman, 720, 170); // viser stickman billedet

    //koden for skudene
    for (int i = shots.size()-1; i >= 0; i--) {
      Shot s = shots.get(i);
      s.display(); //viser skudene
      s.movement(); // bevægelse af dem
      if (PVector.dist(p.location, s.location) < p.radius+2) { //kollision mellem spiller og skud
        dead = true; //er der kollison dør spilleren
      }
      if (s.lifespan <= 0) shots.remove(i); //fjerne skudene
    }
  }

  void pit() {
    // makes the player die if the player falls into the pit
    if (p.location.x > 250 && p.location.x < 800 && p.location.y > 480 && p.location.y < 520) dead = true;

    //draw spikes
    imageMode(CORNER);
    noTint();
    for (int i = 0; i < 7; i++) {
      image(spikes, 250 + i * 75, 460);
    }
  }
  //elevatorens funktionalitet
  void elevator() {

    for (Line l : lines) {
      if (l.wallType == "elevator") {
        if (l.y1 > 350 && l.elespeed > 0) l.elespeed *= -1;
        if (l.y1 < 140 && l.elespeed < 0) l.elespeed *= -1;

        l.y1 += l.elespeed;
        l.y2 += l.elespeed;
      }
    }
  }
  //funktionalitet for det bevægende gulv
  void movingFloors() {

    for (Line l : lines) {
      if (l.wallType == "movingfloor") {


        if (l.x1 < 240 && l.mfspeed < 0) l.mfspeed *= -1;
        if (l.x1 > 550 && l.mfspeed > 0) l.mfspeed *= -1;

        if (mq.guesscheck[1] == 1) {
          l.x1 += l.mfspeed;
          l.x2 += l.mfspeed;
        }
      }
    }
  }
  // danner alle linjerne til banen, hvori start og slutpunktet af linjen skrives, samt hvilken type linje for banen det er.
  void lines() {
    //floors
    lines.add(new Line(0, 140, 200, 140, "floor"));
    lines.add(new Line(200, 190, 750, 190, "floor"));
    lines.add(new Line(750, 140, 1050, 140, "floor"));
    lines.add(new Line(800, 350, width, 350, "floor"));
    lines.add(new Line(250, 500, 800, 500, "floor"));
    lines.add(new Line(80, 420, 230, 420, "floor"));
    lines.add(new Line(0, 540, 130, 540, "floor"));
    lines.add(new Line(220, 660, width, 660, "floor"));

    //roofs
    lines.add(new Line(80, 420, 230, 420, "roof"));

    // walls to the left of the player
    lines.add(new Line(0, height, 0, 0, "leftwall"));
    lines.add(new Line(200, 190, 200, 140, "leftwall"));
    lines.add(new Line(250, 500, 250, 350, "leftwall"));

    // walls to the right of the player
    lines.add(new Line(750, 190, 750, 140, "rightwall"));
    lines.add(new Line(width-1, 600, width-1, 0, "rightwall"));
    lines.add(new Line(800, 500, 800, 350, "rightwall"));
    lines.add(new Line(250, 500, 250, 350, "rightwall"));

    // moving floors
    lines.add(new Line(280, 330, 480, 330, "movingfloor"));

    // elevatores
    lines.add(new Line(1050, 140, width, 140, "elevator"));
  }
}
