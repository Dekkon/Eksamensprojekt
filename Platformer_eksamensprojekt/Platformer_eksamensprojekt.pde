
Game g;
int levelsCompleted;
int klassetrin = 5;


boolean keys[] = new boolean [4];

void setup() {

  size(1280, 720);

  g = new Level2();
}


void draw() {
  background(25);

  println("X: " + mouseX + " Y: " + mouseY); 
  if (g.level == 1) g = new Level1();
  if (g.level == 2) g = new Level2();

  if (g.menu == 1) g = new MainMenu();
  if (g.menu == 2) g = new LevelSelect();

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
