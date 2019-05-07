class Level2 extends Level {

  Level2() {
    currentlevel = 2; // sætter det nuværende level til 2
    spawnlocation = new PVector(30, 600); // hvor spilleren spawner
    p = new Player(spawnlocation.x, spawnlocation.y); // initialisere spiller klassen.
    
    // teksten til spørgsmålene, samt til der hvor svaret skrives til de forskellige klassetrin dannes i switchen.
    switch(klassetrin) {
    case 1:
      question1 = mq.lvl1tal[0] + " - " + mq.lvl1tal[1];
      question2 = mq.lvl1tal[2] + " + " + mq.lvl1tal[3];
      writeguess1 = "= ";
      break;
    case 5:
      question1 = mq.lvl2tal[0] + " + " + mq.lvl2tal[1];
      question2 = mq.lvl2tal[2] + " + " + mq.lvl2tal[3] + " * " + mq.lvl2tal[4];
      writeguess1 = "= ";
      break;
    case 9:
      question1 = mq.lvl2tal[0] + "x - (" + mq.lvl2tal[1] + "x + " + mq.lvl2tal[2] + ") = " + mq.lvl2tal[3];
      question2 = "√" + mq.lvl2tal[4] + " + √" + mq.lvl2tal[5];
      writeguess1 = "x = ";
      break;
    }    
    writeguess2 = "= ";

    lines();
  }

  void run() {
    backgroundimage(); //bagrundsbilledet


    
    stage();  // hvor banen tegnes
    elevator(); // bevægelse af eleavtore
    movingFloors(); // bevægelse af bevægende gulve
    finishline(1180, 125); // hvor 'finishline' billedet vises

    mathQuestion(1190, 390, 1); // visning af spørgsmål 1
    blueBox(1102, 520, 176, 110); // blå boks til spørgsmål 1
    mathQuestion(72, 230, 2); // visning af spørgsmål 2
    blueBox(2, 340, 196, 110); // blå boks til spørsgmål 2
    if (p.location.x > 1100) canType[0] = true; // hvor man kan svarer på sprg 1.
    else canType[0] = false; 
    if (p.location.x < 200 && p.location.y < 550) canType[1] = true; // hvor man kan svare på sprg 2.
    else canType[1] = false;
    mq.questions(currentlevel); // spørgsmålene til det nuværende level.
    
    //bevægelse, styring og visning af spiller samt kollision mellem spiller og bane.
    playermovement();
    if (!pause) p.update();
    collision();
    p.display();

    respawn(); // respawn når man dør
    
    //styring af pausning af spillet
    pauseGame();
    if (pause) inGameMenu();
    
    // når man klarer banen.
    if (p.location.x > width) levelisComplete = true;
    if (levelisComplete)levelComplete();
  } 
  
  // styrer bevægelse af bevægene gulve
  void movingFloors() {

    for (Line l : lines) {
      if (l.wallType == "movingfloor") { // så koden kun virke for bevægene gulve
        
        //identificere de specifikke gulve og får den til at skifte retning frem og tilbage
        
        if (l.x1 > 250 && l.x1 < 390) {  
          if (l.x1 < 260 && l.mfspeed < 0) l.mfspeed *= -1;
          if (l.x1 > 380 && l.mfspeed > 0) l.mfspeed *= -1;
        }
        if (l.x1 > 550 && l.x1 < 690) {
          if (l.x1 < 560 && l.mfspeed < 0) l.mfspeed *= -1;
          if (l.x1 > 680 && l.mfspeed > 0) l.mfspeed *= -1;
        }
        //bevæger gulvene
        l.x1 += l.mfspeed;
        l.x2 += l.mfspeed;
      }
    }
  }


  void elevator() {

    for (Line l : lines) {
      if (l.wallType == "elevator") { // identificere elevatorne
        
        //finder de to elevator, og får dem til at bevæge sig frem og tilbage,
        
        if (l.x1 == 1100) {
          if (l.y1 > 630 && l.elespeed > 0) l.elespeed *= -1;
          if (l.y1 < 450 && l.elespeed < 0) l.elespeed *= -1;

          if (mq.guesscheck[0] == 1) { // så den kun bevæger sig, hvis det første spørgsmål er svaret rigtigt på.
            l.y1 += l.elespeed;
            l.y2 += l.elespeed;
          }
        }
        if (l.x1 == 0) {
          if (l.y1 > 450 && l.elespeed > 0) l.elespeed *= -1;
          if (l.y1 < 270 && l.elespeed < 0) l.elespeed *= -1;

          if (mq.guesscheck[1] == 1) { // så den kun bevæger sig hvis det andet sprg, er svaret rigtigt på
            l.y1 += l.elespeed;
            l.y2 += l.elespeed;
          }
        }
      }
    }
  }
  // danner alle linjerne til banen, hvori start og slutpunktet af linjen skrives, samt hvilken type linje for banen det er.
  void lines() {
    //floors
    lines.add(new Line(0, 630, 200, 630, "floor"));
    lines.add(new Line(900, 630, 1100, 630, "floor"));
    lines.add(new Line(900, 450, 1100, 450, "floor"));
    lines.add(new Line(600, 450, 800, 450, "floor"));
    lines.add(new Line(300, 450, 500, 450, "floor"));
    lines.add(new Line(200, 450, 250, 450, "floor"));
    lines.add(new Line(200, 270, width, 270, "floor"));

    //walls to the left of the player
    lines.add(new Line(0, height, 0, 0, "leftwall"));
    lines.add(new Line(1100, 560, 1100, 450, "leftwall"));
    lines.add(new Line(200, 380, 200, 270, "leftwall"));

    //walls to the right of the player
    lines.add(new Line(1100, 560, 1100, 450, "rightwall"));
    lines.add(new Line(width-1, height, width-1, 270, "rightwall"));
    lines.add(new Line(200, 380, 200, 270, "rightwall"));
    lines.add(new Line(width-1, 180, width-1, 0, "rightwall"));

    //moving floors
    lines.add(new Line(380, 600, 480, 600, "movingfloor"));
    lines.add(new Line(560, 600, 660, 600, "movingfloor"));

    //elevators
    lines.add(new Line(1100, 630, width, 630, "elevator"));
    lines.add(new Line(0, 450, 200, 450, "elevator"));
  }
}
