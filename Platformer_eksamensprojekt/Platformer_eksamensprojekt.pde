
Game g;
int levelsCompleted = 0;
int klassetrin = 9;


boolean keys[] = new boolean [4];

void setup() {

  size(1280, 720);

  g = new Level2();
}


void draw() {
  background(25);


  switch(g.level) {
  case 1:
    g = new Level1();
    break;
  case 2:
    g = new Level2();
    break;
  case 3:
    g = new Level3();
    break;
  case 4:
    g = new Level4(); 
    break;
  }

  switch(g.menu) {
  case 1:
    g = new MainMenu();
    break;
  case 2:
    g = new LevelSelect();
    break;
  case 3:
    g = new Settings();
    break;
  }

  g.run();
}

void keyPressed() {
  if (key == 'a' || key == 'A' || keyCode == LEFT)  keys[0] = true;
  if (key == 'd' || key == 'D' || keyCode == RIGHT)  keys[1] = true;
  if (key == 'w' || key == 'W' || keyCode == UP || key == ' ')  keys[2] = true;

  if (keyCode == 8) keys[3] = true;
}

void keyReleased() {
  if (key == 'a' || key == 'A' || keyCode == LEFT)  keys[0] = false;
  if (key == 'd' || key == 'D' || keyCode == RIGHT)  keys[1] = false;
  if (key == 'w' || key == 'W' || keyCode == UP || key == ' ')  keys[2] = false;

  if (keyCode == 8) keys[3] = false;
}
