import ddf.minim.*;
// para tocar file de som com biblioteca Minim
Minim minim;
AudioPlayer song;

Star stars[];
int STARS = 100;

//Important constants
final int FPS = 60; //Framerate
PFont f;
//Variables
boolean showMouse;
int curScene = 0; //Mostra a cena que deve ser mostrada (ex. cena 0 é o menu, cena 1 o jogo)
long score; //Pontuação
long maxScore; //Pontuação máxima

void setup() {
  size(1024, 768);
  stars = new Star[STARS];
  for ( int i =0; i < STARS; i++) {
    stars[i] = new Star( random( width ), random( height ), random( 10 ));
  }
  frameRate(FPS);
  f = createFont("Arial",16,true);
  minim = new Minim(this);
  song = minim.loadFile("start.mp3");
  song.play();
  //Carregar pontuação máxima
}

void draw() {
  background(0);
  fill(255);
  game(curScene);
}

void starfield() {
  //strokeWeight( 2 );
  // nave
  stroke(65,105,225);
  fill(65,105,225);
  ellipse(mouseX, mouseY, 30, 10);
  for ( int i =0; i < STARS; i++) {
    strokeWeight( stars[i].z );
    stroke( stars[i].z * 25);
    fill(stars[i].z * 25);
    ellipse( stars[i].x, stars[i].y, 5, 5);
    if (dist(stars[i].x, stars[i].y, mouseX, mouseY) <6) curScene = 2;
    //point( stars[i].x, stars[i].y );
    stars[i].x = stars[i].x - stars[i].z;
    if (stars[i].x < 0) { 
      stars[i] = new Star( width, random( height ), sqrt(random( 100 )));
    }
  }
}

void startMenu() //Menu principal
{
  textFont(f, 40);
  text("Starfield 2\n===============\nProgramação I\n\n\nENTER: Iniciar jogo\n\nTAB: Créditos\nESC: Sair", 10, 35);
  if (keyPressed)
  {
    if (key == ENTER) curScene = 1;
  }
  return;
}

void gameOver() //Ecrã de game over
{
  textFont(f, 20);
  text("Starfield 2\n===============\n\nPontuação: " + score + "\nRecorde: " + maxScore, 10, 35);
}

void game(int scene)
{
  switch(scene)
  {
    case 0:
      showMouse = true;
      break;
    case 1:
      showMouse = false;
      break;
    case 2:
      showMouse = true;
      break;
  }
  
  if (!showMouse) noCursor();
  else cursor(ARROW);
  
  switch(scene)
  {
    case 0:
      startMenu();
      break;
    case 1:
      starfield();
      break;
    case 2:
      gameOver();
      break;
  }
}




//Outras funções






class Star {
  float x, y, z;
  Star( float x, float y, float z ) {
    this.x = x;
    this.y = y;
    this.z = z;
  }
}