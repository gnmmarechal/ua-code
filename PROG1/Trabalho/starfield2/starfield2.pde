import ddf.minim.*;
import java.util.*;

// para tocar file de som com biblioteca Minim
Minim minim;
AudioPlayer themeA, explosionSFX, ouchSFX, upSFX, crashSFX;

//Constants
final String versionString = "Starfield 2 | 0.3 Pos-Presentation | 02122016 | gs2012@Qosmio-X70-B-10T";
final int res[] = { 1024, 768 };
final int STARS = 50;
final int ASTEROIDS = 5;
final int OG_FPS = 60;
final int pointsPerKill = 200;
//Star variables
Star stars[], menuStars[];

//Ship variables
Ship enemyShips[], asteroids[];

int controlType = 0; //1 for Mouse, 2 for keyboard

boolean upOnScreen = false, starsInstructionRan = false;

//Difficulty related variables
int valToIncreaseDiff = 10; //Valor a incrementar nos FPS a cada 30s
int diffDelta = 15000; //Tempo entre mudanças de FPS
Timer diffTimer; //Timer for difficulty
int FPS = OG_FPS; //Framerate

//Font variable
PFont f;
//Variables
int shipSpeed[] = { 40, 40}; //Speed for the ship (keyboard controls)
int enemyShipSpeed[][] = {
  { 10, 10 },
  { 20, 20 }
};
int lifeCoords[] = new int[2]; //Coordenadas para as vidas
int shipX,shipY;
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
  { 255, 255, 0},
  { 100, 80, 21}
};
int shipLives[] = { 3, 0, -2 }; //Dependendo da nave, o número de vidas muda
int defaultCoords[] = { res[0]/10, res[1]/2 }; //Coordenadas por defeito (para controls de teclado)

//Opções
String controlTypeName[] = { "Rato", "Teclado" };

void settings() {
  size(res[0], res[1]); //Define a resolução
}
void setup() {
  stars = new Star[STARS];
  menuStars = new Star[STARS];
  
  asteroids = new Ship[ASTEROIDS];
  
  for ( int i = 0; i < STARS; i++) {
    stars[i] = new Star( width, random( height ), random( 10 ));
  }
  for ( int i = 0; i < STARS; i++) {
    menuStars[i] = new Star( width, random( height ), random( 10 ));
  }
  
  for ( int i = 0; i < ASTEROIDS; i++) {
    asteroids[i] = new Ship( width, random( height ), random( 10 ), enemyShipSpeed[0][(int) random(0, 1)], enemyShipSpeed[0][(int) random(0, 1)], 0, (int) random(20, 50));
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
  crashSFX = minim.loadFile("crashSound.mp3");
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
  // Nave
  stroke(shipColours[curShip][0], shipColours[curShip][1], shipColours[curShip][2]);
  fill(shipColours[curShip][0], shipColours[curShip][1], shipColours[curShip][2]);
  
  //Define as coordenadas da nave
  shipX = setCoords("x", controlType, gameLoopCounter, shipX, shipY);
  shipY = setCoords("y", controlType, gameLoopCounter, shipX, shipY);
  if (debugMode) System.out.println("shipX = " + shipX + "\nshipY = " + shipY);
  
  ellipse(shipX, shipY, 30, 10);
  
  //Asteroids
  if (System.currentTimeMillis() - tStart >= 10000) //Start spawning asteroids
  {
    for (int i = 0; i < ASTEROIDS; i++) {
      if (asteroids[i].life > 0)
      {
        stroke(shipColours[3][0], shipColours[3][1], shipColours[3][2]);
        fill(shipColours[3][0], shipColours[3][1], shipColours[3][2]);
        ellipse(asteroids[i].x, asteroids[i].y, asteroids[i].radius, asteroids[i].radius);
        
        //Collision detection
        if (dist(asteroids[i].x, asteroids[i].y, shipX, shipY) < asteroids[i].radius)
        {
          lives--;
          ouchSFX.play();
          asteroids[i].life--;
          crashSFX.play();
        }
    }
      //Move ship
      asteroids[i].x -= asteroids[i].z;
      asteroids[i].y -= random(-10, 10);
      
      if (asteroids[i].x < 0)
      {
        asteroids[i] = new Ship( width, random( height ), sqrt(random(10)), enemyShipSpeed[0][(int) random(0,1)], enemyShipSpeed[0][(int) random(0, 1)], 1, (int) random(20, 50));
      }
      
      
    }
  }
  
  for ( int i = 0; i < STARS; i++) {
    strokeWeight( stars[i].z );
    stroke( stars[i].z * 25);
    fill(stars[i].z * 25);
    ellipse( stars[i].x, stars[i].y, 5, 5);
    if (dist(stars[i].x, stars[i].y, shipX, shipY) < 7) 
    {
      lives--; //Reduzir vidas
      ouchSFX.play();
    }
    if (!crashSFX.isPlaying()) { crashSFX.pause(); crashSFX.rewind(); }
    if (!ouchSFX.isPlaying()) { ouchSFX.pause(); ouchSFX.rewind(); }
    if (!upSFX.isPlaying()) { upSFX.pause(); upSFX.rewind();}
    //point( stars[i].x, stars[i].y );
    stars[i].x -= stars[i].z;
    if (stars[i].x < 0) { 
      stars[i] = new Star( width, random( height ), sqrt(random( 100 )));
    }
  }
  if (lives < 0) curScene = 2; //Game Over
  
  if (((int) random( 1, 600 ) == 6) && !upOnScreen) {upOnScreen = true; lifeCoords[0] = width; lifeCoords[1] = (int) random (height);}
  
  if (upOnScreen)
  {
    lifeCoords[0] -= width/100; 
    stroke(0,255,0);
    fill(0,255,0);
    ellipse( lifeCoords[0], lifeCoords[1], 6, 6);
    if (dist(lifeCoords[0], lifeCoords[1], shipX, shipY) < 7)
    {
      lives++;
      upSFX.play();
      upOnScreen = false;
    }
    if (lifeCoords[0] < 0) upOnScreen = false;
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
  text("Starfield 2\n===============\nProgramação I\n\n\nENTER: Iniciar jogo\n\nCTRL: Opções\nTAB: Créditos\nESC: Sair", 10, 35);
  if (keyPressed)
  {
    switch(key)
    {
      case ENTER:
        curScene = 3;
        break;
    }
    switch(keyCode)
    {
      case TAB:
        curScene = 4;
        break;
      case CONTROL:
        curScene = 5;
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
  text("Starfield 2\n===============\nEscolha a sua nave:\nENTER: Começar o jogo\n<-" + shipName[curShip] + "->\n\nEstatísticas:\nVidas Extra:" + shipLives[curShip], 10, 35);
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
    if (key == ENTER) { lives += shipLives[curShip]; resetStars(); curScene = 1; }
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
    FPS = OG_FPS;
    diffTimer.cancel();
    diffTimer.purge();
    /*for ( int i =0; i < STARS; i++) {
      menuStars[i] = new Star( width, random( height ), random( 10 ));
    } */  
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

void optionsMenu()
{
  textFont(f, 40);
  dynamicBackground();
  fill(255,255,0);
  text("Starfield 2\n===============\n\nOpções:\n- Controlos: <-"+ controlTypeName[controlType] +"->\n\n\nClique ENTER para regressar", 10, 35);
  if (keyPressed)
  {
    if (key == ENTER) curScene = 0;
    if (keyCode == RIGHT)
    {
      if (controlType < 1) {controlType++; waitMs(100);}
    }
    if (keyCode == LEFT)
    {
      if ((controlType > 0)) { controlType--; waitMs(100);}
    }
  }  
}

void game(int scene)
{
  if (keyPressed && 
  keyCode == ALT) {  debugMode = !debugMode;  key = 0; keyCode = 0;}
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
    case 5:
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
    case 5:
      optionsMenu();
      break;
  }
  keyCode = 0;
  key = 0;
}




//Outras funções

int setCoords(String des, int controlType, long gameLoopCounter, int var1, int var2) //contolType vai de 0 ( Mouse) a 1 (Keyboard)
{
  int x = var1, y = var2;
  
  if (gameLoopCounter == 1) {x = defaultCoords[0]; y = defaultCoords[1];}
  //Controls
  switch(controlType)
  {
    case 0:
      x = mouseX;
      y = mouseY;
      break;
    case 1:
      if (keyPressed && (key == 'a' || key == 'A') && x >= 0) x -= shipSpeed[0];
      if (keyPressed && (key == 'd' || key == 'D') && x <= width) x += shipSpeed[0];
      if (keyPressed && (key == 'w' || key == 'W') && y >= 0) y -= shipSpeed[1];
      if (keyPressed && (key == 's' || key == 'S') && y <= height) y += shipSpeed[1];      
      break;
  }
  int ret = y;
  if (des == "x") ret = x;
  return ret;
}
void resetStars()
{
  for ( int i = 0; i < STARS; i++) {
    stars[i] = new Star( width, random( height ), random( 10 ));
  }
  for (int i = 0; i < ASTEROIDS; i++) {
    asteroids[i] = new Ship( width, random( height ), sqrt(random(10)), enemyShipSpeed[0][(int) random(0,1)], enemyShipSpeed[0][(int) random(0, 1)], 1, (int) random(20, 50));
  }
}
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
    menuStars[i].x -= menuStars[i].z;
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

class Ship {
  float x, y, z;
  int xSpeed, ySpeed;
  int life, radius;
  Ship( float x, float y, float z, int xSpeed, int ySpeed, int life, int radius)
  {
    this.x = x;
    this.y = y;
    this.z = z;
    this.xSpeed = xSpeed;
    this.ySpeed = ySpeed;
    this.life = life;
    this.radius = radius;
  }
}