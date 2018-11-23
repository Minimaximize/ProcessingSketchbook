/**
Testing a method for performing weighted
interpolation between 2 points.
*/
class Point {
  PVector pos;
  float val;
  float weight;

  public Point(PVector pos, float val, float weight) {
    this.pos = pos;
    this.val = val;
    this.weight = weight;
  }

  public void draw(float mul) {
    line(pos.x, pos.y, pos.x, pos.y+(val*mul));
  }
  
  public void drawLine(float lnheight){
  colorMode(HSB);
  stroke(color(val*150,255,255));
  line(pos.x, pos.y-lnheight,pos.x, pos.y+lnheight);
}

  public String toString() {
    return "Weight: "+weight+ " Val: " + val;
  }
}

public Point lerpPoint(Point a, Point b, float amt) {
  float wamt = lerp(a.weight, b.weight, amt);
  float vamt = lerp(a.val*a.weight, b.val*b.weight, amt);
  return new Point(PVector.lerp(a.pos, b.pos, amt), vamt/wamt, wamt);
}

public Point lerpPos(Point a, Point b, float amt) {
  float wamt = lerp(a.weight, b.weight, amt);
  float vamt = lerp(a.val, b.val, amt);
  PVector pos = PVector.lerp(a.pos, b.pos, amt);
  pos.x = lerp(a.pos.x*a.weight, b.pos.x*b.weight, amt);
  pos.x /= wamt;
  return new Point(pos, vamt, wamt);
}

public void pointGrad(Point p, float lnheight){
  colorMode(HSB);
  stroke(color(p.val*100,255,255));
  line(p.pos.x, p.pos.y-lnheight,p.pos.x, p.pos.y+lnheight);
}

Point a;
Point b;
int seg = 30;
float pow = 200;
String start = "%3.3f";
String mid = "%s, %3.3f";

void setup() {
  size(500, 500);
  a = new Point(
    new PVector(width/4, height/2), 
    0, 
    //random(-1,1), 
    2
    );

  b = new Point(
    new PVector((width/4)*3, height/2), 
    1, 
    //random(-1,1), 
    2
    );
  stroke(#003049);
  strokeWeight(2);
}

void draw() {
  background(#eae2b7);

  a.draw(pow);
  b.draw(pow);

  String out = String.format(start, a.val);
  //int seg = floor(a.pos.dist(b.pos));
  for (int i = 1; i < seg; i++) {
    float amt = (float)i/(float)seg;
    //Point c = lerpPoint(a,b,amt);
    Point c = lerpPos(a, b, amt);
    c.draw(pow);
    out = String.format(mid, out, (c.val));
  }
  out = String.format(mid, out, (b.val));
  println(out);
  noLoop();
}

void mouseReleased() {
  a.val = random(-1, 1);
  b.val = random(-1, 1);
  loop();
}

void keyPressed() {
  if (key == 'a') {
    a.weight ++;
  }
  if (key == 'A') {
    a.weight --;
  }
  if (key == 'b') {
    b.weight++;
  }
  if (key == 'B') {
    b.weight --;
  }
  println("\na = " + a);
  println("b = " + b);
  loop();
}
