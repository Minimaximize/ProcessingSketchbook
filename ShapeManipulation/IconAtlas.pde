class IconAtlas {

  // HSB Colour Values
  private int gMin = 0;
  private int gMax = 230;

  ArrayList<Float> datapoints;

  PShape icon;
  PGraphics canvas;

  public IconAtlas(PShape icon, int scale) {
    this.icon = icon;
    datapoints = new ArrayList<Float>();
    icon.scale(scale);
    canvas = createGraphics((int)icon.width*scale, (int)icon.height*scale,P2D);
  }

  void saveIcons(String path){
    int fnumber = 0;
    for(float data:datapoints){
      canvas.beginDraw();
      icon.findChild("iconDisplay").setFill(colorFromFloat(data));
      canvas.shape(icon,0,0);
      canvas.endDraw();
      canvas.save(path+"_"+fnumber+".png");
      fnumber++;
    }
  }
  
  private color colorFromFloat(float val){
    int mappedSample = round(map(val, 0, 1, gMax, gMin));
    colorMode(HSB, 360);
    return color(mappedSample, 360, 360);
  }
}
