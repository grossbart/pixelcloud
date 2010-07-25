/* Keyboard Events
------------------------------------------------ */

void keyPressed() {
  if (keyCode == UP) {
    pixelImage.increaseRipples();
  } else if (keyCode == DOWN) {
    pixelImage.decreaseRipples();
  } else if (key == '0') {
    pixelImage.reset();
  } else if (key == '1') {
    pixelImage.status(Status.DEFAULT);
  } else if (key == '2') {
    pixelImage.status(Status.FOLD);
  } else if (key == 'b') {
    toggleBackground();
  }
}

void mousePressed() {
  pixelImage.shoot();
}
