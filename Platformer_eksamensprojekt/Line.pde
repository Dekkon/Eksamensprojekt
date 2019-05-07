class Line {
  //linjernes start og slutposition.
  float x1;
  float y1;
  float x2;
  float y2;

  float angle; //vinklen linjen er i

  int mfspeed = 2; //hastighed af 'movingfloors'
  int elespeed = 1; //hasighed af 'elevatorer'

  String wallType; //hvilken type linje det er for banen.
  
  //constructor hvor koordinater og walltype skrives.
  Line(float x1, float y1, float x2, float y2, String wt) { 
    this.x1 = x1;
    this.y1 = y1;
    this.x2 = x2;
    this.y2 = y2;

    wallType = wt;

    // try statement så spillet ikke ender med at crashe ved at dividere med 0.
    try {
     angle = (y2-y1)/(x2-x1) ; // regner vinklen
    } 
    catch (Exception e) { 
    }
  }
}
