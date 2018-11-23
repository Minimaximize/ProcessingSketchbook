void setup(){
  size(510,51,P2D);
  PGraphics out = createGraphics(width,height,P2D);
  PImage line = new PImage(width,1);
  colorMode(HSB,360);
  for(int x = 0; x < width; x++){
    float h = map(x,0,width,230,0);
    color c = color(h,180,360);
   line.set(x,0,c);
  }
  out.beginDraw();
  for(int y = 0; y < height; y++){
    out.image(line,0,y);
  }
  out.endDraw();
  image(out,0,0);
  out.save("HSBline_halfSat.png");
  exit();
}
