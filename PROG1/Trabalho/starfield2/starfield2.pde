import ddf.minim.*;
import java.util.*;
// para tocar file de som com biblioteca Minim
Minim minim;
AudioPlayer themeA, explosionBGM;

//Constants
final String versionString = "Starfield 2 | 0.2 Pre-Presentation | 29112016 | gs2012@Qosmio-X70-B-10T";

Star stars[];
int STARS = 100;

int FPS = 60; //Framerate
PFont f;
//Variables
boolean debugMode = true;
boolean showMouse;
int curScene = 0; //Mostra a cena que deve ser mostrada (ex. cena 0 é o menu, cena 1 o jogo)
long score; //Pontuação
long maxScore; //Pontuação máxima
long gameLoopCounter = 0, menuLoopCounter = 0;
long tStart, tDelta;
String scoreFilePath = System.getProperty("user.dir") + "/score.dat";
int lives = 3; //Vidas
int curShip = 0;
String shipName[] = { "Azul", "Vermelha", "Amarela"};
int shipColours[][] = {
  { 65, 105, 225 },
  { 255, 0, 0},
  { 255, 255, 0}
};
void setup() {
  size(1024, 768);
  stars = new Star[STARS];
  for ( int i =0; i < STARS; i++) {
    stars[i] = new Star( random( width ), random( height ), random( 10 ));
  }
  frameRate(FPS);
  f = createFont("Arial",16,true);
  minim = new Minim(this);
  themeA = minim.loadFile("themeA.mp3");
  themeA.play();
  themeA.loop();
  //Carregar outros temas e BGM
  explosionBGM = minim.loadFile("explosion.mp3");
  //Carregar pontuação máxima
  loadMaxScore(scoreFilePath);
}

void draw() {
  background(0);
  fill(255);
  game(curScene);
}

void starfield() {
  gameLoopCounter++;
  if (gameLoopCounter == 1) tStart = System.currentTimeMillis();
  //strokeWeight( 2 );
  // nave
  stroke(shipColours[curShip][0], shipColours[curShip][1], shipColours[curShip][2]);
  fill(shipColours[curShip][0], shipColours[curShip][1], shipColours[curShip][2]);
  ellipse(mouseX, mouseY, 30, 10);
  for ( int i =0; i < STARS; i++) {
    strokeWeight( stars[i].z );
    stroke( stars[i].z * 25);
    fill(stars[i].z * 25);
    ellipse( stars[i].x, stars[i].y, 5, 5);
    if (dist(stars[i].x, stars[i].y, mouseX, mouseY) <6) lives--; //Reduzir vidas
    //point( stars[i].x, stars[i].y );
    stars[i].x = stars[i].x - stars[i].z;
    if (stars[i].x < 0) { 
      stars[i] = new Star( width, random( height ), sqrt(random( 100 )));
    }
  }
  if (lives < 0) curScene = 2; //Game Over
  tDelta = System.currentTimeMillis() - tStart;
  score += (tDelta/2000) * FPS/60; //Dá menos pontos se o frameRate for abaixo de 60, mais se acima.
  textFont(f, 20);
  fill(255,0,0);
  text("Vidas: " + lives + "\nPontos: " + score, 10, 35);
  
}

void startMenu() //Menu principal
{
  textFont(f, 40);
  dynamicBackground();
  fill(255,255,0);
  text("Starfield 2\n===============\nProgramação I\n\n\nENTER: Iniciar jogo\n\nTAB: Créditos\nESC: Sair", 10, 35);
  if (keyPressed)
  {
    if (key == ENTER) curScene = 3;
  }
  return;
}

void chooseShip() //Menu de escolher a nave
{
  textFont(f, 40);
  dynamicBackground();
  fill(255,255,0);
  text("Starfield 2\n===============\nEscolha a sua nave:\nENTER: Começar o jogo\n<-" + shipName[curShip] + "->", 10, 35);
  if (keyPressed)
  {
    if (keyCode == RIGHT)
    {
      if (curShip < 2) {curShip++; ignoreInput(100);}
    }
    if (keyCode == LEFT)
    {
      if (!(curShip < 1)) { curShip--; ignoreInput(100);}
    }
    if (key == ENTER) curScene = 1;
  }
}
void gameOver() //Ecrã de game over
{
  //BGM Explosion
  explosionBGM.play();  
  //Calcular recorde (e guardar valores)
  if (score > maxScore) maxScore = score;
  try 
  {
    PrintWriter scoreOut = new PrintWriter(scoreFilePath);
    scoreOut.println(maxScore);
    scoreOut.close();    
  }
  catch (Exception e) { System.err.println("Erro: " + e.getMessage()); };
  
  textFont(f, 20);
  dynamicBackground();
  fill(255,255,0);
  text("Starfield 2\n===============\n\nPontuação: " + score + "\nRecorde: " + maxScore + "\nClique ENTER para voltar ao menu inicial!", 10, 35);
  if (keyPressed && key == ENTER) //Faz reset a variáveis e volta
  {
    curScene = 0;
    score = 0;
    gameLoopCounter = 0;
    menuLoopCounter = 0;
    lives = 3;
    explosionBGM.pause();
    explosionBGM.rewind();
  }
}

void game(int scene)
{
  if (keyPressed && keyCode == ALT) {  debugMode = !debugMode;  key = 0; }
  if(debugMode)
  {
    textFont(f, 15);
    fill(0,255,0);
    text("Debug Info:\nBuild: " + versionString + "\nFPS: " + FPS, 30, height - 80);
    
    if (keyPressed && keyCode == UP)
      FPS++;
    else if (FPS > 1 && keyPressed && keyCode == DOWN)
      FPS--;
  }
  frameRate(FPS);
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
    case 3:
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
    case 3:
      chooseShip();
      break;
  }
  
  key = 0;
}




//Outras funções
void ignoreInput(long ms)
{
  long tIgnoreFinal = System.currentTimeMillis() + ms;
  while (tIgnoreFinal > System.currentTimeMillis());
}

void dynamicBackground()
{
  for ( int i = 0; i < STARS; i++) {
    strokeWeight( stars[i].z );
    stroke( stars[i].z * 25);
    fill(stars[i].z * 25);
    ellipse( stars[i].x, stars[i].y, 5, 5);
    stars[i].x = stars[i].x - stars[i].z;
    if (stars[i].x < 0) { 
      stars[i] = new Star( width, random( height ), sqrt(random( 100 )));
    }
  }
}

void loadMaxScore(String filePath)
{
  try 
  {
    File scoreFile = new File(filePath);
    Scanner fileRead = new Scanner(scoreFile);
    while (fileRead.hasNextLong())
    {
      maxScore = fileRead.nextLong();
    }
    fileRead.close();
  } catch (Exception e) { System.err.println("Erro: " + e.getMessage());};
}




class Star {
  float x, y, z;
  Star( float x, float y, float z ) {
    this.x = x;
    this.y = y;
    this.z = z;
  }
}

class Bullet {
  float x, y, z, xSpeed, ySpeed;
  Bullet( float x, float y, float z, float xSpeed, float ySpeed)
  {
    this.x = x;
    this.y = y;
    this.z = z;
    this.xSpeed = xSpeed;
    this.ySpeed = ySpeed;
  }
}