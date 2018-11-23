Node A, B, C; //<>// //<>// //<>// //<>//

// Run on first frame
void setup() {
  size(500, 500);
  colorMode(HSB, 360);

  A = new Node(0, 
    width/2, 10);

  //random(0, width), 
  //random(0, height));

  B = new Node(0, 
    50, height-30);

  //random(0, width), 
  //random(0, height));

  C = new Node(0, 
    width-30, height-30);

  //random(0, width), 
  //random(0, height));

  A.addNeighbours(B, C);
  B.addNeighbour(C);
  background(#ffffff);
}

// Run on each frame
void draw() {
  pixelDemo();
  //mouseDemo();
}

void pixelDemo() {
  background(0);
  
  A.setValue(0);
  B.setValue(0);
  C.setValue(0);
  
  A.setPosition(new PVector(0,0));
  B.setPosition(new PVector(0,0));
  C.setPosition(new PVector(0,0));
  
  PVector pa = A.getPosition();
  PVector pb = B.getPosition();
  PVector pc = A.getCommonNeighbours(B)[0].getPosition();


  for (int y = 0; y < height; y++) {
    for (int x = 0; x < width; x++) {
      // Refresh Cursor
      PVector cursor = new PVector(x, y);

      // Get enclosing point
      Node c = A.getContainingPoint(B, cursor);

      if (c != null) {
        // Perform calculation
        float v = A.calculateValueAtPoint(B, c, cursor);
        //float mappedV = map(v,0,1,0,180);

        color co = color(v, 360, 360);
        set(floor(cursor.x), floor(cursor.y), co);
      }
    }
  }

  stroke(#DDDDDD);
  line(pa.x, pa.y, pb.x, pb.y);
  line(pb.x, pb.y, pc.x, pc.y);
  line(pc.x, pc.y, pa.x, pa.y);
}

void mouseDemo() {
  background(#ff0000);
  PVector pa = A.getPosition();
  PVector pb = B.getPosition();
  PVector pc = A.getCommonNeighbours(B)[0].getPosition();

  PVector mousePos = new PVector(mouseX, mouseY);

  if (A.getContainingPoint(B, mousePos)!= null) {
    println(A.calculateValueAtPoint(B, C, mousePos));
  } else {
    //background(#ff0000);
  };

  stroke(#000000);
  line(pa.x, pa.y, pb.x, pb.y);
  line(pb.x, pb.y, pc.x, pc.y);
  line(pc.x, pc.y, pa.x, pa.y);
}

void keyPressed(){
  if(key=='a'){
    A.setValue(A.getValue()+1);
  }
  if(key=='z'){
    A.setValue(A.getValue()-1);
  }
  if(key=='s'){
    B.setValue(B.getValue()+1);
  }
  if(key=='x'){
    B.setValue(B.getValue()-1);
  }
  if(key=='d'){
    C.setValue(C.getValue()+1);
  }
  if(key=='c'){
    C.setValue(C.getValue()-1);
  }
}
