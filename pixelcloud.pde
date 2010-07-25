import processing.opengl.*;

boolean toggleBackground = false;

PixelImage pixelImage;

SimpleTimer timer;

float rmouseX;
float rmouseY;

void setup() {
  size(785, 650, OPENGL); 
  colorMode(RGB, 255);
  
  timer = new SimpleTimer();

  PImage img = loadImage("scherr.jpg");
  pixelImage = new PixelImage(this, img, -img.width/2, -img.height/2, 0, 4);

}

void draw() {
  
  rmouseX = mouseX - width/2;
  rmouseY = mouseY - height/2;

  if (toggleBackground) {
    background(255);
  } else {
    fill(255, 10);
    rect(0, 0, width, height);
  }
  
  translate(width/2, height/2);
  pixelImage.draw();
}

void toggleBackground() {
  toggleBackground = !toggleBackground;
}

