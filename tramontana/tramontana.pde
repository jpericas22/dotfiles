PImage heatmap;
Particle[] particles = new Particle[500];

void setup() {
  size(500, 500);
  heatmap = loadImage("data/heatmap.png");

  background(0);
  for (int i=0; i<particles.length; i++) {
    particles[i] = new Particle(int(random(0, 500)), int(random(0, 500)));
  }
};

void draw() {
  image(heatmap, 0, 0);
  for (int i=0; i<particles.length; i++) {
    particles[i].setDest();
    particles[i].updatePos();
    particles[i].draw();
  }
}

class Particle {

  float posX;
  float posY;

  int destX = -1;
  int destY = -1;

  int pointX = -1;
  int pointY = -1;

  float stepX = 0;
  float stepY = 0;

  Particle(int _posX, int _posY) {
    posX = _posX;
    posY = _posY;
  }

  void draw() {
    stroke(255, 0, 0);
    if (pointX != -1 && pointY != -1) {
      point(posX, posY);
    }
    stroke(0, 255, 0);
    point(destX, destY);
  }

  void setDest() {
    color point = color(0);
    if(red(heatmap.get(destX, destY)) != 255.0) {
      println(red(heatmap.get(destX, destY)));
      for (int y=0; y<500; y++) {
        for (int x=0; x<500; x++) {
          if (heatmap.get(x, y) == color(255)) {
            while (point == color(0)) {
              pointX = floor(random(0, 500));
              pointY = floor(random(0, 500));
              point = heatmap.get(pointX, pointY);
            }
            println(pointX + " / " + pointY);
            destX = pointX;
            destY = pointY;

            float diffX = (posX-destX);
            float diffY = (posY-destY);
            if (abs(diffX) > abs(diffY)) {
              println("CASE1");
              stepX = 1;
              stepY = abs(diffY/diffX);
            } else {
              println("CASE2");
              stepY = 1;
              stepX = abs(diffX/diffY);
            }

            return;
          }
        }
      }
      destX = -1;
      destY = -1;
    }

  }

  void updatePos() {
    println("x: "+posX + "/" +destX);
    println("y: "+posY + "/" +destY);
    if (posX < destX) {
      posX += stepX;
    }
    if (posX > destX) {
      posX -= stepX;
    }
    if (posY < destY) {
      posY += stepY;
    }
    if (posY > destY) {
      posY -= stepY;
    }
  }
}
