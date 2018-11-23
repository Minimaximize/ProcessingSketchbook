/**
 This sketch was designed to test out a theory on
 using Cosign Similarity to optimise the search
 for a polygon containing the mouse.
 
 The Cosign similarity of vectors from the
 origin (blue ellipse) to the mouse (om), and 
 from the origin to the scattered points (op) 
 is used to calculate a weighting of likelihood
 that the point could be used to create a triangle
 surrounding the mouse position.
 
 This was based on the assumption that at least
 one point has to be on the opposite side of the
 mouse position from the origin to form a triangle.
 */
PVector origin;
PVector mouse;
ArrayList<PVector> points;

void setup() {
  size(500, 500);
  origin = new PVector(width/2, height/2);
  mouse = new PVector();
  points = new ArrayList<PVector>();
  for (int i=0; i < 5; i++) {
    points.add(
      new PVector(random(0, width/2), random(0, height/2))
      );
  }
}

void draw() {
  background(0);
  mouse.set(mouseX, mouseY);
  PVector om = PVector.sub(mouse, origin);
  fill(#0000FF);
  ellipse(origin, 8);
  fill(255);
  for (PVector p : points) {
    PVector op = PVector.sub(p, origin);
    float size = PVector.dot(om, op)/(om.mag()*op.mag());
    ellipse(p, pow(5, (2*size)));
  }
}

void ellipse(PVector p, float scalar) {
  ellipse(p.x, p.y, scalar, scalar);
}
