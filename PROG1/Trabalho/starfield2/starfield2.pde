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
  //
}

void draw() {
  background(0);
  fill(255);
  game(curScene);
}

void starfield() {
  //strokeWeight( 2 );
  // nave
  stroke(255,30,0);
  fill(255,0,0);
  ellipse(mouseX, mouseY, 30, 10);
  for ( int i =0; i < STARS; i++) {
    strokeWeight( stars[i].z );
    stroke( stars[i].z * 25);
    fill(stars[i].z * 25);
    ellipse( stars[i].x, stars[i].y, 5, 5);
    if (dist(stars[i].x, stars[i].y, mouseX, mouseY) <6) noLoop();
    //point( stars[i].x, stars[i].y );
    stars[i].x = stars[i].x - stars[i].z;
    if (stars[i].x < 0) { 
      stars[i] = new Star( width, random( height ), sqrt(random( 100 )));
    }
  }
}

void startMenu() //Menu principal
{
  showMouse = true;
  textFont(f, 40);
  text("Starfield 2\n===============\nProgramação I\n\n\nENTER: Iniciar jogo\n\nTAB: Créditos\nESC: Sair", 10, 35);
  if (keyPressed)
  {
    if (key == ENTER) curScene = 1;
  }
  return;
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