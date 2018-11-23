import java.util.List; //<>//
//Public Variables
public int DIMENSIONSX = 2000
  , DIMENSIONSY = 2000;
public PGraphics pg;

//settings
public int PWIDTH = 8;
public int PHEIGHT = 8;
public color[] PCOL = {color(47, 182, 47), color(255, 77, 77), color(128, 170, 255)};

//Private Variables
public PShape tri, triFL;
private ArrayList<ShapeProperties> triList;

/* Standard Methods */

// Settings for the sketch environment
void settings() {
  size(300, 300, P2D);
}

// Executes on the first frame of the sketch
void setup() {
  pg = createGraphics(DIMENSIONSX, DIMENSIONSY, P2D);
  background(0);
  //shapeMode(CENTER);
  tri = createShape(); //TRIANGLE,-1,0,0,1,1,0
  tri.beginShape(TRIANGLE);
  tri.noStroke();
  //tri.fill(200);
  tri.vertex(0, 0);
  tri.vertex(2, 3);
  tri.vertex(4, 0);
  //tri.vertex(-2, 0);
  tri.endShape();

  triFL = createShape();
  triFL.beginShape(TRIANGLE);
  triFL.noStroke();
  triFL.vertex(0, 3);
  triFL.vertex(2, 0);
  triFL.vertex(4, 3);
  //triFL.translate(2,0);
  //triFL.vertex(-2, 3);
  triFL.endShape();
  triList = new ArrayList<ShapeProperties>();
  pg.beginDraw();
  pg.background(PCOL[0]);
  DrawField2();
  pg.endDraw();
  int saveIndex = 0;
  PImage loadfile;
  do {
    saveIndex++;
    loadfile = loadImage("aesthetic"+str(saveIndex)+".png");
  } while (loadfile!=null);
  pg.save("aesthetic"+str(saveIndex)+".png");
}

// Executes every frame
void draw() {
}

void DrawField2() {
  float scaleW = DIMENSIONSX/PWIDTH/2;
  float scaleH = DIMENSIONSY/PHEIGHT/2;
  for (int j = 0; j< PHEIGHT*6; j++) {
    for (int i = 0; i < PWIDTH*6; i++) {
      //Initialise Settings
      float px = map(i, 0, PWIDTH, 0, DIMENSIONSX/4);
      float py = map(j, 0, PHEIGHT, 0, DIMENSIONSY/2);
      if (j%2!=0) {
        px-=scaleW/2;
      }
      color c = lerpColor(PCOL[0], PCOL[1], (float)(i/random(PWIDTH)/8));
      c = lerpColor(c, PCOL[2], (float)(j/random(PHEIGHT))/6);
      shapeMode(CENTER);
      tri.setFill(c);
      triFL.setFill(c);
      if (i%2==0) {
        pg.shape(tri, px, py, scaleW, scaleH);
      } else {
        pg.shape(triFL, px, py, scaleW, scaleH);
      }
    }
  }
}
void keyPressed() {
  int saveIndex = 0;
  PImage loadfile;
  do {
    saveIndex++;
    loadfile = loadImage("aesthetic"+str(saveIndex)+".png");
  } while (loadfile!=null);
  pg.save("aesthetic"+str(saveIndex)+".png");
}