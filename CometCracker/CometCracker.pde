// Global Variables
Player player; // Player Character
Game game;

// Settings
//void Settings(){}

// Executed before the first frame is drawn
void setup() {
  size(1000, 1000,P2D);
  pixelDensity(1);
  background(color(255));
  player = new Player(width/2, height/2, 50);
  game = Game.getInstance();
  game.addUpdatableObject(player);
}

// Execute every frame
void draw() {
  // Calculating elapsed time
  
  println(frameRate);
  // Player Controls
  if (keyPressed) {
    if (key == 'w') {
      player.updateAccelleration(.5* game.deltaTime());
    }
    if (key == 'a') {
      player.rotation(-5);
    }
    if (key == 'd') {
      player.rotation(5);
    }
    if(key == 'q'){
      game.addUpdatableObject(player.fireProjectile());
    }
  }else{
    player.RB.SetAccelleration(0,0);
  }

  //clear frame
  background(color(0));
  // Update Game Loop
  game.GameLoop(millis());
}