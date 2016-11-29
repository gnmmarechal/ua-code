import ddf.minim.*;
import java.util.*;
// para tocar file de som com biblioteca Minim
Minim minim;
AudioPlayer themeA, explosionBGM;

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
long gameLoopCounter = 0;
long tStart, tDelta;
String scoreFilePath = System.getProperty("user.dir") + "/score.dat";
int lives = 3;

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
  stroke(65,105,225);
  fill(65,105,225);
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
    if (key == ENTER) curScene = 1;
  }
  return;
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
    key = 0;
    gameLoopCounter = 0;
    lives = 3;
  }
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
void dynamicBackground()
{
  for ( int i = 0; i < STARS; i++) {
    strokeWeight( stars[i].z );
    stroke( stars[i].z * 25);
    fill(stars[i].z * 25);
    ellipse( stars[i].x, stars[i].y, 5, 5);
    stars[i].x = stars[i].x + stars[i].z;
    if (stars[i].x < 0) { 
      stars[i] = new Star( random( width ), random( height ), sqrt(random( 100 )));
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