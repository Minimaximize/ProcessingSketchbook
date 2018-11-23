public class ShapeProperties {
  private PVector position;
  private float scaleX = 20;
  private float scaleY = 20;
  private color fillColor = color(100);
  private PShape s;

  public ShapeProperties(PVector position, float scale, color fillColor) {
    //shapeMode(CENTER);
    this.position = position;
    this.scaleX = scale;
    this.fillColor = fillColor;
  }

  public ShapeProperties(PVector position, float scale, color fillColor, PShape shape) {
    //shapeMode(CENTER);
    this.position = position;
    this.scaleX = scale;
    this.fillColor = fillColor;
    this.s = shape;
  }

  public ShapeProperties(float x, float y, float scale, color fillColor, PShape shape) {
    //shapeMode(CENTER);
    this.position = new PVector(x, y);
    this.scaleX = scale;
    this.fillColor = fillColor;
    this.s = shape;
  }
  
  public ShapeProperties(float x, float y, float scaleX, float scaleY, PShape shape) {
    //shapeMode(CENTER);
    this.position = new PVector(x, y);
    this.scaleX = scaleX;
    this.scaleY = scaleY;
    this.s = shape;
  }

  public void setShape(PShape newShape) {
    s = newShape;
  }

  public void setPos(PVector newPos) {
    position = newPos;
  }

  public void setPos(float x, float y) {
    position.x = x;
    position.y = y;
  }
  
  public PVector getPos(){
    return position;
  }
  
  public float getX(){
    return position.x;
  }
  
  public float getY(){
    return position.y;
  }

  public void setScale(float scale) {
    this.scaleX = scale;
  }

  public void setColor(color c) {
    fillColor = c;
  }

  public color getColor(){
    return fillColor;
  }

  public void run() {
    s.setStroke(0);
    s.setFill(fillColor);
    shape(s, position.x, position.y, scaleX, scaleY);
  }
  
    public PGraphics record(PGraphics retG,int w, int h) {
    s.setStroke(0);
    s.setFill(fillColor);
    retG.shape(s, position.x, position.y, scaleX, scaleY);
    return retG;
  }
}