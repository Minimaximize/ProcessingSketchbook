/**
* Behaviour used to simulate simple physics on parent object's Transform
*
* @author Liam James <liam@minimaximize.com>
* @version 0.2      11/02/2018
* @since 0.2        11/02/2018
* @see              Behaviour
*/
class PhysicsObject extends Behaviour{
  Transform transform;      /* Parent Transform */
  PVector Velocity;         /* Current Velocity */
  PVector Accelleration;    /* Current Accelleration */
  float mass;               /* Objct mass in units */
  
  /**
  * Constructor (for invocation by parent class)
  *
  * @param Transform transform object from the parent class - to be updated during the update step
  */
  PhysicsObject(Transform transform){
    this.transform = transform;
    Velocity = new PVector();
    Accelleration = new PVector();
  }
  
  /**
  * Update method, used every frame by the parent class
  * Used to update current physics state and position of game objects
  * @see       Behaviour
  */
  void Update(){
    // Apply Friction Forces
    
    // Apply Accelleration force to Transform
    applyAccelleration();
    updatePosition();
  }
  
  /**
  * Helper method, used to add PVector velocity to parent object in relation to WorldSpace
  *
  * @param x additional velocity along the x axis relative to current heading
  * @param y additional velocity along the y axis relative to current heading
  */
  void addVelocity(float x, float y){
    Velocity.add(x,y);
  }
  
  /**
  * Helper method, used to add PVector velocity to parent object in relation to current heading
  *
  * @param newVel PVector representing additional velocity of new vector in relation to current heading
  */
  void addVelocity(PVector newVel){
    Velocity.add(newVel);
  }
  
  /**
  * Helper method, used to add PVector velocity to parent object in relation to current heading
  *
  * @param x accelleration along the x axis relative to current heading
  * @param y accelleration along the y axis relative to current heading
  */
  void addAccelleration(float x, float y){
    Accelleration.add(x,y);
  }
  
  /**
  * Helper method, used to add PVector velocity to parent object in relation to current heading
  *
  * @param newVel accelleration along the new vector, relative to current heading
  */
  void addAccelleration(PVector newVel){
    Accelleration.add(newVel);
  }
  
  /**
  * Helper method, used to set current accelleration of the parent object in relation to current heading
  *
  * @param x accelleration along the x axis relative to current heading
  * @param y accelleration along the y axis relative to current heading
  */
  void SetAccelleration(float x, float y){
    Accelleration.set(x,y);
  }
  
  /**
  * Helper method, used to update the position of the parent transform
  */
  private void updatePosition(){
    transform.position.add(Velocity);
  }
  
  /**
  * Helper method, used to add current accelleration forces to velocity
  */
  private void applyAccelleration(){
    Velocity.add(Accelleration);
  }
  
  private PVector getHeading(){
    return PVector.fromAngle(transform.rotation);
  }
}