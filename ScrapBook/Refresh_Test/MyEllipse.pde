class MyEllipse{
  
  private Vector2 position;
  private Vector2 velocity;
  
  private float speed=10;
  private float maxSpeed = 5;
  private float size;
  private int myC;
  private int index;
  
  //swarm forces
  private float repelDist = 2f;
  private float repelForce = 1;
  
  //Constructors
  MyEllipse(Vector2 position,float size,float speed,int index){
    velocity=new Vector2();
    this.speed = speed;
    this.size=random(size,size+2);
    this.position = position;
    this.index=index;
    myC = (int)random(255);
  }
  
  MyEllipse(float px,float py,float size,float speed,int index){
    velocity=new Vector2();
    this.speed = speed;
    this.size=random(size,size+2);
    this.position = new Vector2(px,py);
    this.index=index;
    myC = (int)random(255);
  }
  
    MyEllipse(float px,float py,float size,float speed, float maxSpeed,int index){
    velocity=new Vector2();
    this.speed = speed;
    this.size=random(size,size+2);
    this.position = new Vector2(px,py);
    this.index=index;
    myC = (int)random(255);
  }
  
  //Update method, call this once per frame
  void update(){
    //Update Colour
    myC = (myC + 1)%255;
    fill(color(359,myC,99));
    //Update heading as direction to target (mouse)
    Vector2 heading = new Vector2(mouseX-position.x,mouseY-position.y);
    heading = heading.normalise();//normalize heading and multiply by speed to obtain accelleration
    heading.setMag(speed*deltaTime);
    velocity.add(heading);
   
    //constrain magnitude to maximum speed
    if(velocity.getMag()> maxSpeed){
      velocity = velocity.normalise();
      velocity.setMag(maxSpeed);
    }
    
    //update position
    position.add(velocity);
    //drawShape
    ellipse(position.x,position.y,size,size);
  }
  
  //void cohesionForces(){
  //  for(int i = index; i< mElipse.length;i++){
  //    if(dist(mElipse[i+1])<repelDist){
        
  //    }
  //  }
  //}
  
}