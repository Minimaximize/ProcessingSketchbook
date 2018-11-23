class Projectile extends Game_Object {
  private PhysicsObject RB;
  private Renderer renderer;
  private PShape body;
  private float lifetime = 3;

  public Projectile(float x, float y, PVector ShipVelocity, float scale) {
    super(x,y, scale);
    initialize(ShipVelocity);
  }
  
  public Projectile(Transform spawn, PVector ShipVelocity, float scale){
    super(spawn.position.x,spawn.position.y,scale);
    transform.rotation = spawn.rotation;
    initialize(ShipVelocity);
  }
  
  private void initialize(PVector ShipVelocity){
    body = createShape(ELLIPSE,-1,-1,4,4);
    RB = new PhysicsObject(transform);
    renderer = new Renderer(body,transform);
    RB.addVelocity(PVector.fromAngle(transform.rotation).setMag(10)); // Add accelleration along x axis
    RB.addVelocity(ShipVelocity);
    Behaviours.add(RB);
    Behaviours.add(renderer);
  }
  
  void Update(){
    super.Update();
    if(lifetime < 0){
      //destroy();
    }else{
      lifetime -= game.deltaTime();
    }
  }
}