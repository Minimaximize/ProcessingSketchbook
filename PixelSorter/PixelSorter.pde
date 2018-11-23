/**
Uses bubble sort to sort the pixels in an image.
This was originally going to be done in real time.
*/
//---Pixel Sorting---

// Settings
// Global Variables
PImage testImg;

void settings() {
  size(200, 200);
}

void setup() {
  selectInput("Select an image to sort pixels on", "loadInput");
  if (testImg!= null) {
    testImg.resize(width, height);
  }
  noLoop();
}

void draw() {
  if (testImg!=null) {
    //image(testImg, 0, 0);
  }
  //loadPixels();
  if (testImg != null) {
    pixels = SortPixels(testImg.pixels);
    
    //print(pixels[1]);
    image(testImg, 0, 0);
    noLoop();
  }
}

color[] SortPixels(color[] inPixels) {
  // perform a bubble sort to arrange the pixels in order of B,G,R
  int unsortedRange = inPixels.length;
  while (unsortedRange >=0) {
    for (int j = 0; j < 2; j++) {
      for (int i = 0; i<unsortedRange-1; i++) {
        if (inPixels[i]<=inPixels[i+1]) {
          color temp = inPixels[i+1];
          inPixels[i+1]= inPixels[i];
          inPixels[i]= temp;
        }
      }
    }
    unsortedRange--;
   // println("New range = "+ str(unsortedRange));
    // Assume the last value is sorted
  }
  println("Done");
  return inPixels;
}

color[] swapPixels(color[] inPixels, int i, int j) {
  //println("Swapping " + str(i) + " with " + str(j));
  color temp = inPixels[j];
  inPixels[j]=inPixels[i];
  inPixels[i]=temp;
  return inPixels;
}

void loadInput(File file) {
  if (file!=null) {
    testImg = loadImage(file.getAbsolutePath());
    testImg.resize(width, height);

    loop();
  }
}
