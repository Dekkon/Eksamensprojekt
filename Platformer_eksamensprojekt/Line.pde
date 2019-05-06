class Line {
  float x1;
  float y1;
  float x2;
  float y2;

  float angle;

  int mfspeed = 2;
  int elespeed = 1;

  String wallType;

  Line(float x1, float y1, float x2, float y2, String wt) {
    this.x1 = x1;
    this.y1 = y1;
    this.x2 = x2;
    this.y2 = y2;

    wallType = wt;

    // try statement so game doesn't crash by dividing by zero
    try {
     angle = (y2-y1)/(x2-x1) ;
    } 
    catch (Exception e) { 
    }
  }
}
