class Level2 extends Level {
  MathQuestions mq;

  Level2() {
    spawnlocation = new PVector(30, 600);
    mq = new MathQuestions();
    p = new Player(spawnlocation.x, spawnlocation.y, radius);

    floor1s = new PVector(0, 630); //floor 1 starting point
    floor1e = new PVector(200, 630); // floor 1 ending point

    floor2s = new PVector(0, 0);
    floor2e = new PVector(0, 0);

    floor3s = new PVector(0, 0);
    floor3e = new PVector(0, 0);

    floor4s = new PVector(0, 0);
    floor4e = new PVector(0, 0);

    floor5s = new PVector(0, 0);
    floor5e = new PVector(0, 0);

    floor6s = new PVector(0, 0);
    floor6e = new PVector(0, 0);

    tline1s = new PVector(0, 0);
    tline1e = new PVector(0, 0);
    tangle1 = 0.2857;

    roof1s = new PVector(0, 0); // roof 1 starting point
    roof1e = new PVector(0, 0); // roof 1 ending point

    rwall1s = new PVector(0, 0); // right wall 1 starting point
    rwall1e = new PVector(0, 0); // right wall 1 ending point

    rwall2s = new PVector(0, 0);
    rwall2e = new PVector(0, 0);

    rwall3s = new PVector(0, 0);
    rwall3e = new PVector(0, 0);

    gate1s = new PVector(0, 0);
    gate1e = new PVector(0, 0);

    lwall1s = new PVector(0, 0); // left wall 1 starting point
    lwall1e = new PVector(0, 0);      // left wall 1 ending point

    lwall2s = new PVector(0, 0);
    lwall2e = new PVector(0, 0);
  }

  void run() {

    p.update();
    collision();
    stage();
    respawn();
    playermovement();

    p.display();
  }
}
