/**
 * Game_Object class, used as the standard base class for all Game_Objects.
 *
 * @author Liam James <liam@minimaximize.com>
 * @version 0.2      11/02/2018
 * @since 0.2        11/02/2018
 */
class Game_Object {
  private boolean alive = true;                   /* Flag to store if the object should be updated */
  public Transform transform;                  /* Stores Position, Rotation and Scale */
  protected ArrayList<Behaviour> Behaviours;   /* Used to catalogue and run behavious belonging to the game object */
  
  /**
  * Standard Constructor for the Game Object class, to be called by the subclass
  * Set default values for Transform and initializes Behaviours Arraylist
  */
  public Game_Object() {
    transform = new Transform();
    Behaviours = new ArrayList<Behaviour>();
  }
  
  /**
  * Constructor for the Game Object class, to be called by the subclass.
  * Initialises Game object with position at x, y
  */
  public Game_Object(float X, float Y) {
    transform = new Transform(new PVector(X,Y));
    Behaviours = new ArrayList<Behaviour>();
  }
  
 /**
  * Constructor for the Game Object class, to be called by the subclass.
  * Initialises Game object with position at x, y
  */
  public Game_Object(float X, float Y, float scale) {
    transform = new Transform(new PVector(X,Y),0,scale);
    Behaviours = new ArrayList<Behaviour>();
  }
  
  /**
  * Setup method (depreciated) to be used on the first frame of the level to initialize behavious and values in subclasses
  */
  public void Setup(){
   //TODO: Implement Setup Method
  }
  
  /**
  * Update method, performed once per frame.
  * Runs the update method on all attached behavious in order of when they were added to the arraylist
  */
  public void Update(){
    for(Behaviour behaviour: Behaviours){
      behaviour.Update();
    }
    WrapTransform();
  }
  
  /**
  * Late Update method, performed once per frame after Update has been performed on all Game_Objects.
  * Runs the LateUpdate method on all attached behavious in order of when they were added to the arraylist
  */
  public void LateUpdate(){
    //TODO: Implement Late Update Method
  }
 
 /**
 * Simple Custom behaviour to cause objects to loop once they reach the edge of the screen
 */
  public void WrapTransform(){
    if (transform.position.x > width) {
      transform.position.x = 0;
    } else if (transform.position.x < 0) {
      transform.position.x = width;
    }
    if (transform.position.y > height) {
      transform.position.y = 0;
    } else if (transform.position.y < 0) {
      transform.position.y = height;
    }
  }
  
  public void destroy(){
    alive = false;
  }
  
  public boolean isAlive(){
    return alive;
  }
}


/**
 * Transform class, stores information on Position rotation and scale.
 * Utilised in Game_Object class as a way to store spatial information.
 *
 * @author Liam James <liam@minimaximize.com>
 * @version 0.2      11/02/2018
 * @since 0.2        11/02/2018
 */
class Transform{
  public PVector position;
  public float rotation = 0;
  public float scale = 1;
  
 /**
  * Default constructor for Transform object.
  */
  public Transform(){
    position = new PVector();
  }
  
 /**
  * Constructor for Transform object.
  * Initialises Transform with position at x, y location stored in Pvector
  *
  * @param position initial position of the transform
  */
   public Transform(PVector position){
    this.position = position;
  }
  
 /**
  * Constructor for Transform object.
  * Initialises Transform with position at x, y location stored in Pvector and with a rotation.
  *
  * @param position initial position of the transform
  * @param rotation initial rotation of the transform
  */
  public Transform(PVector position, float rotation){
    this.position = position;
    this.rotation = rotation;
  }
  
 /**
  * Constructor for Transform object.
  * Initialises Transform with position at x, y location stored in Pvector and with a rotation and scale.
  *
  * @param position initial position of the transform
  * @param rotation initial rotation of the transform
  * @param scale initial scale of the transform
  */
  public Transform(PVector position, float rotation, float scale){
    this.position = position;
    this.rotation = rotation;
    this.scale = scale;
  }
  
 /**
  *
  */
  public void setScale(float newScale){
    scale = newScale;
  }
}