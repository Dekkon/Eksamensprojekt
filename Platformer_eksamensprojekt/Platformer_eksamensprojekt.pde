
Game g; //Game klassen, hvilket er superklassen til de klasser der køres i programmet.
int levelsCompleted; //antal levels man har klaret i alt
int klassetrin = 9; //hvilket klassetrin man i, -klassetrinnet styrer sværhedsgrad af spørgsmålene-
int mousecheck = 0; //mousecheck variabel, som bruges til at styrer museklik til knapper.

Table levelsCompletedData; //date om hvor mange levels brugeren har klaret, for at vide fra hvilket level man kan starte
Table answerData; //table til data om svar på spørgsmål

boolean keys[] = new boolean [4]; //boolean, bruges til de knapper som bruges til at styre spillet, for at få spillet til at kunne håndtere flere key inputs på en gang.

void setup() {
  size(1280, 720);
  
  answerData = loadTable("answerData.csv", "header"); // loader table med data for forkerte svar
  levelsCompletedData= loadTable("levelsCompleted.csv", "header"); //loader data om hvor mange levels der er klaret
  levelsCompleted = levelsCompletedData.getInt(0, "levelsCompleted"); //gemmer denne data i ind int-værdi, så daten kan bruges i programmet    
  
  g = new MainMenu(); //initialisere sub-subklassen til Game - MainMenu da det er hovedmenuen spillet starter i.
}

void draw() {
  background(25);

  //switch where the different levels are initialized, which is done based on the value of the level variable
  //this variable is changed to it's appropriate property, once an action is done by the user, which makes them go to a specific level.
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
  //switch where the different menus are initialized, which is done based on the value of the level variable
  //this variable is changed to it's appropriate property, once an action is done by the user, which makes them go to a specific level.
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
  case 4:
    g = new Data();
    break;
  }
  //due to these classes all being subclasses of the same superclass, it also means that whenever on of these objects are created, the other is removed, which is how changing between the different objects work,

  // the function from which the objects, which are created work
  //the function is created in the superclass, in order for it to run in the main sketch
  //the functionality of each of these subclasses, is put into their own run() function, this then runs, whichever one of these is active.
  g.run();
}

void keyPressed() {
  //styer klik som bruges til bevægelse af spiller
  if (key == 'a' || key == 'A' || keyCode == LEFT)  keys[0] = true;
  if (key == 'd' || key == 'D' || keyCode == RIGHT)  keys[1] = true;
  if (key == 'w' || key == 'W' || keyCode == UP || key == ' ')  keys[2] = true;

  //til backspace, da dens boolean værdi fra processing-miljøet ikke gad og virke inde i klassen
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
  //kører typeanswer funktionen, til hvert spørgsmål, når man kan svarer på dette.
  //funktionen kaldes i keyTyped eventet, for at få en mere naturlig taste oplevelse i spillet.
  if (g.canType[0]) g.typeanswer(1);
  if (g.canType[1]) g.typeanswer(2);
}  
