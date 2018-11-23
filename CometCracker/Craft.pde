/**
 * Player craft parent class. Object controlled by the player.
 * Uses rudimentary physics to control in space.
 *
 * @author Liam James <liam@minimaximize.com>
 * @version 0.2      11/02/2018
 * @since 0.2        11/02/2018
 * @see              Game_Object
 */
public class Player extends Game_Object{
  PhysicsObject RB;      /* Rigid Body Behaviour */
  Renderer renderer;     /* Renderer behaviour */
  PShape Body;           /* Pshape for renderer */ 

  /**
  * Standard Constructor for the player object.
  */
  public Player() {
    super();
    Body = createShape(TRIANGLE, -10, -10, 30, 0, -10, 10);
    RB = new PhysicsObject(transform);
    renderer = new Renderer(Body, transform);
    Behaviours.add(RB);
    Behaviours.add(renderer);
  }
  
  /**
  * Constructor for the player object.
  * Player position is set to the x, y coord input into the constructor
  *
  * @param x sets Transform Position x on creation
  * @param y sets Transform Position y on creation
  */
  public Player(float x, float y) {
    super(x,y);
    Body = createShape(TRIANGLE, -10, -10, 30, 0, -10, 10);
    RB = new PhysicsObject(transform);
    renderer = new Renderer(Body, transform);
    Behaviours.add(RB);
    Behaviours.add(renderer);
  }
  
    /**
  * Constructor for the player object.
  * Player position is set to the x, y coord input into the constructor
  *
  * @param x sets Transform Position x on creation
  * @param y sets Transform Position y on creation
  */
  public Player(float x, float y, float scale) {
    super(x,y);
    super.transform.scale = scale;
    Body = createShape(TRIANGLE, -10, -10, 30, 0, -10, 10);
    RB = new PhysicsObject(transform);
    renderer = new Renderer(Body, transform);
    Behaviours.add(RB);
    Behaviours.add(renderer);
  }
  
  /**
  * Allows inputs to add accelleration forces to player object along the player heading
  * (Depreciated)
  *
  * @param v Velocity value to be added to player accelleration
  */
  void updateAccelleration(float v) {
    RB.Accelleration.add(PVector.fromAngle(transform.rotation).setMag(v));
  }
  
  
  /**
  * Allows inputs to rotate player by certain degrees
  *
  * @param degrees the amount of rotation per frame in degrees
  */
  void rotation(float degrees){
    transform.rotation += degrees*(PI/180);
  }
  
  Projectile fireProjectile(){
    return new Projectile(transform, RB.Velocity, 10);
  }
}