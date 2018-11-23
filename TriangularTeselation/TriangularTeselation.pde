import processing.pdf.*; //<>// //<>//

String FILENAME = "TriTeselation";
int saveIndex = 0;

// Environment Variables
int DIMENSIONSX = 2000;
int DIMENSIONSY = 2000;

int OFFSETX = 0;
int OFFSETY = 0;
// Params

// Settings
public PShape tri, triFL;
public int PWIDTH = 20;
public int PHEIGHT = 20;
public color[] PCOL = {#FF2951,#FF29BF,#C529FF,#29A4FF,#29FAFF,#29FFAF,};//#BEFF29,#FF9F29
public PImage reference;

//Private Variables
private ArrayList<ShapeProperties> triList;

void settings() {
  size(DIMENSIONSX, DIMENSIONSY, P2D);
}

void setup() {
  background(0);
  smooth();
  //colorMode(HSB, 255);
  //Find save index for next file save
  while (loadImage(FILENAME+str(saveIndex)+".png")!=null) {
    saveIndex++;
  }
  //shapeMode(CENTER);
  tri = createShape();
  tri.beginShape(TRIANGLE);
  tri.noStroke();
  tri.vertex(0, 0);
  tri.vertex(2, 3);
  tri.vertex(4, 0);
  tri.endShape();

  triFL = createShape();
  triFL.beginShape(TRIANGLE);
  triFL.noStroke();
  triFL.vertex(0, 3);
  triFL.vertex(2, 0);
  triFL.vertex(4, 3);
  triFL.endShape();

  triList = DrawField();
  selectInput("Select a file to teselate: ", "loadFile");

  //colorElems(PCOL, .3);
  for (ShapeProperties sp : triList) {
    sp.run();
  }
}

void draw() {
  for (ShapeProperties sp : triList) {
    sp.run();
  }
  //noLoop();
  if (mousePressed) {
    save(FILENAME+str(saveIndex)+".png");
    saveIndex++;
  }
}


/**
 Returns an ArrayList containing triangles in a grid formation
 <p>
 Grid is (DIMENSIONSX/PWIDTH)*2+4 wide and
 (DIMENSIONSY/PHEIGHT)+2 High
 
 @return Arraylist of ShapeProperties objects
 */
ArrayList<ShapeProperties> DrawField() {
  ArrayList<ShapeProperties> retList = new ArrayList<ShapeProperties>();
  float scaleX = DIMENSIONSX/PWIDTH+.5;
  float scaleY = DIMENSIONSY/PHEIGHT+.5;
  for (int j = 0; j < PHEIGHT+2; j++) {
    for (int i = 0; i < PWIDTH+2; i++) {
      float py = map(j, 0, PHEIGHT+2, -scaleX, DIMENSIONSY+scaleY);
      float px = map(i, 0, PWIDTH+2, -scaleX, DIMENSIONSX+scaleX);
      if (j%2==1) {
        px += scaleX/2;
      }
      ShapeProperties first, second;
      first = new ShapeProperties(px+OFFSETX, py+OFFSETY, scaleX, scaleY, tri);
      second = new ShapeProperties(px+scaleX/2+OFFSETX, py+OFFSETY, scaleX, scaleY, triFL);
      retList.add(first);
      retList.add(second);
    }
  }
  return retList;
}


/**
 Two Colour Gradient
 Colours grid as a gradient between colours c1 and c2 (from top to bottom)
 with a weighted chance of sampling a colour offset% higher or lower
 than the current gradient position.
 
 @param c1 First colour to sample (will be the top of the image)
 @param c2 Second colour to sample (will be the bottom of the image)
 @param offset value between 0 and 1 which determines the delta of randomness when sampling the colour gradient
 */
void colorElems(color c1, color c2, float offset) {
  loop();
  for (int i=0; i<triList.size(); i++) {
    float degree = generateDegree(i, offset, triList.size(), true);
    color c = lerpColor(c1, c2, degree);
    triList.get(i).setColor(c);
  }
}

/**
 Three Colour Gradient
 Colours grid as a gradient between colours c1 and c2 (from left to right) and C3 (from top to bottom)
 with a weighted chance of sampling a colour offset% higher or lower
 than the current gradient position.
 
 @param c1 First colour to sample (will be the top left of the image)
 @param c2 Second colour to sample (will be the top right of the image)
 @param c2 Second colour to sample (will be the bottom of the image)
 @param offset value between 0 and 1 which determines the delta of randomness when sampling the colour gradient
 */
void colorElems(color c1, color c2, color c3, float offset) {
  loop();
  int gWidth = (PWIDTH*2+4);// can be calculated by doubleing PWIDTH (as 2 tris are drawn at a time) + 4 to account for the boarder
  int gHeight = PHEIGHT+2;
  offset =offset/3;
  for (int i=0; i<triList.size(); i++) {
    // Get linear gradient for width
    int iWidth = i%gWidth; // clamp i between 0 and grid width.
    float degree = generateDegree(iWidth, offset, gWidth, true); 
    color c = lerpColor(c1, c2, degree);
    // Get linear gradient for height
    int iHeight = (int)map(i, 0, triList.size(), 0, gHeight);// map i to a height value
    degree = generateDegree(iHeight, offset, gHeight, true);
    c = lerpColor(c, c3, degree);
    triList.get(i).setColor(c);
  }
}

/**
 multi colour gradient
 Colours the grid from left to right, sampling from an array of colours
 
 @param col array of colour values to be sampled (from left to right)
 @param offset value between 0 and 1 which determines the delta of randomness when sampling the colour gradient
 */
void colorElems(color[] col, float offset) {
  loop();
  int gWidth = (PWIDTH*2+4);// can be calculated by doubleing PWIDTH (as 2 tris are drawn at a time) + 4 to account for the boarder
  float elemRange = gWidth/(col.length-1); // the width of each element band
  for (int i=0; i<triList.size(); i++) {
    // Get linear gradient for width
    int iWidth = i%gWidth; // clamp i between 0 and grid width.
    // Create colour selection based on the position of the index mapped the the width of col[] -1
    float degree = generateDegree(iWidth, offset, gWidth, false);
    color c = col[0];
    for (int j = 0; j<col.length; j++) {
      //clamp diff between elemRange and 0
        float dif = degree-(elemRange*(j-1));
        float deg = generateDegree(dif, 0, elemRange, true);
        c = lerpColor(c, col[j], deg);
      triList.get(i).setColor(c);
    }
  }
}

void colorElems(PImage refImage) {
  loop();
  for (int i=0; i<triList.size(); i++) {
    int dimensions = refImage.width * refImage.height;
    int selection = (int)map(i, 0, triList.size(), 0, dimensions);
    color c = refImage.pixels[selection];
    triList.get(i).setColor(c);
  }
}

void sampleImage(PImage refImage) {
  loop();
  //find the minimum x and y values
  float minX = triList.get(0).getX(); // first element in the trilist array will be top left
  float minY = triList.get(0).getY();
  //find the maximum x and y values
  float maxX = triList.get(triList.size()-1).getX(); //last element of the triList array will be bottom right
  float maxY = triList.get(triList.size()-1).getY();
  for (ShapeProperties sp : triList) {
    int mx = (int)map(sp.getX(), minX, maxX, 0, refImage.width);
    int my = (int)map(sp.getY(), minY, maxY, 0, refImage.height);
    color c = refImage.get(mx, my);
    sp.setColor(c);
  }
}


void sampleImage(PImage refImage, int offset, float scramble) {
  loop();
  //find the minimum x and y values
  float minX = triList.get(0).getX(); // first element in the trilist array will be top left
  float minY = triList.get(0).getY();
  //find the maximum x and y values
  float maxX = triList.get(triList.size()-1).getX(); //last element of the triList array will be bottom right
  float maxY = triList.get(triList.size()-1).getY();
  for (ShapeProperties sp : triList) {
    int mx = (int)map(sp.getX(), minX, maxX, 0, refImage.width);
    int my = (int)map(sp.getY(), minY, maxY, 0, refImage.height);
    color c = refImage.get(mx, my);
    sp.setColor(c);
  }
  int total = ceil(triList.size()*scramble)/2;
  while (total>0) {
    int a = (int)random(triList.size()-1);
    int b = a+(int)random(-offset, offset);
    color temp;
    temp = triList.get(a).getColor();
    triList.get(a).setColor(triList.get(b).getColor());//swap colors at points A and B
    triList.get(b).setColor(temp);
    total--;
  }
}

float generateDegree(float i, float offset, float size, boolean normalize) {
  //generate random value
  offset = map(offset, 0, 1, 0, size);
  float degree = random(i-offset, i+offset);
  degree = degree<0?0:degree;// clamp value between 0 and max value
  degree = degree>size?size:degree;
  if (normalize) {
    degree = map(degree, 0, size, 0, 1);
  }
  return degree;
}

void loadFile(File path) {
  if (path == null) {
    println("Path failed to load");
  } else {
    println("File loaded from "+ path.getAbsolutePath());
    reference=loadImage(path.getAbsolutePath());
    sampleImage(reference, 8, 0.2);
  }
}

void saveImg() {
  int saveIndex = 0;
  while (loadImage(FILENAME+str(saveIndex)+".png")!=null) {
    saveIndex++;
  }
  save(FILENAME+str(saveIndex)+".png");
}
