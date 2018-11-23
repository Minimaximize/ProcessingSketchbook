IconAtlas Tilt;
IconAtlas Vib;
IconAtlas Crack;

PShape tiltIcon;// = loadShape("TiltSensorIcon.svg");
PShape crackIcon;// = loadShape("CrackSensorIcon.svg");
PShape vibIcon;// = loadShape("VibSensorIcon.svg");

float[] points = 
  {
  0f, 
  0.5f, 
  0.1f, 
  0.15f, 
  0.2f, 
  0.25f, 
  0.3f, 
  0.35f, 
  0.4f, 
  0.45f, 
  0.5f, 
  0.55f, 
  0.6f, 
  0.65f, 
  0.7f, 
  0.75f, 
  0.8f, 
  0.85f, 
  0.9f, 
  0.95f, 
  1f, 
};

void setup() {
  size(64, 64, P2D);
  PShape tiltIcon = loadShape("TiltSensorIcon.svg");
  PShape crackIcon = loadShape("CrackSensorIcon.svg");
  PShape vibIcon = loadShape("VibSensorIcon.svg");
  Tilt = new IconAtlas(tiltIcon, 5);
  Vib = new IconAtlas(vibIcon, 5);
  Crack = new IconAtlas(crackIcon, 5);

  for (float point : points) {
    Tilt.datapoints.add(point);
    Vib.datapoints.add(point);
    Crack.datapoints.add(point);
  }

  Tilt.saveIcons("data/Tilt");
  Vib.saveIcons("data/Vib");
  Crack.saveIcons("data/Crack");
}
