/**** GLOBALS ****/
import processing.opengl.*;
import toxi.processing.*;

void setup() {
  size(650, 650);
  background(30);
  frameRate(3);
  noStroke();
  generateCA();
}

void draw() {
}

void keyPressed() {
  pushStyle();
  fill(40);
  rect(0,0,width,height);
  popStyle();
  generateCA();
}
