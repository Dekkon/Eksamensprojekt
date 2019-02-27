class Level1 extends Level {

  MathQuestions mq;
  boolean plz = false;

  Level1() {
    spawnlocation = new PVector(30, 600);
    mq = new MathQuestions();
    p = new Player(spawnlocation.x, spawnlocation.y, radius);

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
    tline1e = new PVector(1200, 600);
    tangle1 = 0.2857;

    roof1s = new PVector(0, 430); // roof 1 starting point
    roof1e = new PVector(150, 430); // roof 1 ending point

    // roof2s = new PVector(150, 200);
    // roof2e = new PVector(600, 200);

    rwall1s = new PVector(300, 600); // right wall 1 starting point
    rwall1e = new PVector(300, 500); // right wall 1 ending point

    rwall2s = new PVector(600, 350);
    rwall2e = new PVector(600, 300);

    lwall1s = new PVector(0, height); // left wall 1 starting point
    lwall1e = new PVector(0, 0);      // left wall 1 ending point

    lwall2s = new PVector(150, 430);
    lwall2e = new PVector(150, 400);
  }


  void run() { 

    p.update();
    collision();
    p.display();

    mq.display();
    if (p.location.x > 0 && p.location.x < 150 && p.location.y < 400) {
      mq.typeanswer();
      mq.question();
    }

    collectkey();


    stage();
    respawn();
    playermovement();
  }


  void collectkey() {


    if (mq.guesscheck == 1 && !plz) {
      if (mq.keylocation.y + radius < p.location.y) {
        mq.keylocation.y += 2;
      }
      if (mq.keylocation.y + radius > p.location.y) plz = true;
    }
    println(plz);

    if (plz) {
      mq.keylocation.y = p.location.y - radius;
      mq.keylocation.x = p.location.x + radius;
    }
  }
}
