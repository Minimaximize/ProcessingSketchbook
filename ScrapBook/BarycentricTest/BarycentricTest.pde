PVector A;
PVector B;
PVector C;

PVector ab;
PVector ac;

void setup(){
  size(300,300);
  A = new PVector(0,0);
  ab = new PVector(0,0);
  ac = new PVector(0,0);
  //B = new PVector(0,height);//random(0,height)); 
  //C = new PVector(width,height);// random(0,height));
  B = new PVector(0,random(0,height)); 
  C = new PVector(width,random(0,height));
  ellipseMode(CENTER);
  
  println("Magsq = "+C.magSq()+" Dot(C,C) = "+PVector.dot(C,C));
  println(PVector.dot(C,C)*PVector.dot(B,B)-PVector.dot(C,B)*PVector.dot(C,B));
}

void draw(){
  background(#000000);
  triangle(A.x,A.y,B.x,B.y,C.x,C.y);
  ellipse(ab.x,ab.y,10,10);
  ellipse(ac.x,ac.y,10,10);
}

void mouseReleased(){
  PVector m = new PVector(mouseX,mouseY);
  float first = barycentricWeight(A,B,C,m);
  //println("Mouse: "+m);
  //println("approximate weight AB: " + first);
  //ab = PVector.lerp(B,A,first);
}

float barycentricWeight(PVector a, PVector b, PVector c, PVector t){
  PVector AB = PVector.sub(b,a);
  PVector AC = PVector.sub(c,a);
  PVector AT = PVector.sub(t,a);
  
  float d00 = PVector.dot(AB,AB);
  float d01 = PVector.dot(AB,AC);
  float d11 = PVector.dot(AC,AC);
  float d20 = PVector.dot(AT,AB);
  float d21 = PVector.dot(AT,AC);
  
  float denom = d00*d11 - d01*d01;
  float u = (d11*d20 - d01*d21)/denom;
  float v = (d00*d21 - d01*d20)/denom;
  float w = 1- u - v;
  println("U: "+u+" V: "+v+ " W:"+w );
  
  
  
  return w;
}

//float barycentricWeight(PVector A, PVector B, PVector C, PVector T){
//  PVector AB = PVector.sub(A,B);
//  PVector AC = PVector.sub(A,C);
//  PVector AT = PVector.sub(A,T);
//  float dABT = PVector.dot(AB,AT)/AB.magSq();
//  float dACT = PVector.dot(AC,AT)/AC.magSq();
  
//  ab = PVector.lerp(A,B,dABT);
//  ac = PVector.lerp(A,C,dACT);
  
//  println("dABT: "+dABT+" dACT: "+dACT);
//  return (dABT+dACT)/2;
//}
