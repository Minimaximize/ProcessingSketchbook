/**
* The Behaviour Class is a Superclass inherited by behaviours. 
* Behaviours are simple classes that extend the function of Game_Objects. 
*
* @author Liam James <liam@minimaximize.com>
* @version 0.2      11/02/2018
* @since 0.2        11/02/2018
* @see              Game_Object
*/
public class Behaviour{ 
  /**
  * Update function, used by Parent Object to update behaviour every frame
  */
  public void Update(){}
  
  /**
  * Late update function, occurs after all Updates have been completed
  */
  public void LateUpdate(){}
}

/**
* Behaviour used to render graphics for Parent object in the form of PShape or Vector
*
* @author Liam James <liam@minimaximize.com>
* @version 0.2      11/02/2018
* @since 0.2        11/02/2018
* @see              Behaviour
*/
class Renderer extends Behaviour{
  PShape Body;             /* Stores Graphic to be rendered */
  PVector offset;          /* Used to offset graphic from tarnsform */
  Transform transform;     /* Stores Position in space to render graphic */ 
  
/**
* Constructor. (For invocation by Parent Class)
*
* @param Body PShape graphic to be rendered to screen
* @param transform Transform of parent object. Used to render body at parent location.
*/
  public Renderer(PShape Body, Transform transform){
    this.Body = Body;
    this.transform = transform;
    offset = new PVector();
  }

/**
*  Called every frame by Parent object, used to draw Body to transform position relative to screen space
*/
  public void Update(){
    pushMatrix();
    translate(transform.position.x, transform.position.y);
    rotate(transform.rotation);
    shape(Body, offset.x, offset.y, transform.scale, transform.scale);
    popMatrix();
  }
}

/**
* Behaviour used to instantiate projectile object
*
* @author Liam James <liam@minimaximize.com>
* @version 0.2      11/02/2018
* @since 0.2        11/02/2018
* @see              Behaviour
*/
class Shoot extends Behaviour{
  Game_Object Projectile;
}