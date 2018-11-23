PVector first;
PVector second;
float mulFactor = 10;

Boolean randomize = true;

void setup(){
  size(300,300);
  background(0);
  
  
  first = randomize?new PVector(random(0,width),random(0,height)):new PVector(width,height);
}

void draw(){
  background(0);
  
  // Refresh Mouse Pos
  second = new PVector(mouseX,mouseY);
  
  // First Line is red
  stroke(#FF0000);
  line(0,0,first.x,first.y);
  
  // Second Line is Green
  stroke(#00FF00);
  line(0,0,second.x,second.y);
  
  float similarity = vectorSimilarity(first,second); 
  println("Similarity is: "+similarity);
  
  PVector index = PVector.mult(first,similarity);
  
  // Indexing Line is Blue (length of second along first)
  stroke(#0000FF);
  line(0,0,index.x,index.y);
  
  // points from second to Index
  stroke(#DDDDDD);
  line(second.x,second.y,index.x,index.y);
}

float vectorSimilarity(PVector Reference, PVector Target){
  return (PVector.dot(Reference,Target)/Reference.mag())/Reference.mag();
}
