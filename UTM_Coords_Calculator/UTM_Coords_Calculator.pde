import java.util.HashMap;


float zone = 56f;
HashMap<String, Double> Easting = new HashMap<String, Double>();
HashMap<String, Double> Northing = new HashMap<String, Double>();
ArrayList<PVector> coords = new ArrayList<PVector>();
String Origin = "TP3D-HTE-BB-01";

Table locations;

void setup() {
  size(500, 500, P2D);
  background(0);
  stroke(255);
  locations = loadTable("MonitoringSensorsLocations.csv", "header");

  // Save Values
  Double maxEast = 0d;
  String Eastmost = "";
  Double maxNorth = 0d;
  String Northmost = "";
  for (TableRow row : locations.rows()) {
    String SensorName = row.getString("SensorName");
    Double East = Double.valueOf(row.getString("Easting"));
    Double North = Double.valueOf(row.getString("Northing"));
    // Update Maximum
    if(East > maxEast){
      maxEast = East;
      Eastmost = SensorName;
    }
    if(North > maxNorth){
      maxNorth = North;
      Northmost = SensorName;
    }
    // Assign Sensor Values to tuple
    Easting.put(SensorName, East);
    Northing.put(SensorName, North);
  }
  
  println("Eastmost Sensor: "+Eastmost+ "\t Value " +maxEast);
  println("Northmost Sensor: "+Northmost+ "\t Value " +maxNorth);

  // Convert to PVectors
  Double EastOrigin = Easting.get(Origin);
  Double NorthOrigin = Northing.get(Origin);
   
  for(String Sensor: Easting.keySet()){
    
    Float EastDiff = (float)((Easting.get(Sensor) - EastOrigin));
    Float NorthDiff = (float)((Northing.get(Sensor)) - NorthOrigin);
    println("Distance Between sensor "+Sensor+" And "+Origin);
    println("East: "+EastDiff+"\tNorth: "+NorthDiff);
    PVector point = new PVector(EastDiff,NorthDiff);
    point.rotate(radians(48));
    coords.add(point);
  }
  
  
  
  for(PVector point:coords){
    //float x = map(point.x, -11,(float)(maxEast-EastOrigin),10,width-10);
    //float y = map(point.y,-40,0,10,height-10);
    point = point.mult(10);
    pushMatrix();
    translate(30,300);
    fill(
      (point.x==0?
      #FF0000:
      #FFFFFF)
    );
    ellipse(point.x,point.y,5,5);
    popMatrix();
  }
}

void draw() {
}

void printTuples() {
 
  
  for (String Key : Easting.keySet()) {
    println("====================\n"+Key);
    
    //double[] latlong = c.utm2LatLon("");
    //System.out.format(
    //  "%20s%20s\n%20.04f%20.04f\n", 
    //  "Easting", "Northing", Easting.get(Key), Northing.get(Key)
    //  );
  }
}
