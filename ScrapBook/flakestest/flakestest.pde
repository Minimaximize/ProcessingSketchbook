import processing.pdf.*;
PGraphics pg;

void setup(){
  pg = createGraphics(800,800, PDF, "output.pdf");
  ellipseMode(CENTER);
  
}

void draw(){
  stroke(#ffffff);
  int maxSize = 10;
  int minSize = 1;
  int mwidth = 5;
  int mheight = 20;
  int half_step = floor((pg.width/mwidth)/2);
  pg.beginDraw();
 for(int y = 0; y<mheight;y++){
  for(int x =0;x<mwidth; x++){
    int xpos = floor(map(x,0 , mwidth, maxSize/2, pg.width-(maxSize/2)));
    int ypos = floor(map(y,0 , mheight, maxSize/2, pg.height-(maxSize/2)));
    int size = floor(map(y, 0, mheight, maxSize,minSize));
    if(y%2==0){
      pg.ellipse(xpos+half_step,ypos,size,size);
    }else{
      pg.ellipse(xpos,ypos,size,size);
    }
  }
 }
 pg.dispose();
  pg.endDraw();
  //pg.save("out.png");
  exit();
}