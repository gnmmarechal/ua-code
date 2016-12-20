class Star {
  float x, y, z;
  Star( float x, float y, float z ) {
    this.x = x;
    this.y = y;
    this.z = z;
  }
}

class Bullet {
  float x, y;
  boolean exists;
  Bullet( float x, float y, boolean exists)
  {
    this.x = x;
    this.y = y;
    this.exists = exists;
  }
  void move()
  {
    x += bulletSpeed[0];
  }
  void display()
  {
    strokeWeight(5);
    stroke(0,255,0);
    fill(0,255,0);
    ellipse(x, y, 3, 3);
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

class Triangle {
  float point1x;
  float point1y;
  float point2x;
  float point2y;
  float point3x;
  float point3y;
  
  Triangle(float point1x,float point1y,float point2x,float point2y,float point3x,float point3y){
  this.point1x = point1x;
  this.point1y = point1y;
  this.point2x = point2x;
  this.point2y = point2y;
  this.point3x = point3x;
  this.point3y = point3y;        
  }
  
  void drawTriangle() {
    triangle(point1x, point1y, point2x, point2y, point3x, point3y);
  }
}