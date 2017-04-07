/***********************************************************************************************************
 * Class:     Laser
 *
 * Authors:   Adam Austin
 *            Scott Nicol
 *
 * Function:  Creates and controls ship (player) object
 *             
 * Imports:   None
 *
 * Methods:   display()       - Draws the laser
 *            displayScore()  - Displays the curent score on the screen
 *            displayDamage() - Displays the current damage to the ship on the screen
 *            update()        - Update the position of the ship object
 *            go()            - Sets the goingUp boolean depending on the state of the UP arrow key press state
 *            steering()      - Sets the rotation depending on the state of the LEFT/RIGHT arrow key press state
 *            make()          - Used to build the ship object for on-screen display.
 *            crash()         - Collision detection for asteroid vs rock collisions
 *            getPos()        - Getter - returns the position of the ship
 *            getAngle()      - Getter - returns the heading of the ship in radians to any calling function or class
 *            getScore()      - Getter - returns the current score
 *            getDamage()     - Getter - returns the current damage incurred to the ship
 *            setScore()      - Setter - sets the score
 *            addDamage()     - Setter - adds new damage to existing damage
 *
 ************************************************************************************************************/

class Ship {
  PVector location;
  PVector velocity;
  PVector acceleration;
  PVector direction;

  boolean goingUp;
  boolean rotating;
  boolean hitRock = false;

  float angle;
  float steeringSpeed;
  float col;

  int score;
  int damage;
  int undamageable = 0;

  PImage shipImg;

  ArrayList<Rock> rocks;

  /***********************************************************************************************************
   * Method:     Constructor
   *
   * Authors:    Adam Austin
   *             
   *
   * Function:   Create a new ship object
   *             
   * Parameters: x          - the initial x position of the ship
   *             y          - The initial y position of the ship
   *             rocks      - a reference to the rocks ArrayList, used for collision detection
   *
   ************************************************************************************************************/

  Ship(int x, int y, ArrayList<Rock> rocks) {
    // i think the variables in this constructor speak for themselvs
    location = new PVector(x, y);
    velocity = new PVector(0, 0);
    acceleration = new PVector(0, 0);

    this.rocks = rocks;

    goingUp = false;
    rotating = false;

    steeringSpeed = 0;
    angle = 0;

    direction = PVector.fromAngle(angle - HALF_PI);

    score = 0;
    damage = 0;

    shipImg = loadImage("spaceship.png");
  }


  /***********************************************************************************************************
   * Method:     display()
   *
   * Authors:    Adam Austin
   *
   * Function:   Setup the logic so that make() draws the ship object to the screen in the right place, 
   *             facing the right way and the right size
   *             
   * Parameters: None
   *
   * Returns:    None
   *
   * Notes:      push and pop matrix functions are necassary due to translating the object around the screen.
   *             the image is always drawn at (0,0), and is the translate to the x and y position that really controls
   *             the moving around of the object. Without push and pop, all other translations occur _relative_ to each other
   *             creating a hot, sticky mess. Same goes for the rotation method.
   * 
   ************************************************************************************************************/

  void dispay() {
    // scaleFactor is used to scale the ship according to window size and png image size
    float scaleFactor = 0.5;

    //push and pop seperate the translate and rotate functions from the rest of the program
    pushMatrix();
    translate(location.x, location.y);
    rotate(angle);
    scale(scaleFactor);
    make();  // draw our ship
    popMatrix();
  }
  /***********************************************************************************************************
   * Method:     displayScore()
   *
   * Authors:    Scott Nicol
   *
   * Function:   Draw the player's score to the screen
   *             
   * Parameters: None
   *
   * Returns:    None
   *
   * 
   ************************************************************************************************************/
 
  void displayScore() {
    textSize(32);
    fill(127);
    text(score, 20, 40);
  }

  /***********************************************************************************************************
   * Method:     displayScore()
   *
   * Authors:    Scott Nicol
   *
   * Function:   Draw the player's current damage level to the screen
   *             
   * Parameters: None
   *
   * Returns:    None
   *
   * 
   ************************************************************************************************************/
   
  void displayDamage() {
    textSize(32);
    fill(127);
    text("Damage: " + damage + "%", 200, 40);
  }

 /***********************************************************************************************************
 * Method:     update()
 *
 * Authors:    Adam Austin
 *
 * Function:   update the posistion of the object, according to velocity
 *             
 * Parameters: None
 *
 * Returns:    None
 *
 * Notes:      If the ship object rolls off screen, it is imediatly moved just off-screen to the opposite side to allow for 
 *             a screen rollover effect.
 *             Rotates the ship according to which way it should be facing
 *             Either adds acceleration to the ship, or dampens the current velocity, depending if the up key is pressed             
 * 
 ************************************************************************************************************/  
 
  void update() {
    // this is just the screen wrap around effect.
    if (location.x > width) {
      location.x = 0;
    }
    if (location.x < 0) {
      location.x = width;
    }
    if (location.y > height) {
      location.y = 0;
    }
    if (location.y < 0) {
      location.y = height;
    }

    //resets the acceleration to 0 on each loop i.e, if not boosting forward, there is no additional 
    //acceleration to apply, just the remaining velocity is acting on the ship
    acceleration.mult(0);  
    angle += steeringSpeed;

    if (goingUp) {
      //if up arrow is pressed, this PVector figures what direction the ship is
      //facing and applies force in that direction before factoring in acceleration
      velocity.add(direction);
      acceleration.y -= 0.05;
    } else {
      // causes a speed dampening effect if not acceleration. keeps the ship under control
      // if not activly accelerating
      velocity.mult(0.99);
    }

    //make it so!
    velocity.add(acceleration); 
    velocity.limit(60); //limits the velocity as to not be able to exceed light speed
    location.add(velocity);
  }


 /***********************************************************************************************************
 * Method:     go()
 *
 * Authors:    Adam Austin
 *
 * Function:   called if the up key is pressed or released to switch the goingUp boolean
 *             
 * Parameters: go  - a boolean state if the up button is currently being pressed
 *
 * Returns:    None
 *
 * Notes:      Basically the ship _always_ has acceleration. Its just that sometimes that acceleration PVector happens to be 0             
 * 
 ************************************************************************************************************/  
 
  void go(boolean go) { 
    if ( go ) {
      goingUp = true;
    } else {
      goingUp = false;
    }
  }

 /***********************************************************************************************************
 * Method:     steering()
 *
 * Authors:    Adam Austin
 *
 * Function:   sets stearing direction and speed, as called by keyPressed function in main class
 *             
 * Parameters: dir  - The angle at which to steer toward
 *
 * Returns:    None
 *
 * Notes:      Basically the ship is _always_ rotating. Its just that sometimes that rotation is 0 radians relative to current heading             
 * 
 ************************************************************************************************************/  
 
  void steering(float dir) {
    steeringSpeed = dir;
    setDirection();
  }

 /***********************************************************************************************************
 * Method:     make()
 *
 * Authors:    Adam Austin
 *
 * Function:   Draw ship object to the screen
 *             
 * Parameters: None
 *
 * Returns:    None
 *
 * Notes:      Builds the ship object to be draw to the screen. Due to the nature of rescaling images, 
 *             magic numbers had to be used here to get the correct size for the ship.
 *             Same goes the the blink rate, size and position of the warp nacelles
 * 
 ************************************************************************************************************/

  void make() {

    stroke(200);
    strokeWeight(1);

    //controls blink speed of the warp nacelles
    if (frameCount % 4 == 0) {
      col = map(sin(frameCount), -1, 1, 0, 127);
    }
    noStroke();

    imageMode(CENTER);
    shipImg.resize(200, 200);
    
    image(shipImg, 0, 0); 
    fill(255, 0, 0);

    //make the binking warp nacelles
    fill(200, 0, 0, col);
    ellipse(-28, 0, 10, 10);    
    ellipse(28, 0, 10, 10);
  }
  
 /***********************************************************************************************************
 * Method:     crash()
 *
 * Authors:    Adam Austin
 *
 * Function:   Collision detection for the ship vs asteroid collisions
 *             
 * Parameters: None
 *
 * Returns:    boolean  - return true if a collsion has taken place, else false
 *
 * Notes:      The magic numbers used here are required so the detection zone coves the right part of the ship
 *             These had to be found using trial and error and using these cannot be avoided.
 *             The algorithm is complecated but basically it looks at where the center of the asteroid is,
 *               measures the distance from that point to the closest side of the hitbox, if that distance is closer than
 *               the radius of the asteroid, we've hit
 * 
 ************************************************************************************************************/
  boolean crash() {
    
    float tempX = -100;
    float tempY = -100;
    
      //for each asteroid on screen...
    for (int i = rocks.size() -1; i >= 0; i--) {
      PVector rockPos = rocks.get(i).getPos();
      float rockRad = rocks.get(i).getRadius();
      //check if the asteroid x coord is within the hit box's x range (is to the left of the right side, and right of the left side)
      if (rockPos.x > location.x - 20 && rockPos.x < location.x + 20) {
        //assign tempX to the center x co-ord of the asteroid
        tempX = rockPos.x;
      } else if (rockPos.x < location.x -20) { // or check if the asteroid center is left of the left edge
        tempX = location.x - 20;
      } else {
        tempX = location.x + 20; //so it must be to the right of the right edge
      }      
       
       //do the same algorithm fo the y co-ords
      if (rockPos.y > location.y -40 && rockPos.y < location.y + 40) {
        tempY = rockPos.y;
      } else if (rockPos.y < location.y -40) {
        tempY = location.y-40;
      } else {
        tempY = location.y + 40;
      }
      // let d be the pythogorised distance from the closest edge of the hitbox, to the center of the asteroid
      float d = sqrt(sq(tempX - rockPos.x) + sq(tempY - rockPos.y));
      
      // if that distance is less than the radius of the asteroid, we have collided
      if (d < rockRad) {

        //Destroy rocks if ship hits them
        if (hitRock == false)
        {
          addDamage(20);
          foomSound.trigger();
          
          if (rocks.get(i).getRockLevel() > 1) { //level 1 is the lowest level of rocks. this avoids all sorts of nasty problems, some of which are * by 0 issues that plauge movement and col/detection
            addRocks(2, rocks.get(i).getRockLevel() - 1, rocks.get(i).getPos());
          }
          rocks.remove(i);

          undamageable = frameCount;
          hitRock = true;
        }
        //Make ship un-damageable momentarily after a rock is hit
        if (frameCount > undamageable + 100)
        {
          hitRock = false;
        }
        return true;
      }
    } 
    return  false;
  }
  
  
 /***********************************************************************************************************
 * Method:     getPos()
 *
 * Authors:    Adam Austin
 *
 * Function:   getter for position PVector
 *             
 * Parameters: None
 *
 * Returns:    position of the ship 
 *
 ************************************************************************************************************/

  PVector getPos() {
    return location;
  }

 /***********************************************************************************************************
 * Method:     getAngle()
 *
 * Authors:    Adam Austin
 *
 * Function:   getter for the angle the ship is facing in radians
 *             
 * Parameters: None
 *
 * Returns:    float - the heading of the ship
 *
 ************************************************************************************************************/

  float getAngle() {
    return angle - HALF_PI;
  }


 /***********************************************************************************************************
 * Method:     setDirection()
 *
 * Authors:    Adam Austin
 *
 * Function:   used to adjust the direction of the ship when arrow keys are pressed
 *             
 * Parameters: None
 *
 * Returns:    None
 *
 ************************************************************************************************************/

  void setDirection() {
    direction = PVector.fromAngle(angle - HALF_PI);
  }


 /***********************************************************************************************************
 * Method:     getScore()
 *
 * Authors:    Scott Nicol
 *
 * Function:   getter for the player's score
 *             
 * Parameters: None
 *
 * Returns:    float - the current score
 *
 ************************************************************************************************************/
 
  float getScore() {
    return score;
  }


 /***********************************************************************************************************
 * Method:     getDamage()
 *
 * Authors:    Scott Nicol
 *
 * Function:   getter for the player's damage
 *             
 * Parameters: None
 *
 * Returns:    int - the current damage to the ship
 *
 ************************************************************************************************************/
  int getDamage()
  {
    return damage;
  }

 /***********************************************************************************************************
 * Method:     setScore()
 *
 * Authors:    Scott Nicol
 *
 * Function:   setter for the player's score
 *             
 * Parameters: None
 *
 * Returns:    None
 *
 ************************************************************************************************************/
  void setScore(int points) {
    score = score + points;
  }
  
 /***********************************************************************************************************
 * Method:     addDamage()
 *
 * Authors:    Scott Nicol
 *
 * Function:   setter for the player's damage
 *             
 * Parameters: None
 *
 * Returns:    None
 *
 ************************************************************************************************************/

  void addDamage(int dam) {
    damage += dam;
  }
}