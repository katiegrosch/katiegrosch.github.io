// Instead of a bunch of floats, we now just have two PVector variables.
PVector location;
PVector velocity;

Point[] pointlist;

class Point {
  public int x, y;
  public Point(int x_, int y_) { x = x_; y = y_; }
}

void setup() {
  size(200,200);
  smooth();
  background(255);
  location = new PVector(100,100);
  velocity = new PVector(1,1);
  pointlist[0] = new Point(10, 10);
  pointlist[1] = new Point(100, 100);
}

void draw() {
  noStroke();
  fill(255,10);
  rect(0,0,width,height);
  
  // Add the current speed to the location.
  location.add(velocity);

  // We still sometimes need to refer to the individual components of a PVector 
  // and can do so using the dot syntax (location.x, velocity.y, etc.)
  if ((location.x < pointlist[0].x) || (location.x > pointlist[1].x)) {
    velocity.x = velocity.x * -1;
  }
  if ((location.y < pointlist[0].y) || (location.y > pointlist[1].y)) {
    velocity.y = velocity.y * -1;
  }

  // Display circle at x location
  stroke(0);
  fill(175);
  ellipse(location.x,location.y,16,16);
}