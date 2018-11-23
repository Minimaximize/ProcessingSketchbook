/**
Testing a method for using barycentric 
weighting to determine if the mouse falls
within the triangle
*/

// PVectors
PVector a;
PVector b;
PVector c;
PVector p;

float _STROKE = 1;
float _ELLIPSE = 8;
color _INDICATOR = #000000;
boolean _VERBOSE = false;

// Setup - runs every frame
void setup() {
  size(500, 500);

  a = new PVector(random(0, width), random(0, height/2));
  b = new PVector(random(0, width/2), random(height/2, height));
  c = new PVector(random(width/2, width), random(height/2, height));
  p = new PVector();
}

void draw() {
  background(0);
  p.set(mouseX, mouseY);
  checkInBounds();
  showBounds(true);
  showPoints(true);
}

void showBounds(boolean show) {
  if (show) {
    fill(_INDICATOR);
    stroke(200);
    beginShape();
    vertex(a.array());
    vertex(b.array());
    vertex(c.array());
    endShape(CLOSE);
  }
}

void showPoints(boolean show) {
  if (show) {
    ellipse(a, _ELLIPSE, #FF0000);
    ellipse(b, _ELLIPSE, #00FF00);
    ellipse(c, _ELLIPSE, #0000FF);
  }
}

void checkInBounds() {
  // Setup Vectors
  PVector ap = PVector.sub(p, a);
  PVector ab = PVector.sub(b, a);
  PVector ac = PVector.sub(c, a);

  // Compute Dot Products
  float dotABB = PVector.dot(ab, ab);
  float dotABC = PVector.dot(ab, ac);
  float dotACC = PVector.dot(ac, ac);
  float dotABP = PVector.dot(ab, ap);
  float dotACP = PVector.dot(ac, ap);

  float invDenom = 1 / (dotACC*dotABB - dotABC*dotABC);
  float u = (dotABB*dotACP - dotABC*dotABP)*invDenom;
  float v = (dotACC*dotABP - dotABC*dotACP)*invDenom;

  if (_VERBOSE) {
    println(
    "---LINES--\n"+
    "\tab: "+ab+
    "\n\tac: "+ac+
    "\n\tap: "+ap+
    "\n--Dot Products--\n"+
    "\tdotABC: "+dotABC+
    "\tdotABP: "+dotABP+
    "\tdotACP: "+dotACP+
    "\n--OUTCOMES UV--\n"+
    "u: "+u+"\tv: "+v+"\tw: "+(1-(u+v))+
    "\n================="
    );
  }

  if(u >= 0 && v >= 0 && (u + v < 1)){
    _INDICATOR = #00FF00;
  }else{
    _INDICATOR = #000000;
  }
}


void checkInBoundsCross() {
  boolean ab = sameSide(a, b, c, p);
  boolean ac = sameSide(a, c, b, p);
  boolean cb = sameSide(c, b, a, p);

  if (_VERBOSE) {
    println("P is on the same side of ab as c: "+ab);
    println("P is on the same side of ac as b: "+ac);
    println("P is on the same side of cb as a: "+cb);
  }

  if (ab && ac && cb) {
    _INDICATOR = #00FF00;
  } else {
    _INDICATOR = #000000;
  }
}

boolean sameSide(PVector start, PVector end, PVector p1, PVector p2) {
  PVector se = PVector.sub(end, start);
  PVector sp1 = PVector.sub(p1, start);
  PVector sp2 = PVector.sub(p2, start);

  PVector Cr1 = sp1.cross(se);
  PVector Cr2 = sp2.cross(se);
  return PVector.dot(Cr1, Cr2) >= 0;
}

void mousePressed() {
  _VERBOSE = !_VERBOSE;
}

void line(PVector start, PVector end) {
  stroke(200);
  line(start.x, start.y, end.x, end.y);
}

void ellipse(PVector point, float size, color c) {
  strokeWeight(0);
  fill(c);
  ellipse(point.x, point.y, size, size);
  strokeWeight(_STROKE);
}

boolean between(float ref, float min, float max) {
  return ref >= min && ref <= max;
}
