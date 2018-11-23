class Vector2{
  public float x;
  public float y;
  
  public Vector2(){
    x=0;
    y=0;
  }
  
  public Vector2(float x, float y){
    this.x=x;
    this.y=y;
  }
   
public float distance(Vector2 compared){
    float deltaX = compared.x- x;
    float deltaY = compared.y- y;
    return sqrt(deltaX * deltaX + deltaY * deltaY);
}
  
  public float getMag(){
    return sqrt(x*x + y*y);
  }
  
  public Vector2 normalise(){
    float mag = getMag();
    float NormalX=x/mag;
    float NormalY=y/mag;
    return new Vector2(NormalX,NormalY);
  }
  
  public void add(Vector2 addVector){
    this.x += addVector.x;
    this.y += addVector.y;
  }
  
  public void setMag(float pow){
    this.x*=pow;
    this.y*=pow;
  }
}