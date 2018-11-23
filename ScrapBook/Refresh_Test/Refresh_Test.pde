color ca = color(10,10,10,50);
//color cw = color(255,255,255);

static MyEllipse[] mElipse;
int currTime,prevTime;
float deltaTime=0;

void setup(){
  size(1000,1000,P2D);
  colorMode(HSB,255);
 background(0,0,0,.5);
 noStroke();
 mElipse = new MyEllipse[10];
 for(int i = 0; i< mElipse.length; i++){
   mElipse[i]= new MyEllipse(random(height),random(width),random(3,6),5,90,i);
 }
 currTime = prevTime = millis();
// mElipse = new MyEllipse(width/2, width/2, 5, 5);
}

void draw(){
  currTime = millis();
  deltaTime = (currTime - prevTime)/1000.0;
  prevTime = currTime;
  fill(ca);
  rect(0,0,width,height);
  for(MyEllipse m :mElipse){
    m.update();
  }
  //mElipse.update();
}