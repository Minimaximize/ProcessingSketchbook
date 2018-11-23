/**
Interpolation of values at each corner of a
triangle across the triangles surface.
*/

PVector m;
PVector b;
PVector c;
PVector a = new PVector();

float _ESIZE = 10;
float _BSIZE = 5;

float vA = 0;
float vB = 100;
float vC = 250;

color cB = #00FF00;
color cC = #0000FF;
color cA = #FF0000;

void setup() {
  size(500, 500);
  m = new PVector();
  b = new PVector(400, 100);//random((width/2)-100, (width/2)+100), random((height/2)-100, (height/2)+100));
  c = new PVector(200, 400);//random(b.x-100, b.x+100), random(b.y-100, b.y+100));
  background(0);
  colorMode(HSB);
}

void draw() {
  background(0);
  for (int y = 0; y < height; y+=_BSIZE) {
    for (int x = 0; x < width; x+=_BSIZE) {
      m.set(x, y);

      PVector bc = PVector.sub(c, b);
      PVector bp = PVector.sub(m, b);

      if (!sameSide(b, c, m, a)||!sameSide(a, b, m, c)||!sameSide(a, c, m, b)) {
        continue;
      }

      float dotBC = bc.dot(bc);
      float dotBP = bc.dot(bp);

      float wBCP = dotBP/dotBC;

      bc.mult(wBCP);
      bc.add(b);

      PVector abc = PVector.sub(bc, a);
      PVector ap = PVector.sub(m, a);

      float dotABC = abc.dot(abc);
      float dotABCP = abc.dot(ap);

      float wABCP = dotABCP/dotABC;

      float value = lerp(vB, vC, wBCP);
      value = lerp(vA, value, wABCP);



      //ellipse(a, color(vA,255,255));
      //ellipse(b, color(vB,255,255));
      //ellipse(c, color(vC,255,255));
      ellipse(m, color(value, 255, 255));
    }
  }
}

void keyPressed(){
  if(key=='a') vA++;
  if(key=='A') vA--;
  if(key=='b') vB++;
  if(key=='B') vB--;
  if(key=='c') vC++;
  if(key=='C') vC--;
}

void ellipse(PVector p, color c) {
  ellipse(p, c, _ESIZE);
}

void ellipse(PVector p, color c, float w) {
  stroke(c);
  fill(c);
  ellipse(p.x, p.y, w, w);
}

void line(PVector start, PVector end, color c) {
  stroke(c);
  line(start.x, start.y, end.x, end.y);
}

void drawGuide() {
  //line(a, bc, #AAAAAA);
  line(a, b, #444444);
  line(a, c, #444444);
  //line(b,bc,cB);
  //line(c,bc,cC);
}

boolean sameSide(PVector origin, PVector end, PVector p1, PVector p2) {
  PVector bc = PVector.sub(end, origin);
  PVector bp = PVector.sub(p1, origin);
  PVector ba = PVector.sub(p2, origin);

  PVector bcXbp = bc.cross(bp);
  PVector bcXba = bc.cross(ba);

  if (PVector.dot(bcXbp, bcXba) >= 0) {
    return true;
  }
  return false;
}
