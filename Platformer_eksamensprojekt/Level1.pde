class Level1 extends Level {
  boolean gotthekey = false; // boolean får om spilleren har nøglen,
  boolean gateopen = false; // boolean til om porten skal åbnes

  boolean startedmoving = false; // om spilleren er begyndt at bevæge sig
  boolean startedtyping = false; // om spilleren er begyndt at skrive et svar
  int moveguideremoval = 90; // antal frames til at 'move guiden' skal fjernes
  int questionguideremoval = 90; // antal frames til at 'question guiden' skal fjernes

  PImage keyhole; // billede til nøglehullet
  PImage moveguide; // billede til 'move guide'
  PImage questionguide; // billede til 'quesiton guide'

  Level1() {
    currentlevel = 1; // sætter det nuværende level til 1
    spawnlocation = new PVector(30, 600); // hvor spilleren spawner

    p = new Player(spawnlocation.x, spawnlocation.y); // sætter spiller klassen i spawnlocationen
    mq.keylocation = new PVector(40, 80); // nøglens lokation

    keyhole = loadImage("keyhole.png");
    keyhole.resize(10, 30);
    moveguide = loadImage("moveguide.png");
    moveguide.resize(413, 220);
    questionguide = loadImage("questionguide.png");
    questionguide.resize(368, 49);
    
    // teksten til spørgsmålene, samt til der hvor svaret skrives til de forskellige klassetrin dannes i switchen.
    switch(klassetrin) {
    case 1:
      question1 = mq.lvl1tal[0] + " + " + mq.lvl1tal[1];
      writeguess1 = "= ";
      break;
    case 5:
      question1 = mq.lvl1tal[0] + " * " + mq.lvl1tal[1];
      writeguess1 = "= ";
      break;
    case 9:
      question1 = mq.lvl1tal[0] + "(x + " + mq.lvl1tal[1] + ") = " + mq.lvl1tal[2];
      writeguess1 = "x = ";
      break;
    }
    lines(); // funktionen hvor linjerne i arraylisten er dannet
  }


  void run() { 
    backgroundimage(); //bagrundsbilledet

    stage(); // hvor banen tegnes
    gates(); // portens funktionalitet
    finishline(1180, 463); // hvor 'finishline' billedet tegnes
    guide(); // guides vises

    mq.displayKey(); //viser nøglen
    collectkey(); // styrer bevægelse af nøglen fra nøglens startlokation til spiller 
    if (p.location.x > 0 && p.location.x < 150 && p.location.y < 400) canType[0] = true; // så man kan svarer på spørgsmålet når man er inden for den blå boks.
    else canType[0] = false; // så man ikke kan svarer hvis man ikke er det
    mathQuestion(100, 45, 1); // funktion for visning af spørgsmålet, hvor der indsættes lokatin, samt at det er spørgsmål 1.
    blueBox(2, 280, 148, 120); // tegning af blå boks, hvor der indsættes størrelse af boksen, samt dens lokation.
    mq.questions(currentlevel); // funktion over spørgsmålene, for det nuværende levet er variabel, for at programmet ved hvad svaret er.

    playermovement(); // styring af spiller movement
    if (!pause) p.update(); // selve movement af spiller, kan ikke kører når spillet er pauset
    collision(); // collision mellem spiller og banen
    p.display(); // visning af spiller

    respawn(); // respawn når man dør

    pauseGame(); // funktion hvorfra spillet pauses
    if (pause) inGameMenu(); // viser in game menu hvis spillet er paust

    if (p.location.x > width) levelisComplete = true; // er man nået forbi højre hjørne klarer man banen.
    if (levelisComplete)levelComplete(); // er banen klaret vises lecelComplete skærmen.
  }
  
  void collectkey() {   
    //svares spørgsmålet rigtigt på, og er nøglen ikke kommet hen til porten
    if (mq.guesscheck[0] == 1 && !gotthekey) {      
      mq.keySeekLocation(p.location); //nøglen flyver mod spilleren
      if (PVector.dist(p.location, mq.keylocation) < 15) gotthekey = true; // når nøglen når spilleren, gøres gotthekey sand, så nøglen kan sætte sig fast på spilleren.
    }
    
    //gør så nøglen sidder fast på spilleren
    if (gotthekey && !gateopen) {
      mq.keylocation.y = p.location.y - p.radius;
      mq.keylocation.x = p.location.x + p.radius;
    }
  }
  // styrer funktionen af porten
  void gates() {
    
    for (Line l : lines) {
      if (l.wallType == "gate") {
        imageMode(CENTER);
        tint(0, 0, 255);
        image(keyhole, l.x2, l.y2); //tegner nøglehullet

         
        if (mq.keylocation.x > l.x1 - 50 && mq.keylocation.x <= l.x1 && mq.keylocation.y > l.y2 && mq.keylocation.y < l.y1) gateopen = true; //når nøglen er tæt nok på porten, sættes gatopen sand
        //når den variabel er sand, så begynder nøglen at flyve mod nøglehullet
        if (gateopen) {
          PVector keyholelocation = new PVector(l.x2, l.y2);
          mq.keySeekLocation(keyholelocation);
        }
        // når nøglen er nået nøglehullet åbnes porten.
        if (gateopen && l.y1 > l.y2 && mq.keytogate) {
          l.y1 -= 2;
        }
        
      }
    }
  }
  //viser de to guides
  void guide() {
    // er guidefjerne variablen over 0, så kører dette, 
    if (moveguideremoval > 0) {
      image(moveguide, 400, 40); //viser guide billedet       
      if (keys[0] || keys[1] || keys[2] && moveguideremoval < 0) startedmoving = true; //hvis man begynder at bevæge sig, sættes startedmoving til sand     
      if (startedmoving) moveguideremoval --; //er denen sand, tælles guidefjerne variabblen ned, hvilket gør at guiden fjernes når variablen når til 0.
    }
    
    // -||-
    if (questionguideremoval > 0) {
      image(questionguide, 40, 100);
      if (mq.userGuess1s.length() > 0) startedtyping = true;
      if (startedtyping) questionguideremoval --;
    }
  }
  // danner alle linjerne til banen, hvori start og slutpunktet af linjen skrives, samt hvilken type linje for banen det er.
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
