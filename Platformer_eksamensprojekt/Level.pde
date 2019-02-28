class Level extends Game {
  Player p;
  PVector spawnlocation;
  
  //int level = 0;

  PVector floor1s = new PVector(0, 0); //floor 1 starting point
  PVector floor1e = new PVector(0, 0); // floor 1 ending point

  PVector floor2s = new PVector(0, 0);
  PVector floor2e = new PVector(0, 0);

  PVector floor3s = new PVector(0, 0);
  PVector floor3e = new PVector(0, 0);

  PVector floor4s = new PVector(0, 0);
  PVector floor4e = new PVector(0, 0);

  PVector floor5s = new PVector(0, 0);
  PVector floor5e = new PVector(0, 0);

  PVector floor6s = new PVector(0, 0);
  PVector floor6e = new PVector(0, 0);
  
  PVector tline1s = new PVector(0, 0);
  PVector tline1e = new PVector(0, 0);
  float tangle1;

  PVector roof1s = new PVector(0, 0); // roof 1 starting point
  PVector roof1e = new PVector(0, 0); // roof 1 ending point

  PVector roof2s = new PVector(0, 0);
  PVector roof2e = new PVector(0, 0);

  PVector rwall1s = new PVector(0, 0); // right wall 1 starting point
  PVector rwall1e = new PVector(0, 0); // right wall 1 ending point

  PVector rwall2s = new PVector(0, 0);
  PVector rwall2e = new PVector(0, 0);
  
  PVector rwall3s = new PVector(0, 0);
  PVector rwall3e = new PVector(0, 0);
  
  PVector gate1s = new PVector(0, 0);
  PVector gate1e = new PVector(0, 0);

  PVector lwall1s = new PVector(0, 0); // left wall 1 starting point
  PVector lwall1e = new PVector(0, 0);      // left wall 1 ending point

  PVector lwall2s = new PVector(0, 0);
  PVector lwall2e = new PVector(0, 0);

  float radius = 17.5;

  boolean onPlatform = false; //boolean to check whether or not player is currently on a platform

  Level() {
  }

  void stage() {
    stroke(0, 240, 0);
    strokeWeight(2);

    // floors
    line(floor1s.x, floor1s.y, floor1e.x, floor1e.y);
    line(floor2s.x, floor2s.y, floor2e.x, floor2e.y);
    line(floor3s.x, floor3s.y, floor3e.x, floor3e.y);
    line(floor4s.x, floor4s.y, floor4e.x, floor4e.y);
    line(floor5s.x, floor5s.y, floor5e.x, floor5e.y);
    line(floor6s.x, floor6s.y, floor6e.x, floor6e.y);

    line(tline1s.x, tline1s.y, tline1e.x, tline1e.y);
    
    //roofs 
    line(roof1s.x, roof1s.y, roof1e.x, roof1e.y);
    line(roof2s.x, roof2s.y, roof2e.x, roof2e.y);

    //walls to the right of the player
    line(rwall1s.x, rwall1s.y, rwall1e.x, rwall1e.y);
    line(rwall2s.x, rwall2s.y, rwall2e.x, rwall2e.y);
    line(rwall3s.x, rwall3s.y, rwall3e.x, rwall3e.y);

    //waslls to the left of the player
    line(lwall1s.x, lwall1s.y, lwall1e.x, lwall1e.y);
    line(lwall2s.x, lwall2s.y, lwall2e.x, lwall2e.y);
  }
  


  void collision() {

    // collision with floors -- makes it so you don't fall through floors
    if (p.location.x > floor1s.x && p.location.x < floor1e.x && p.location.y >= floor1s.y-radius && p.location.y <= floor1s.y-radius+30 && p.speed.y > 0) { 
      p.location.y = floor1s.y-radius;
      onPlatform = true;
    }
    if (p.location.x > floor2s.x - radius+1 && p.location.x < floor2e.x + radius && p.location.y >= floor2s.y-radius && p.location.y <= floor2s.y-radius+30 && p.speed.y > 0) {
      p.location.y = floor2s.y-radius;
      onPlatform = true;
    }
    if (p.location.x > floor3s.x  - radius+1 && p.location.x < floor3e.x + radius-1 && p.location.y >= floor3s.y-radius && p.location.y <= floor3s.y-radius+30 && p.speed.y > 0) {
      p.location.y = floor3s.y-radius;
      onPlatform = true;
    }
    if (p.location.x > floor4s.x  - radius+1 && p.location.x < floor4e.x + radius-1 && p.location.y >= floor4s.y-radius && p.location.y <= floor4s.y-radius+30 && p.speed.y > 0) {
      p.location.y = floor4s.y-radius;
      onPlatform = true;
    }
    if (p.location.x > floor5s.x  - radius+1 && p.location.x < floor5e.x + radius-1 && p.location.y >= floor5s.y-radius && p.location.y <= floor5s.y-radius+30 && p.speed.y > 0) {
      p.location.y = floor5s.y-radius;
      onPlatform = true;
    }
    if (p.location.x > floor6s.x  - radius+1 && p.location.x < floor6e.x + radius-1 && p.location.y >= floor6s.y-radius && p.location.y <= floor6s.y-radius+30 && p.speed.y > 0) {
      p.location.y = floor6s.y-radius;
      onPlatform = true;
    }
    
   // tilted lines
   if (p.location.x > tline1s.x  - radius+1 && p.location.x < tline1e.x + radius-1 && p.location.y >= 500 - radius + (p.location.x-tline1s.x) * tangle1 && p.location.y <= 15 + 500 - radius + (p.location.x-tline1s.x) * tangle1) {
     p.location.y = 500 - radius + (p.location.x-tline1s.x) * tangle1;
     onPlatform = true;
     p.speed.x +=1;
   }
    
    
    if (onPlatform) p.speed.y = 0;

    // collision with roofs -- makes it so you can't jump through roofs

    if (p.location.x > roof1s.x - radius+1 && p.location.x < roof1e.x + radius-1 && p.location.y < roof1s.y + radius && p.location.y > roof1s.y + radius - 20 && p.speed.y < 0) {
      p.location.y = roof1s.y + radius; 
      p.speed.y = 0;
    }
    if (p.location.x > roof2s.x - radius+1 && p.location.x < roof2e.x + radius-1 && p.location.y < roof2s.y + radius && p.location.y > roof2s.y + radius - 20 && p.speed.y < 0) {
      p.location.y = roof2s.y + radius; 
      p.speed.y = 0;
    }

    // collision with walls -- makes so you can't run through walls.

    // walls to the right of the player
    if (p.location.x > rwall1s.x-radius && p.location.x < rwall1s.x-radius+30 && p.location.y > rwall1e.y && p.location.y < rwall1s.y) p.location.x = rwall1s.x - radius;
    if (p.location.x > rwall2s.x-radius && p.location.x < rwall2s.x-radius+30 && p.location.y > rwall2e.y && p.location.y < rwall2s.y) p.location.x = rwall2s.x - radius;
    if (p.location.x > rwall3s.x-radius && p.location.x < rwall3s.x-radius+30 && p.location.y > rwall3e.y && p.location.y < rwall3s.y) p.location.x = rwall3s.x - radius;


    // walls to the left of the player
    if (p.location.x < lwall1s.x + radius && p.location.x > lwall1s.x + radius - 30 && p.location.y > lwall1e.y && p.location.y < lwall1s.y) p.location.x = lwall1s.x + radius;
    if (p.location.x < lwall2s.x + radius && p.location.x > lwall2s.x + radius - 30 && p.location.y > lwall2e.y && p.location.y < lwall2s.y) p.location.x = lwall2s.x + radius;
  }

  void playermovement() {

    // key presses
    if (keyPressed) {
      if (keys[0]) p.speed.x -= 4;
    }
    if (keyPressed) {
      if (keys[1]) p.speed.x += 4;
    }
    if (keyPressed) { //can only jump while on a platform
      if (keys[2] && onPlatform) {   
        p.speed.y = -12;
      }
    }

    onPlatform = false;
  }


  void respawn() {

    if (p.location.y > height) {
      p.location.x = spawnlocation.x;
      p.location.y = spawnlocation.y;
      p.speed.y = 0;
    }
  }
}
