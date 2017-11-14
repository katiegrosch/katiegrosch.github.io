/* Art gallery problem with moving guards */

final int POINT_SIZE = 10;
final color POINT_COLOR = #FFB380;
final float HULL_SIZE = POINT_SIZE * 0.2;
final color HULL_STROKE = #809FFF;
final color HULL_FILL = #E6ECFF;

PVector[] pointlist;
PShape[] guardlist;
PVector[] guardslopes;
PVector[] guardlocs;
int click_num = 0, click_num2 = 0;
boolean draw_shape = true, first_point = true;

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
  frameRate(60);
  size(500, 500);
  background(100);
  smooth();
  
  pointlist = new PVector[100];
  guardlist = new PShape[100];
  guardslopes = new PVector[100];
  guardlocs = new PVector[100];
}
 
void draw() {
  rect(0,0,width,height);
  background(255);

  for (int i = 0; i < click_num; i++) {
    drawpoint(pointlist[i]);
    drawshape(pointlist);
  }
  if (!draw_shape){
    for (int i = 0; i < click_num2; i++) {
      shape(guardlist[i]);
      PVector start = guardlist[i].getVertex(0);
      PVector end = guardlist[i].getVertex(1);
      PVector m = guardslopes[i];
      guardlocs[i].x += m.x/100;
      guardlocs[i].y += m.y/100;
      
      if (start.y < end.y) {
        if (guardlocs[i].y < start.y || guardlocs[i].y > end.y) {
          guardslopes[i].x *= -1;
          guardslopes[i].y *= -1;
        }
      }  
      if (start.y > end.y) {
        if (guardlocs[i].y > start.y || guardlocs[i].y < end.y) {
          guardslopes[i].x *= -1;
          guardslopes[i].y *= -1;
        }
      }
      ellipse(guardlocs[i].x, guardlocs[i].y, 10, 10);
    }
  }
}
 
void mousePressed() {
  if (draw_shape) {
    pointlist[click_num] = new PVector(mouseX, mouseY);
    click_num++;
  }
  else if (first_point) {
    guardlist[click_num2] = createShape();
    guardlist[click_num2].beginShape();
    guardlist[click_num2].vertex(0, 0);
    guardlist[click_num2].vertex(mouseX, mouseY);
    guardlist[click_num2].endShape();
    first_point = false;
  }
  else {
    guardlist[click_num2].setVertex(0, mouseX, mouseY);
    guardlist[click_num2].setVisible(true);
    
    PVector u = guardlist[click_num2].getVertex(0);
    PVector v = guardlist[click_num2].getVertex(1);
    guardslopes[click_num2] = new PVector(v.x-u.x, v.y-u.y);
    guardlocs[click_num2] = new PVector(mouseX, mouseY);
    click_num2++;
    first_point = true;
  }
}

void keyPressed() {
 switch (key) {
   case ' ':
     draw_shape = false;
     break;
 }
}