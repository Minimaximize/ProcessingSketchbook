/**
Test to see if a point falls within 
an arbitrary quadrilateral
*/

PVector mouse;

PVector TL;
PVector BL;
PVector TR;
PVector BR;

PVector L;
PVector R;
PVector T;
PVector B;

color ctl = #000000;
color cbl = #0000FF;
color ctr = #00FF00;
color cbr = #FF0000;

PGraphics overlay;

float low;
float high;
float left;
float right;

void setup() {
  size(300, 300);
  TL = new PVector(random(0, width/2), random(0, height/2));
  BL = new PVector(random(0, width/2), random(height/2, height));
  TR = new PVector(random(width/2, width), random(0, height/2));
  BR = new PVector(random(width/2, width), random(height/2, height));

  L = new PVector();
  R = new PVector();
  T = new PVector();
  B = new PVector();

  ellipseMode(CENTER);
  background(0);
  mouse = new PVector(random(0,width),random(0,height));
  overlay = createGraphics(width,height);
  
  low = max(BL.y,BR.y);
  high = min(TL.y,TR.y);
  left = min(TL.x,BL.x);
  right = max(TR.x, BR.x);
}

void draw() {
  background(0);
  mouse.add(random(0,5),random(0,5));
  if(mouse.x > right){
    mouse.x = left;
  }
  if(mouse.y > low){
    mouse.y = high;
  }

  // Left and right bounds
  L.x = clamp(getRelativeX(TL, BL, mouse.y), TL.x, BL.x);
  L.y = clamp(mouse.y, TL.y, BL.y);

  R.x = clamp(getRelativeX(TR, BR, mouse.y), TR.x, BR.x);
  R.y = clamp(mouse.y, TR.y, BR.y);

  // Top and bottom bounds
  T.y = clamp(getRelativeY(TL, TR, mouse.x), TL.y, TR.y);
  T.x = clamp(mouse.x, TL.x, TR.x);

  B.y = clamp(getRelativeY(BL, BR, mouse.x), BL.y, BR.y);
  B.x = clamp(mouse.x, BL.x, BR.x);

  float vl = map(L.y, TL.y, BL.y, 0, 1);
  float vr = map(R.y, TR.y, BR.y, 0, 1);
  color cl = lerpColor(ctl, cbl, vl);
  color cr = lerpColor(ctr, cbr, vr);

  float dh = map(mouse.x, L.x, R.x, 0, 1);

  color c = lerpColor(cl, cr, dh);
  
  overlay.beginDraw();
  
  overlay.fill(c);
  overlay.noStroke();
  if (inBounds(mouse)) {
    ellipse(overlay,mouse, 5, c);
  }
  
  overlay.endDraw();
  image(overlay,0,0);
  
  drawBounds();
  drawEllipses();
  
  //set((int)mouse.x,(int)mouse.y,c);

  // Draw ellipses
  //ellipse(L, 5, cl);
  //ellipse(R,5, cr);

  //ellipse(T,5);
  //ellipse(B,5);
}

boolean inBounds(PVector p) {
  if (p.x != clamp(p.x, L.x, R.x)) {
    return false;
  }
  if (p.y != clamp(p.y, T.y, B.y)) {
    return false;
  }
  return true;
}

private float getRelativeX(PVector start, PVector end, float posY) {
  float dy = start.y - end.y;
  float py = (posY - end.y)/dy;

  return (py)*(start.x-end.x)+end.x;
}

private float getRelativeY(PVector start, PVector end, float posX) {
  float dx = start.x - end.x;
  float px = (posX - end.x)/dx;

  return (px)*(start.y-end.y)+end.y;
}

void line(PVector start, PVector end) {
  line(start.x, start.y, end.x, end.y);
}

void line(PGraphics layer, PVector start, PVector end) {
  layer.line(start.x, start.y, end.x, end.y);
}

void ellipse(PVector p, float size, color c) {
  fill(c);
  ellipse(p.x, p.y, size, size);
}

void ellipse(PGraphics layer, PVector p, float size, color c) {
  layer.fill(c);
  layer.ellipse(p.x, p.y, size, size);
}

void ellipse(PVector p, float size) {
  ellipse(p, size, color(#ffffff));
}

float clamp(float v, float bound1, float bound2) {
  float min = min(bound1, bound2);
  float max = max(bound1, bound2);
  return v > max? max : (v < min? min: v);
}

void drawGuides(PVector mouse) {
  // Draw Guides
  color c = (inBounds(mouse)?#00FF00:#FF0000);
  stroke(c);
  line(mouse, L);
  line(mouse, R);
  line(mouse, T);
  line(mouse, B);
}

void drawBounds() {
  // Draw Box
  stroke(255);
  line(TL, BL);
  line(BL, BR);
  line(BR, TR);
  line(TR, TL);
}

void drawEllipses() {
  // Draw ellipses
  ellipse(L, 5);
  ellipse(R, 5);
  ellipse(T, 5);
  ellipse(B, 5);
}

void drawEllipses(PGraphics layer, color cl, color cr, color ct, color cb) {
  // Draw ellipses
  ellipse(layer, L, 5, cl);
  ellipse(layer, R, 5, cr);
  ellipse(layer, T, 5, ct);
  ellipse(layer, B, 5, cb);
}

void mouseDragged(){
  mouse.set(mouseX,mouseY);
}
