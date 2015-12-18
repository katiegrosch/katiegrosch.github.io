/* Art gallery problem with moving guards */

final int POINT_SIZE = 10;
final color POINT_COLOR = #FFB380;
final float HULL_SIZE = POINT_SIZE * 0.2;
final color HULL_STROKE = #809FFF;
final color HULL_FILL = #E6ECFF;

PVector[] pointlist;
int click_num = 0;
boolean draw_shape = true;

void drawpoint(PVector pt) {
  stroke(POINT_COLOR);
  strokeWeight(POINT_SIZE);
  point(pt.x, pt.y);
}

void drawshape(PVector[] pointlist) {
  stroke(HULL_STROKE);
  strokeWeight(HULL_SIZE);
 
  beginShape();
  fill(HULL_FILL);
  for (int i = 0; i < click_num; ++i) {
    PVector pt = pointlist[i];
    vertex(pt.x, pt.y);
  }
  endShape(CLOSE);
}

void setup() {
  size(500, 500);
  background(100);
  smooth();
  
  pointlist = new PVector[100];
}
 
void draw() {
  rect(0,0,width,height);
  background(255);

  for (int i = 0; i < click_num; i++) {
    drawpoint(pointlist[i]);
    drawshape(pointlist);
  }
}
 
void mousePressed() {
  if (draw_shape) {
    pointlist[click_num] = new PVector(mouseX, mouseY);
    click_num++;
  }
}

void keyPressed() {
 switch (key) {
   case ' ':
     draw_shape = false;
     break;
 }
}