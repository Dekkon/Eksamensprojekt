class Level extends Game {
  Player p; // spiller klassen, 
  MathQuestions mq; // matematikspørgsmål klassen
  ArrayList<Line> lines = new ArrayList<Line>(); // arraylist for linje klassen, af linjerne som udgør banen

  PVector spawnlocation; // hvor spilleren spawner

  PImage pausebutton; //pauseknappen billede
  PImage startbutton; //startknappens billede
  PImage finishline;  //finishline billede

  PImage baggrundsbillede; // bagrundsbillede

  int currentlevel; // det nuværende level

  boolean levelisComplete = false; //om levet er færdiggjort
  boolean pause = false; // om spillet er pauset
  boolean dead = false; // om spilleren er død

  String question1; // teksten i sprg 1.
  String question2; // teksten i sprg 2.

  String writeguess1; // tekst til svar til sprg 1
  String writeguess2; // tekst til svar til sprg 2

  boolean onPlatform = false; //boolean to check whether or not player is currently on a platform

  Button[] b = new Button[3]; // knap klassen i et array med 3, da der er 3 knapper i levels.


  Level() {
    mq = new MathQuestions();
    pausebutton = loadImage("pauseButton.png");
    startbutton = loadImage("startButton.png");
    finishline = loadImage("finishicon.png");
    finishline.resize(100, 55);

    baggrundsbillede = loadImage("backgroundimage.png");
    baggrundsbillede.resize(width, height);

    // de tre knapper, med deres lokation, størrelse, og tekst på knappen.
    b[0] = new Button(width/2, 245, 200, 70, "resume");
    b[1] = new Button(width/2, 365, 200, 70, "settings");
    b[2] = new Button(width/2, 485, 200, 70, "exit");
  }
  // funktion for bagrundsbilledet
  void backgroundimage() {
    imageMode(CORNER);
    image(baggrundsbillede, 0, 0);
  }
  
  // funktion hvor linjerne på banen bliver tegnet.
  void stage() {
    
    strokeWeight(3);
    //for loop for linje klassen, hvori linjerne som udgør banen tegnes.
    for (Line l : lines) {
      stroke(0, 255, 0); // gør linjerne grønne
      
      //gør nogle specifikker linjerne blå i nogle af banerne, da de har noget at gøre med spørgsmålene. 
      if (currentlevel == 1 && l.wallType == "gate") stroke(0, 0, 255);
      if (currentlevel == 2 && l.wallType == "elevator") stroke(0, 0, 255);
      if (currentlevel == 3 && l.wallType == "movingfloor") stroke(0, 0, 255);
      if (l.wallType == "activatefloor") {
        if (mq.guesscheck[1] != 1) stroke(0, 0, 255, 50);
        if (mq.guesscheck[1] == 1) stroke(0, 0, 255);
      }
      line(l.x1, l.y1, l.x2, l.y2); //tegner linjerne
    }
  }
  
  // funktion hvor collision mellem linjerne og spilleren styres.
  void collision() {

    for (Line l : lines) {
      // collision with floors
      if (l.wallType == "floor" || l.wallType == "elevator" || l.wallType == "movingfloor" || l.wallType == "activatefloor" && mq.guesscheck[1] == 1) {
        if (p.location.x > l.x1 - p.radius+1 && p.location.x < l.x2 + p.radius && p.location.y >= l.y1 -p.radius && p.location.y <= l.y1 -p.radius+30 && p.speed.y > 0) {
          p.location.y = l.y1-p.radius;
          onPlatform = true; // gør 'onPlatform' boolean sand når spilleren er på en platform.
          if (l.wallType == "movingfloor") p.location.x += l.mfspeed; // gør så hvis man er på en platform der bevæger sig at man følger med den.
        }
      }
      // collision with roofs
      if (l.wallType == "roof" && p.location.x > l.x1 - p.radius+1 && p.location.x < l.x2 + p.radius-1 && p.location.y < l.y1 + p.radius && p.location.y > l.y1 + p.radius - 20 && p.speed.y < 0) {
        p.location.y = l.y1 + p.radius; 
        p.speed.y = 0; // sætter hastigheden til 0, så man ikke fortsat bevæger sig opad mod loftet, og det ligner at man hænger fast i det.
      }
      // collision with walls to the left of the player
      if (l.wallType == "leftwall" && p.location.x < l.x1 + p.radius && p.location.x > l.x1 + p.radius - 30 && p.location.y > l.y2 && p.location.y < l.y1) p.location.x = l.x1 + p.radius;
      // collision with walls to the right of the player
      if (l.wallType == "rightwall" || l.wallType == "gate") { 
        if (p.location.x > l.x2-p.radius && p.location.x < l.x1-p.radius+30 && p.location.y > l.y2 && p.location.y < l.y1) p.location.x = l.x1 - p.radius;
      }
      // collision with tilted lines
      if (l.wallType == "tline" && p.location.x > l.x1  - p.radius+1 && p.location.x < l.x2 + p.radius-1 && p.location.y >= 500 - p.radius + (p.location.x-l.x1) * l.angle && p.location.y <= 15 + 500 - p.radius + (p.location.x-l.x1) * l.angle) {
        p.location.y = 500 - p.radius + (p.location.x-l.x1) * l.angle;
        onPlatform = true;
        p.speed.x +=1;
      }
    }

    if (onPlatform) p.speed.y = 0; // sætter hastigheden til 0, hvis spilleren er på en platform, da ellers gør den nedadpegende acceleration hastigheden alt for høj og man kan falde gennem platformene.
  }

  // styrer bevægelse af spiller -- lavet i Level klassen, for at bedre kunne bruge onPlatform variablen som forhindrer dobbelt jump.
  void playermovement() {
    // key presses
    if (keyPressed) {
      if (keys[0]) p.speed.x -= 4;
    }
    if (keyPressed) {
      if (keys[1]) p.speed.x += 4;
    }
    if (keyPressed) { 
      // gør så man kun kan hoppe når man er på en platform.
      if (keys[2] && onPlatform) {   
        p.speed.y = -12;
      }
    }
    onPlatform = false; // sætter variablen til falsk, så spilleren ikke kan hoppe igen næste loop, medmindre den er på en platform.
  }
  
  //funktion hvori de blå bokse som man svarer spørgsmål indenfor tegnes.
  void blueBox(int x, int y, int wx, int wy) { // variabler styrer hvor boks skal tegnes og størrelse af boks
    rectMode(CORNER);  
    noStroke();
    fill(0, 0, 255, 120);
    rect(x, y, wx, wy);
  }
  
  //tegner boks til matematiksprøgsmålene samt der hvor sprg skrives, og hvor man kan skrive svar.
  void mathQuestion(int x1, int y1, int questnr) { // variabler styrer hvor det skal være på skærmen, samt hvilket sprg det er, så programmet ved hvilken spørgsmål tekst skal skrives.
    rectMode(CENTER);
    fill(0, 0, 255);
    stroke(0, 0, 255);
    rect(x1, y1, 155, 50);

    textSize(17);
    textAlign(CENTER);
    fill(255);

    if (questnr == 1) text(question1, x1, y1+5); // hvis det sprg 1, så skrives tekst til det
    if (questnr == 2) text(question2, x1, y1+5); // hvis det sprg 2. så skrives tekst til det

    if (mq.guesscheck[questnr-1] == 1) fill(0, 255, 0);

    if (questnr == 1) text(writeguess1 + mq.guess1, x1, y1+45);
    if (questnr == 2) text(writeguess2 + mq.guess2, x1, y1+45);

    mq.wronganswerbox(x1, y1+43, questnr-1);
  }
  
  // funktion hvor man kan skrive spørgsmål, funktion lavet her så den kan trækkes ud til eventsne 'keyTyped' og 'keyReleased'.
  void typeanswer(int wq) { // variabel styrer hvilket spørgsmål der skrives svar til.
    mq.typeanswer(wq);
  }

  // funktion over hvad der sker når man klarer en bane.
  void levelComplete() {
    background(0, 255, 0);

    textSize(50);
    textAlign(CENTER, CENTER);
    fill(25);

    text("Level " + currentlevel + " Complete", width/2, height/2);

    textSize(35);
    text("Press space to continue", width/2, height/2+50);

    if (key == ' ') level = currentlevel + 1; // gør så man kan skifte til næste bane.
    
    // hvis man når længere end man er nået før. så gemmes det i en csv fil, så spillet husker dette, så man kan starte fra den bane næste gang man åbner spillet.
    if (currentlevel > levelsCompleted) {
      levelsCompleted = currentlevel;
      newRow.setInt("levelsCompleted", levelsCompleted);
      saveTable(levelsCompletedtable, "data/levelsCompleted.csv");
    }

    newDataRow.setInt("id", 0);
    
    
    //switch, hvori der gemmes hvor mange gange man har svaret forkert på de forskellige spørgsmål for de forskellige baner.
    switch(currentlevel) {
    case 1:
      newDataRow.setInt("question1", mq.numberofwrongguesses[0]);
      break;
    case 2:
      newDataRow.setInt("question2", mq.numberofwrongguesses[0]);
      newDataRow.setInt("question3", mq.numberofwrongguesses[1]);
      break;
    case 3:
      newDataRow.setInt("question4", mq.numberofwrongguesses[0]);
      newDataRow.setInt("question5", mq.numberofwrongguesses[1]);
      break;
    case 4:
      newDataRow.setInt("question6", mq.numberofwrongguesses[0]);
      newDataRow.setInt("question7", mq.numberofwrongguesses[1]);
      break;
    }
    saveTable(answerData, "data/answerData.csv"); // gemmer dataen i en csv fil.
  }
  
  // funktion som styrer respawning af spilleren.
  void respawn() {
    if (dead) { // hvis boolean om man er død er sand, så respawner man i spawnlocation.
      p.location.x = spawnlocation.x;
      p.location.y = spawnlocation.y;
      p.speed.y = 0;
      dead = false; // den sættes falsk så man ikke bliver ved med at spawne.
    }
    
    // gør så man dør hvis man falder ned ud af banen.
    if (p.location.y > height) {
      dead = true;
    }
  }
  //funktion som gør spillet kan pauses
  void pauseGame() {
    mouselistener();
    
    // hvis man klikker på 'p', så pauses spillet
    if (keyPressed && key == 'p' || key == 'P') pause = true;
    
    //hvis man holder over pauseknappen så lyser den op
    if (mouseX < 1220 + 24 && mouseX > 1220 - 24 && mouseY < 70 + 39 && mouseY > 70 - 39) {
      ellipse(1220, 70, 35, 35);
    }
    // hvis man klikker på pauseknappen, så pauser/unpauser spillet.
    if (mousePressed && mouseX < 1220 + 24 && mouseX > 1220 - 24 && mouseY < 70 + 39 && mouseY > 70 - 39 && mousecheck == 1) {
      pause = !pause;
    }

    imageMode(CENTER);
    //tegner pause/start- knappen hvis spillet er pauset/i gang
    if (!pause) image(pausebutton, 1220, 70);
    if (pause) image(startbutton, 1220, 70);
  }
  
  // pause menu
  void inGameMenu() {
    textSize(40);
    noStroke();

    rectMode(CENTER);
    fill(0, 230);
    noStroke();
    rect(width/2, height/2, 300, 380);

    // for loop for knapperne
    for (int i = 0; i < b.length; i++) {

      if (b[i].mouseOverButton()) {
        buttoncolor = color(150, 150); // knappernes farve hvis musen er over dem
        if (mousePressed && mousecheck == 1) { // klik på knapperne
          if (i == 0) pause = false; // resume knappen, gør at spillet fortsætter hvis den klikkes på
          if (i == 1);
          if (i == 2) menu = 1; // menu knappen for en tlbage til menuen. hvis den klikkes på
        }
      } else {
        buttoncolor = color(150, 200); // farven hvis musen ikke er over den
      }
      b[i].drawbutton(buttoncolor); // tegner knapperne
    }
  }
  
  // funktion for billede, af finish som hviser hvor banen slutter.
  void finishline(int x, int y) {
    imageMode(CORNER);
    noTint();
    image(finishline, x, y);
  }
}
