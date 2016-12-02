import ddf.minim.*;
import java.util.*;
// para tocar file de som com biblioteca Minim
Minim minim;
AudioPlayer themeA, explosionSFX, ouchSFX, upSFX;

//Constants
final String versionString = "Starfield 2 | 0.2 Pre-Presentation | 01122016 | gs2012@Qosmio-X70-B-10T";

Star stars[];
Star menuStars[];;

int STARS = 100;
boolean upOnScreen = false, starsInstructionRan = false;
int valToIncreaseDiff = 10; //Valor a incrementar nos FPS a cada 30s
int diffDelta = 15000; //Tempo entre mudanças de FPS
Timer diffTimer;


int FPS = 60; //Framerate

PFont f;
//Variables
int lifeX,lifeY;
boolean debugMode = true;
boolean showMouse;
int curScene = 0; //Mostra a cena que deve ser mostrada (ex. cena 0 é o menu, cena 1 o jogo)
long score; //Pontuação
long maxScore; //Pontuação máxima
long gameLoopCounter = 0, menuLoopCounter = 0;
long tStart, tDelta, tGamma;
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
  menuStars = new Star[STARS];
  for ( int i =0; i < STARS; i++) {
    stars[i] = new Star( width, random( height ), random( 10 ));
  }
  for ( int i =0; i < STARS; i++) {
    menuStars[i] = new Star( width, random( height ), random( 10 ));
  }  
  frameRate(FPS);
  f = createFont("Arial",16,true);
  minim = new Minim(this);
  themeA = minim.loadFile("themeA.mp3");
  themeA.loop();
  //Carregar outros temas e BGM/SFX
  explosionSFX = minim.loadFile("explosion.mp3");
  ouchSFX = minim.loadFile("ouch.mp3");
  upSFX = minim.loadFile("up.mp3");
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
  if (gameLoopCounter == 1) { tStart = System.currentTimeMillis(); diffTimer = new Timer(); }
  
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
    if (dist(stars[i].x, stars[i].y, mouseX, mouseY) < 7) 
    {
      lives--; //Reduzir vidas
      ouchSFX.play();
    }
    if (!ouchSFX.isPlaying()) { ouchSFX.pause(); ouchSFX.rewind(); }
    if (!upSFX.isPlaying()) { upSFX.pause(); upSFX.rewind();}
    //point( stars[i].x, stars[i].y );
    stars[i].x = stars[i].x - stars[i].z;
    if (stars[i].x < 0) { 
      stars[i] = new Star( width, random( height ), sqrt(random( 100 )));
    }
  }
  if (lives < 0) curScene = 2; //Game Over
  
  if (((int) random( 1, 600 ) == 6) && !upOnScreen) {upOnScreen = true; lifeX = width; lifeY = (int) random (height);}
  
  if (upOnScreen)
  {
    lifeX -= width/100; 
    stroke(0,255,0);
    fill(0,255,0);
    ellipse( lifeX, lifeY, 6, 6);
    if (dist(lifeX, lifeY, mouseX, mouseY) < 7)
    {
      lives++;
      upSFX.play();
      upOnScreen = false;
    }
    if (lifeX < 0) upOnScreen = false;
  }
  tDelta = System.currentTimeMillis() - tStart;
  score += (tDelta/2000) * FPS/60; //Dá menos pontos se o frameRate for abaixo de 60, mais se acima.
  textFont(f, 20);
  fill(255,0,0);
  text("Vidas: " + lives + "\nPontos: " + score, 10, 35);
  
  //Info de debug
  if (debugMode) System.out.println("Time: " + tDelta + "ms\nFPS: " + FPS);
  
  //Aumentar a dificuldade a cada diffDelta/1000 segundos
  diffTimer.schedule(new TimerTask() {
    @Override
    public void run() {
      FPS += valToIncreaseDiff;
      diffTimer.cancel();
      diffTimer.purge();
      diffTimer = new Timer();
      //É feito reset ao diffTimer e re-criado a cada 30s.
      return;
    }
  } , diffDelta);
  
}

void startMenu() //Menu principal
{
  textFont(f, 40);
  dynamicBackground();
  fill(255,255,0);
  text("Starfield 2\n===============\nProgramação I\n\n\nENTER: Iniciar jogo\n\nTAB: Créditos\nESC: Sair", 10, 35);
  if (keyPressed)
  {
    switch(key)
    {
      case ENTER:
        curScene = 3;
        break;
      case TAB:
        curScene = 4;
        break;
    }
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
      if (curShip < 2) {curShip++; waitMs(100);}
    }
    if (keyCode == LEFT)
    {
      if (!(curShip < 1)) { curShip--; waitMs(100);}
    }
    if (key == ENTER) curScene = 1;
  }
}
void gameOver() //Ecrã de game over
{
  //Colocar as menuStars iguais às stars
  if (!starsInstructionRan) { for (int i = 0; i < STARS; i++) menuStars[i] = stars[i]; starsInstructionRan = true; }
  //BGM Explosion
  explosionSFX.play();  
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
    explosionSFX.pause();
    explosionSFX.rewind();
    FPS = 60;
    diffTimer.cancel();
    diffTimer.purge();
    for ( int i =0; i < STARS; i++) {
      menuStars[i] = new Star( width, random( height ), random( 10 ));
    }
    starsInstructionRan = false;
  }
}


void creditsScreen()
{
  textFont(f, 40);
  dynamicBackground();
  fill(255,255,0);
  text("Starfield 2\n===============\n\nCréditos:\n- Diogo Baptista nº 79405\n- Mário Liberato nº 84917\n\nClique ENTER para regressar", 10, 35);
  if (keyPressed && key == ENTER) curScene = 0;
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
    
    if (keyPressed && keyCode == RIGHT) lives++;
    else if (keyPressed && lives >= 0 && keyCode == LEFT) lives--;
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
    case 4:
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
    case 4:
      creditsScreen();
      break;
  }
  
  key = 0;
}




//Outras funções

void waitMs(long ms)
{
  long tIgnoreFinal = System.currentTimeMillis() + ms;
  while (tIgnoreFinal > System.currentTimeMillis());
}

void dynamicBackground()
{
  for ( int i = 0; i < STARS; i++) {
    strokeWeight( menuStars[i].z );
    stroke( menuStars[i].z * 25);
    fill(menuStars[i].z * 25);
    ellipse( menuStars[i].x, menuStars[i].y, 5, 5);
    menuStars[i].x = menuStars[i].x - menuStars[i].z;
    if (menuStars[i].x < 0) { 
      menuStars[i] = new Star( width, random( height ), sqrt(random( 100 )));
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