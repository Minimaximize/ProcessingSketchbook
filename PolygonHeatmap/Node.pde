import java.util.*;
// Node Object - 
// Represents a point and reading in space
public class Node {
  boolean Debug = false;
  // Node Data
  private PVector pos;
  private float val;
  //private float slack = 5f;

  // Node Collection
  private List<Node> neighbours;
  //private List<Boolean> left;
  //private List<Boolean> above;

  // Constructor
  public Node(float value, float x, float y) {
    pos = new PVector(x, y);
    val = value;
    neighbours = new ArrayList<Node>();
  }

  // ----  Position
  public PVector getPosition() {
    return pos;
  }

  public void setPosition(PVector position) {
    pos = position;
  }

  // ---- Value
  public float getValue() { 
    return val;
  }

  public void setValue(float value) {
    val = value;
  }

  // ---- Neighbours
  public void addNeighbour(Node other) {
    neighbours.add(other);
    other.neighbours.add(this);
  }

  public void addNeighbours(Node...neighbour) {
    for (Node n : neighbour) {
      neighbours.add(n);
      n.neighbours.add(this);
    }
  }


  public Node[] getCommonNeighbours(Node other) {
    // Prepare output
    List<Node> out = new ArrayList<Node>();

    // Find common nodes between this object and other
    for (Node n : neighbours) {
      // For each connected Node
      if (other.neighbours.contains(n)) {
        // common node found
        out.add(n);
      }
    }

    // Return common neighbours as array
    return out.toArray(new Node[out.size()]);
  }

  // ---- 
  public Node getContainingPoint(Node other, PVector point) {
    // Get common neighbours
    Node[] common = getCommonNeighbours(other);

    // should have at least 1 common element
    assert(common.length > 0):
    common;

    // precalculate length of line between this(a) and other node(b)
    float ab = PVector.dist(this.pos, other.pos);

    // precalculate length of lines between a/b and point (p)
    float ap = PVector.dist(this.pos, point);
    float bp = PVector.dist(other.pos, point);

    // precalculate properties of point against the line made by ab
    //boolean isPointAbove = isAbove(other, point);

    // for each common Node
    for (Node n : common) {
      // Pass node n if on the opposite side of line ab
      //if (isAbove(other, n.pos) != isPointAbove) continue;

      // -- Area of Triange made of nodes
      // calculate length of lines from a and b to c
      float ac = PVector.dist(this.pos, n.pos);
      float bc = PVector.dist(other.pos, n.pos);

      // Calculate area of triangle a b c
      float areaNodes = getArea(ab, ac, bc);

      // -- Sum of triangles made betwen node pairs and point
      // calculate length of lines from c and point p
      float cp = PVector.dist(n.pos, point);

      // calculate sum of all triangles abp acp bcp
      float areaPoint = getArea(ab, bp, ap)
        + getArea(bc, bp, cp)
        + getArea(ac, ap, cp);

      // ==== Debug
      stroke(#0000ff);
      //line(pos.x, pos.y, point.x, point.y);
      //line(other.pos.x, other.pos.y, point.x, point.y);
      //line(n.pos.x, n.pos.y, point.x, point.y);

      // areaPoint is equal to areaNodes, point must fall within triange
      //println(areaPoint+" "+areaNodes);
      
      if (round(areaPoint)<=round(areaNodes)) {//(areaPoint < (areaNodes + slack) && areaPoint > (areaNodes - slack)) {
        return n;
      }
    }
    return null;
  }

  // Calculate value at point
  public float calculateValueAtPoint(Node one, Node two, PVector point) {
    // value at point should be validated at this stage.
    
    // Calculate reference point from A to Point
    PVector ref = PVector.sub(this.pos,point);
    
    // Find position where point falls along a line between this and node on
    float simAB = vectorSimilarity(PVector.sub(this.pos,one.pos),ref);
    PVector pointAB = PVector.lerp(this.pos, one.pos,simAB);
    
    // Find position where point falls along a line between this and node two
    float simAC = vectorSimilarity(PVector.sub(this.pos,two.pos),ref);
    PVector pointAC = PVector.lerp(this.pos, two.pos, simAC);
    
    ref = PVector.sub(pointAB, point);
    float simBC = one.vectorSimilarity(PVector.sub(pointAB,pointAC),ref);
    
    // Interpolate along 2 sides
    float vAB = lerp(this.val, one.val, simAB);
    float vAC = lerp(this.val, two.val, simAC);
    float out = lerp(vAB, vAC, simBC);
    
    // Debug
    if(Debug){
    println("Similarity AB: " + simAB+ 
          "\nSimilarity AC: " + simAC);
    }
    return out;
  }


  // ---- Resolve Position
  private boolean isAbove(Node ref, PVector target) {
    // gradient between this and other node
    float gradA = (pos.y-ref.pos.y)/(pos.x-ref.pos.x);

    // gradient between this and point
    float gradB = (pos.y-target.y)/(pos.x-target.x);

    // due to inverse nature of lines, gradient is reversed
    return (gradA>gradB);
  }

  float vectorSimilarity(PVector Reference, PVector Target) {
    return (PVector.dot(Reference, Target)/Reference.mag())/Reference.mag();
  }

  // ---- Heron's Formula
  private float getSValue(float a, float b, float c) {
    return (a+b+c)/2;
  }

  private float getArea(float a, float b, float c) {
    //float s = getSValue(a, b, c);
    //return sqrt(s*(s-a)*(s-b)*(s-c));

    return sqrt(
      ((a+(b+c))*(c-(a-b))*(c+(a-b))*(a+(b-c)))/4
      );
  }
}

// ------------------------------------------
