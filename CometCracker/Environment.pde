/**
 * Environment class, architecture for all Game_Objects and behaviours as they appear in the game.
 *
 * @author Liam James <liam@minimaximize.com>
 * @version 0.2      11/02/2018
 * @since 0.2        11/02/2018
 */
static class Game {
  private static Game game;
  private ArrayList<Game_Object> SetupObject = new ArrayList<Game_Object>();
  private ArrayList<Game_Object> UpdatableObjects = new ArrayList<Game_Object>();
  private float deltaTime = 0; // Stores time elapsed since last frame
  private float prevTime = 0; // Used to calculate deltaTime
  
  
  // Maintains the Loop
  private boolean running = true;
  
/**
 * Standard Constructor for the game environment.
 * Initialised Setup Object and UpdatableObjects arraylists to be use once per frame in the GameLoop function
 */
  public Game() {
    SetupObject = new ArrayList<Game_Object>();
    UpdatableObjects = new ArrayList<Game_Object>();
  }
  
  static Game getInstance(){
    if(game == null){
      game = new Game();
    }
    return game;
  }
  
/**
 * Method for controlling the game loop.
 * 1. Starts by obtaining inputs
 * 2. Updates all objects in the UpdatableObjects ArrayList
 * Performed once per frame, it controls the current state of the game and can be switched between current play and paused.
 */
  public void GameLoop(float elapsedTime){
    // Set Delta Time
    deltaTime = elapsedTime/1000f-prevTime;
    prevTime = elapsedTime/1000f;
    if(running){
      // Handle User Input
      
      for (Game_Object go: UpdatableObjects){// Update Loop
        if(go.isAlive()){
          go.Update();
        }
      }
      // Handle Rendering
      
    }// End Running   
    //removeDeadObjects();
  }
  
 /**
 * Method for adding new Objects to the SetupObject queue
 *
 * @param go Game object to add to SetupObject arraylist
 */
  public void addSetupObject(Game_Object go){
    SetupObject.add(go);
  }
  
  private void removeDeadObjects(){
        for(int i = 0; i< UpdatableObjects.size();i++){
      if(!UpdatableObjects.get(i).isAlive()){
        // if Alive flag is false, remove object
         UpdatableObjects.remove(i);
         i--;
      }
    }
  }
/**
 * Method for adding new Objects to the UpdatableObjects arrayList
 * This controls all behaviours associated with a Game_Object and is performed once per frame.
 *
 * @param go Game object to add to UpdatableObjects arraylist
 */
  public void addUpdatableObject(Game_Object go){
    UpdatableObjects.add(go);
  }
  
  public float deltaTime(){
    return deltaTime;
  }
}