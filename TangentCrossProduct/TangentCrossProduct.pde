/**
Search optimisation to determine which points
are on the same side of the centerpoint and the
mouse.
*/
ArrayList<PVector> points;
PVector Target;
PVector Mouse;
PVector MT;
PVector Tangent;

void setup(){
  size(500,500);
  
  Target = new PVector(width/2,height/2);
  Mouse = new PVector();
  Tangent = new PVector();
  MT = new PVector();
  
  points = new ArrayList<PVector>();
  for(int i =0; i < 20; i++){
    points.add(new PVector(random(0,width),random(0,height)));
  }
}

void draw(){
  background(0);
  Mouse.set(mouseX,mouseY);
  PVector.sub(Target,Mouse,MT);
  Tangent.set(MT.y,-MT.x);
  line(Mouse, PVector.add(Tangent,Mouse));
  
  fill(#00FF00);
  stroke(#00FF00);
  ellipse(Target,10);
  
  for(int i = 0; i < points.size(); i++){
    color result = sameSide(points.get(i))?#0000FF: #FF0000;
    fill(result);
    stroke(result);
    ellipse(points.get(i),5);
  }
  
  
}

void ellipse(PVector P,float size){
  ellipse(P.x,P.y,size,size);
}

void line(PVector S, PVector E){
  line(S.x,S.y,E.x,E.y);
}

boolean sameSide(PVector test){
  PVector md = PVector.sub(test,Mouse);
  
  PVector Cr1 = MT.cross(Tangent);
  PVector Cr2 = md.cross(Tangent);
  
  return PVector.dot(Cr1,Cr2) >= 0;
}
