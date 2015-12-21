/* Art gallery problem with moving guards */

final int POINT_SIZE = 10;
final color POINT_COLOR = #FFB380;
final float HULL_SIZE = POINT_SIZE * 0.2;
final color HULL_STROKE = #809FFF;
final color HULL_FILL = #E6ECFF;

PVector[] pointlist;
PVector[][] guardlist;
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
  for (int i = 0; i < click_num; ++i) {
    PVector pt = pointlist[i];
    vertex(pt.x, pt.y);
  }
  endShape();
}

boolean endshape(PVector[] pointlist) {
  stroke(HULL_STROKE);
  strokeWeight(HULL_SIZE);
  boolean intersection = false;
  
  for (int i = 1; i < click_num - 2; i++) {
    PVector p1 = pointlist[click_num - 1];
    PVector q1 = pointlist[0];
    PVector p2 = pointlist[i];
    PVector q2 = pointlist[i + 1];
    int o1 = orientation(p1, q1, p2);
    int o2 = orientation(p1, q1, q2);
    int o3 = orientation(p2, q2, p1);
    int o4 = orientation(p2, q2, q1);
   
    if (o1 != o2 && o3 != o4) {
          intersection = true;
    }
  }
  
  if (!intersection) {
    fill(HULL_FILL);
    beginShape();
    for (int i = 0; i < click_num; ++i) {
      PVector pt = pointlist[i];
      vertex(pt.x, pt.y);
    }
    vertex(pointlist[0].x, pointlist[0].y);
    endShape(CLOSE);
    return true;
  }
  else {
    return false;
  }
}

int orientation(PVector p, PVector q, PVector r)
{
    int val = (int)((q.y - p.y) * (r.x - q.x) - (q.x - p.x) * (r.y - q.y));
    if (val == 0) return 0;
    return (val > 0)? 1: 2;
}

void setup() {
  frameRate(60);
  size(500, 500);
  background(100);
  smooth();
  
  pointlist = new PVector[100];
  guardlist = new PVector[100][2];
  guardslopes = new PVector[100];
  guardlocs = new PVector[100];
}
 
void draw() {
  background(255);
  noFill();
  rect(0,0,width-1,height-1);

  for (int i = 0; i < click_num; i++) {
    drawpoint(pointlist[i]);
    drawshape(pointlist);
  }
  if (!draw_shape){
    endshape(pointlist);
    for (int i = 0; i < click_num2; i++) {
      line(guardlist[i][0].x, guardlist[i][0].y, guardlist[i][1].x, guardlist[i][1].y);
      PVector start = guardlist[i][0];
      PVector end = guardlist[i][1];
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
    boolean intersection = false;
    
    for (int i = 0; i < click_num - 3; i++) {
      PVector p1 = pointlist[click_num - 2];
      PVector q1 = pointlist[click_num - 1];
      PVector p2 = pointlist[i];
      PVector q2 = pointlist[i + 1];
      int o1 = orientation(p1, q1, p2);
      int o2 = orientation(p1, q1, q2);
      int o3 = orientation(p2, q2, p1);
      int o4 = orientation(p2, q2, q1);
     
      if (o1 != o2 && o3 != o4) {
            intersection = true;
            print("found intersection");
      }
    }
    if (!intersection) {
      pointlist[click_num] = new PVector(mouseX, mouseY);
      click_num++;
    }
  }
  else if (first_point) {
    guardlist[click_num2][0] = new PVector(mouseX, mouseY);
    first_point = false;
  }
  else {
    guardlist[click_num2][1] = new PVector(mouseX, mouseY);
    
    PVector u = guardlist[click_num2][0];
    PVector v = guardlist[click_num2][1];
    guardslopes[click_num2] = new PVector(v.x-u.x, v.y-u.y);
    guardlocs[click_num2] = new PVector(mouseX, mouseY);
    click_num2++;
    first_point = true;
  }
}

void keyPressed() {
 switch (key) {
   case ' ':
     if (endshape(pointlist)) {
       draw_shape = false;
     }
     break;
 }
}