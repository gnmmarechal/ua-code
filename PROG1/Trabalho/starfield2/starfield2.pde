import ddf.minim.*;
import java.util.*;
import static javax.swing.JOptionPane.*;

// para tocar file de som com biblioteca Minim
Minim minim;
AudioPlayer themeA, explosionSFX, ouchSFX, upSFX, crashSFX, laserSFX;
PImage splash;

//Constants
final String versionString = "Starfield 2 | 0.5 Submission Edition | 11122016 | gs2012@Qosmio-X70-B-10T";
final int res[] = { 1024, 768 };
final int STARS = 50;
final int ASTEROIDS = 14;
final int OG_FPS = 60;
final int pointsPerKill = 200;
final int bulletLimit = 300;
//Star variables
Star stars[], menuStars[];

//Ship variables
Ship enemyShips[], asteroids[];
int killedAsteroids = 0;
Triangle shipTriangle;


ArrayList <Bullet> bullets;
int bulletSpeed[] = { 10, 10 };

//Enemy bullets and ship?
ArrayList <Bullet> enemyBullets;
int enemyBulletSpeed[] = { -10, -10 };
double maxEnemyFireRate = 0.8;

int controlType = 0; //1 for Mouse, 2 for keyboard

boolean upOnScreen = false, starsInstructionRan = false, recordSaved = false;;

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
  { 20, 20 },
  { 25, 25 },
  { 90, 35 }
};
int lifeCoords[] = new int[2]; //Coordenadas para as vidas
int shipCoords[] = new int[2]; //Coordenadas da nave
boolean debugMode = false;
boolean showMouse;
int curScene = 6; //Mostra a cena que deve ser mostrada (ex. cena 0 é o menu, cena 1 o jogo, etc.)
long score; //Pontuação
long maxScore; //Pontuação máxima
long[] maxScoreArray = new long[5]; // Array da pontuação máxima
long gameLoopCounter = 0, menuLoopCounter = 0;
long tStart, tDelta, splashStart;
int splashLoop = 0;
String scoreFilePath = System.getProperty("user.dir") + "/scoreboard.dat";
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
  //Gerar ficheiro de score a zeros se não existir
  File scrFile = new File(scoreFilePath);
  if (!scrFile.exists())
  {
    generateFile(scoreFilePath);
  }
  
  //Setup
  stars = new Star[STARS];
  menuStars = new Star[STARS];
  
  asteroids = new Ship[ASTEROIDS];
  
  bullets = new ArrayList();
  
  for ( int i = 0; i < STARS; i++) {
    stars[i] = new Star( random(width), random( height ), random( 10 ));
  }
  for ( int i = 0; i < STARS; i++) {
    menuStars[i] = new Star( random(width), random( height ), random( 10 ));
  }
  
  for ( int i = 0; i < ASTEROIDS; i++) {
    asteroids[i] = new Ship( width, random( height ), random( 10 ), enemyShipSpeed[(int) random(0, 3)][0], enemyShipSpeed[(int) random(0, 3)][1], 0, (int) random(20, 50));
  }
  frameRate(FPS);
  f = createFont("Arial",16,true);
  minim = new Minim(this);
  themeA = minim.loadFile("resources/sound/themeA.mp3");
  themeA.loop();
  //Carregar outros temas e BGM/SFX
  explosionSFX = minim.loadFile("resources/sound/explosion.mp3");
  ouchSFX = minim.loadFile("resources/sound/ouch.mp3");
  upSFX = minim.loadFile("resources/sound/up.mp3");
  crashSFX = minim.loadFile("resources/sound/crashSound.mp3");
  laserSFX = minim.loadFile("resources/sound/laser.mp3");
  //Carregar imagens
  splash = loadImage("resources/img/splash.png");
  
  //Carregar pontuação máxima
  //loadMaxScore(scoreFilePath);
  maxScoreArray = readScores(scoreFilePath);
}

void draw() {
  background(0);
  fill(255);
  game(curScene);
}

void starfield() {
  gameLoopCounter++;
  if (gameLoopCounter == 1) { tStart = System.currentTimeMillis(); diffTimer = new Timer(); }
  
  // Nave
  shipCoords = drawShip(shipCoords);
  
  //Asteroids
  if (System.currentTimeMillis() - tStart >= 10000) //Start spawning asteroids
  {
    for (int i = 0; i < ASTEROIDS; i++) {
      if (asteroids[i].life > 0)
      {
        stroke(shipColours[3][0], shipColours[3][1], shipColours[3][2]);
        fill(shipColours[3][0], shipColours[3][1], shipColours[3][2]);
        ellipse(asteroids[i].x, asteroids[i].y, asteroids[i].radius, asteroids[i].radius);
        
        //Collision detection with ship
        //if (dist(asteroids[i].x, asteroids[i].y, shipCoords[0], shipCoords[1]) < asteroids[i].radius)
        if (checkCollisionWithCircle(shipTriangle, (int) asteroids[i].x, (int) asteroids[i].y, asteroids[i].radius))
        {
          lives--;
          ouchSFX.play();
          asteroids[i].life--;
          crashSFX.play();
        }
        
        //Collision detection with bullet (laser?)
        for (int z = 0; z < bullets.size(); z ++)
        {
          if ((dist(asteroids[i].x, asteroids[i].y, bullets.get(z).x, bullets.get(z).y) < asteroids[i].radius) && bullets.get(z).exists)
          {
            asteroids[i].life--;
            bullets.get(z).exists = false;
            crashSFX.play();
            //
            killedAsteroids++;
            score += pointsPerKill;
            if (killedAsteroids >= 10)
            {
              killedAsteroids = 0;
              lives += 2;
            }
          }
        }
        
    }
      //Move ship
      asteroids[i].x -= asteroids[i].z;
      asteroids[i].y -= random(-1, 1);
      
      if (asteroids[i].x < 0)
      {
        asteroids[i] = new Ship( width, random( height ), sqrt(random(10)), enemyShipSpeed[(int) random(0, 3)][0], enemyShipSpeed[(int) random(0, 3)][1], 1, (int) random(20, 50));
      }
      
      
    }
  }
  
  for ( int i = 0; i < STARS; i++) {
    strokeWeight( stars[i].z );
    stroke( stars[i].z * 25);
    fill(stars[i].z * 25);
    ellipse( stars[i].x, stars[i].y, 5, 5);
    //if (dist(stars[i].x, stars[i].y, shipCoords[0], shipCoords[1]) < 7)
    if (checkCollisionWithCircle(shipTriangle, (int) stars[i].x, (int) stars[i].y, 7))
    {
      lives--; //Reduzir vidas
      ouchSFX.play();
    }
    if (!crashSFX.isPlaying()) { crashSFX.pause(); crashSFX.rewind(); }
    if (!ouchSFX.isPlaying()) { ouchSFX.pause(); ouchSFX.rewind(); }
    if (!upSFX.isPlaying()) { upSFX.pause(); upSFX.rewind();}
    if (!laserSFX.isPlaying()) { laserSFX.pause(); laserSFX.rewind(); }
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
    strokeWeight(6);
    ellipse( lifeCoords[0], lifeCoords[1], 6, 6);
    //if (dist(lifeCoords[0], lifeCoords[1], shipCoords[0], shipCoords[1]) < 9)
    if ((checkCollisionWithCircle(shipTriangle, (int) lifeCoords[0], (int) lifeCoords[1], 9)))
    {
      lives++;
      upSFX.play();
      upOnScreen = false;
    }
    if (lifeCoords[0] < 0) upOnScreen = false;
  }
  
  //Bullets
  if (mousePressed || (keyPressed && (key == 'O' || key == 'o' )))
  {
    Bullet temp = new Bullet(shipCoords[0] + 30, shipCoords[1], true);
    bullets.add(temp);
    if (!laserSFX.isPlaying()) laserSFX.play();
  }
  else
  {
    if (laserSFX.isPlaying()) { laserSFX.pause(); laserSFX.rewind(); }
  }
  removeBullets(bulletLimit);
  moveAllBullets();
  showAllBullets();
  
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
  text("Starfield 2\n===============\nProgramação I\n\n\n\nENTER: Iniciar jogo\n\nCTRL: Opções\nTAB: Créditos\nESC: Sair", 10, 35);
  text("\n\n\n\n\n\n                                         Recordes:\n", 10, 35);
  for (int i = 0; i < 5; i++)
  {
    text("\n\n\n\n\n\n                                          " + (i+1) + ": " + maxScoreArray[i] + " pontos", 10, 70 + (35*i));
  }
  if (keyPressed)
  {
    switch(key)
    {
      case TAB:
        curScene = 4;
        break;
      case ENTER:
        curScene = 3;
        break;
    }
    switch(keyCode)
    {
      case CONTROL:
        curScene = 5;
        break;
    }
  }
  checkMouseMenu();
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
      else { curShip = 0; waitMs(100); }
    }
    if (keyCode == LEFT)
    {
      if (!(curShip < 1)) { curShip--; waitMs(100);}
      else { curShip = 2; waitMs(100); }
    }
    if (key == ENTER) {  if (debugMode) System.out.println("Vidas: " + lives + " + " + shipLives[curShip]);lives += shipLives[curShip]; resetStars(); curScene = 1; }
  }
}
void gameOver() //Ecrã de game over
{
  //Colocar as menuStars iguais às stars
  if (!starsInstructionRan) { for (int i = 0; i < STARS; i++) menuStars[i] = stars[i]; starsInstructionRan = true; }
  //BGM Explosion
  explosionSFX.play();  
  //Calcular recorde (e guardar valores)
  /*
  if (score > maxScore) 
  {
    maxScore = score;
    writeMaxScore(scoreFilePath, maxScore);
  }
  */
  if (isRecord(score, maxScoreArray) && !recordSaved)
  {
    int newRecordIndex = recordIndex(score, maxScoreArray);
    maxScoreArray = generateRecordArray(score, maxScoreArray, newRecordIndex);
    writeScores(scoreFilePath, maxScoreArray);
    recordSaved = true;
  }
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
    recordSaved = false;
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
  if (keyPressed && (key == 'B' || key == 'b') ) {  debugMode = !debugMode;  key = 0; keyCode = 0;}
  if(debugMode)
  {
    textFont(f, 15);
    fill(0,255,0);
    text("Debug Info:\nBuild: " + versionString + "\nFPS: " + FPS, 30, height - 80);
    
    if (keyPressed && (key == 'l' || key == 'L'))
      FPS++;
    else if (FPS > 1 && keyPressed && (key == 'k' || key == 'K'))
      FPS--;
    
    if (keyPressed && (key == 'm' || key == 'M')) lives++;
    else if (keyPressed && lives >= 0 && (key == 'n' || key == 'N')) lives--;
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
    case 6:
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
    case 6:
      splashScreen();
      break;
  }
  keyCode = 0;
  key = 0;
}




//Outras funções
boolean checkCollisionWithCircle(Triangle t, int circleX, int circleY, int radius)
{
  //(x-a)^2 + (y-b)^2 = r^2
  //x(t) = r cos(t) + j
  //y(t) = r sin(t) + k
  
  for (int i = 0; i<360; i++)
  {
    int curX = (int) (radius * cos((float) Math.toRadians(i))) + circleX;
    int curY = (int) (radius * sin((float) Math.toRadians(i))) + circleY;
    if (checkCollisionWithPoint(curX, curY, t)) return true;
  }
  
  return false;
}
boolean checkCollisionWithPoint(float x, float y, Triangle t) {
  float tArea,t1Area,t2Area,t3Area;
  tArea  = triangleArea(t.point1x, t.point1y, t.point3x, t.point3y, t.point2x, t.point2y);
  t1Area = triangleArea(x,y, t.point2x, t.point2y, t.point3x, t.point3y);
  t2Area = triangleArea(x,y, t.point3x, t.point3y, t.point1x, t.point1y);
  t3Area = triangleArea(x,y, t.point2x, t.point2y, t.point1x, t.point1y);
  
  float totalArea = t1Area+t2Area+t3Area;
  return (totalArea == tArea);
}

float triangleArea(float p1, float p2, float p3, float p4, float p5, float p6) {
  float a,b,c,d;
  a = p1 - p5;
  b = p2 - p6;
  c = p3 - p5;
  d = p4 - p6;
  return (0.5* abs((a*d)-(b*c)));
}
int[] drawShip(int coords[])
{

  strokeWeight(10);
  stroke(shipColours[curShip][0], shipColours[curShip][1], shipColours[curShip][2]);
  fill(shipColours[curShip][0], shipColours[curShip][1], shipColours[curShip][2]);
  
  //Define as coordenadas da nave
  coords[0] = setCoords("x", controlType, gameLoopCounter, coords[0], coords[1]);
  coords[1] = setCoords("y", controlType, gameLoopCounter, coords[0], coords[1]); 
  if (debugMode) System.out.println("shipX = " + coords[0] + "\nshipY = " + coords[1]);
  
  //ellipse(coords[0], coords[1], 30, 10);
  //triangle(coords[0] - 15, coords[1] - 5, coords[0] - 15, coords[1] + 5, coords[0] , coords[1]);
  shipTriangle = new Triangle(coords[0] - 15, coords[1] - 5, coords[0] - 15, coords[1] + 5, coords[0] , coords[1]);
  shipTriangle.drawTriangle();
  
  return coords;
}
void removeBullets(int limit)
{
  while(bullets.size() > limit)
  {
    bullets.remove(0);
  }
}
void moveAllBullets()
{
  for(Bullet a : bullets)
  {
    a.move();
  }
}
void showAllBullets()
{
  for(Bullet a : bullets)
  {
    if (a.exists) a.display();
  }
}
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
      if (keyPressed)
      {
        if ((key == 'a' || key == 'A') && x >= 0) x -= shipSpeed[0];
        if ((key == 'd' || key == 'D') && x <= width) x += shipSpeed[0];
        if ((key == 'w' || key == 'W') && y >= 0) y -= shipSpeed[1];
        if ((key == 's' || key == 'S') && y <= height) y += shipSpeed[1]; 
      }
      break;
  }
  //Take action
  
  int ret = y;
  if (des == "x") ret = x;
  return ret;
}
void resetStars()
{
  //Reset stars
  for ( int i = 0; i < STARS; i++) {
    stars[i] = new Star( width, random( height ), random( 10 ));
  }
  //Reset asteroids
  for (int i = 0; i < ASTEROIDS; i++) {
    asteroids[i] = new Ship( width, random( height ), sqrt(random(10)), enemyShipSpeed[(int) random(0,3)][0], enemyShipSpeed[(int) random(0, 3)][1], 1, (int) random(20, 50));
  }
  //Reset lifes
  upOnScreen = false;
  //Reset Bullets
  bullets = new ArrayList();
  //Reset stuff
  killedAsteroids = 0;
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