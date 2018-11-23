import processing.pdf.*;

void setup() {
  size(510, 510, P2D);
}


void draw() {
  PGraphics out = createGraphics(width, height, P2D);
    out.beginDraw();
    for (int R = 0; R < width; R++) {
      for (int G = 0; G < height; G++) {
        
        float r = map(R,0,width,0,255);
        float g = map(G,0,height, 0,255);
        color c = color(r, g, 0);
        out.set(R, G, c);
      }
    }
    out.endDraw();

    //beginRaw(PDF,"HSBtest.pdf");
    image(out, 0, 0);
    out.save("rgbImage_RG.png");
  //endRaw();
  exit();
}
