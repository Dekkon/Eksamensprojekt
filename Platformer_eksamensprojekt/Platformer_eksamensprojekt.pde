
Game g;
int levelsCompleted = 0;
int klassetrin = 9;



boolean keys[] = new boolean [4];

void setup() {

  size(1280, 720);

  g = new Level1();
  
 
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

  // kan ikke bruge enter i keyTyped(), så kører enter key her.
  if (g.canType[0] && keyCode == ENTER) g.typeanswer(1);
  if (g.canType[1] && keyCode == ENTER) g.typeanswer(2);
}

void keyReleased() {
  if (key == 'a' || key == 'A' || keyCode == LEFT)  keys[0] = false;
  if (key == 'd' || key == 'D' || keyCode == RIGHT)  keys[1] = false;
  if (key == 'w' || key == 'W' || keyCode == UP || key == ' ')  keys[2] = false;

  if (keyCode == 8) keys[3] = false;
}

void keyTyped() {

  if (g.canType[0]) g.typeanswer(1); 
  if (g.canType[1]) g.typeanswer(2);
}

void mousePressed() {
  
}

  
