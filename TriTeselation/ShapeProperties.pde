public class ShapeProperties {
  private PVector position;
  private float scale = 20;
  private color fillColor = color(100);
  private PShape s;

  public ShapeProperties(PVector position, float scale, color fillColor) {
    //shapeMode(CENTER);
    this.position = position;
    this.scale = scale;
    this.fillColor = fillColor;
  }

  public ShapeProperties(PVector position, float scale, color fillColor, PShape shape) {
    //shapeMode(CENTER);
    this.position = position;
    this.scale = scale;
    this.fillColor = fillColor;
    this.s = shape;
  }

  public ShapeProperties(float x, float y, float scale, color fillColor, PShape shape) {
    //shapeMode(CENTER);
    this.position = new PVector(x, y);
    this.scale = scale;
    this.fillColor = fillColor;
    this.s = shape;
  }
  
  public ShapeProperties(float x, float y, float scale, PShape shape) {
    //shapeMode(CENTER);
    this.position = new PVector(x, y);
    this.scale = scale;
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

  public void setScale(float scale) {
    this.scale = scale;
  }

  public void flip() {
    scale *= -1;
  }

  public void setColor(color c) {
    fillColor = c;
  }

  public void run() {
    s.setStroke(3);
    s.setFill(fillColor);
    shape(s, position.x, position.y, abs(scale), scale);
  }
}