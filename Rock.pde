/***********************************************************************************************************
 * Class:     Rock
 *
 * Authors:   Adam Austin
 *            Tahlia Disisto
 *
 * Function:  Creates and controlls the asteroid rocks 
 *             
 * Imports:   None
 *
 * Methods:   make()        - Used to build the rock object for on-screen display.
 *            display()     - Alias for make in the case that multiply creation methods are used in future 
 *                            to keep consistancy and provide out of class saftey 
 *            update()      - Update the position of the rock object
 *            hit()         - Collision detection method
 *            getPos()      - getter - returns current position of the rock object
 *            getRadius()   - getter - returns the collision radius of the rock object
 *            getRockLevel()- getter - returns the level of the rock object
 *
 ************************************************************************************************************/


class Rock {
  
  float radius;
  int rockLevel;
  PVector location;
  PVector velocity;
  ArrayList<Laser> lasers;
  float rotationSpeed;
  PImage rockImg;
  float scale;
  float rot;

 /***********************************************************************************************************
 * Method:     Constructor
 *
 * Authors:    Adam Austin
 *             Tahlia Disisto
 *
 * Function:   Create a new rock object
 *             
 * Parameters: radius     - The radius of the object. Used for collision detection and object scaling
 *             x          - the x position of the new rock
 *             y          - The y position of the new rock
 *             rockLevel  - The level of the rock object. Used to determine size and spawn child rocks if destroyed
 *             lasers     - a reference to the lasers ArrayList, used for collision detection
 *
 * Notes:      tempX and tempY are temporary vars used purely for the randomisation of the direction and velocity of the rock 
 *             object when being created
 *
 ************************************************************************************************************/

  Rock(float radius, int x, int y, int rockLevel, ArrayList<Laser> lasers) {
    this.radius = radius;
    this.location = new PVector(x, y);
    this.rockLevel = rockLevel;
    this.lasers = lasers;

    float tempX = random(-rockLevel, rockLevel);
    float tempY = random(-rockLevel, rockLevel);
    
    rotationSpeed = random(-0.05, 0.05); // start the asteroid spinning in a random rotation and speed
    rot = 0;
    rockImg = loadImage("RockAsteroid.png");

    velocity  = new PVector(tempX, tempY);
  }

 /***********************************************************************************************************
 * Method:     make()
 *
 * Authors:    Adam Austin
 *
 * Function:   Draw rock object to the screen
 *             
 * Parameters: None
 *
 * Returns:    None
 *
 * Notes:      push and pop matrix functions are necassary due to translating the object around the screen.
 *             the image is always drawn at (0,0), and is the translate to the x and y position that really controlls
 *             the moving around of the object. Without push and pop, all other translations occur _relative_ to each other
 *             creating a hot, sticky mess. Same goes for the rotation method.
 * 
 ************************************************************************************************************/
  
  void make() {    
    pushMatrix();    
    imageMode(CENTER);
    translate(location.x, location.y);
    rotate(rot+= rotationSpeed);
    rockImg.resize(((int)radius + 10) * 2, ((int)radius + 10) * 2);
    image(rockImg, 0,0); 
    popMatrix();
  }
  
 /***********************************************************************************************************
 * Method:     display()
 *
 * Authors:    Tahlia Disisto
 *
 * Function:   Alias for make in the case that multiply creation methods are used in future 
 *             o keep consistancy and provide out of class saftey 
 *             
 * Parameters: None
 *
 * Returns:    None
 *
 * Notes:      push and pop matrix functions are necassary due to translating the object around the screen.
 *             the image is always drawn at (0,0), and is the translate to the x and y position that really controlls
 *             the moving around of the object. Without push and pop, all other translations occur _relative_ to each other
 *             creating a hot, sticky mess. Same goes for the rotation method.
 * 
 ************************************************************************************************************/  
  
  void display() {
    make();  // draw our asteroid
  }
  
  
 /***********************************************************************************************************
 * Method:     update()
 *
 * Authors:    Tahlia Disisto
 *
 * Function:   update the posistion of the object, according to velocity
 *             
 * Parameters: None
 *
 * Returns:    None
 *
 * Notes:      If the asteroid object rolls off screen, it is imediatly moved just off-screen to the opposite side to allow for 
 *             a screen rollover effect
 * 
 ************************************************************************************************************/  
  void update() {
  
    //screen rollover effect
    if (location.x > width + radius) {
      location.x = -radius;
    }
    if (location.x < -radius) {
      location.x = width + radius;
    }
    if (location.y > height + radius) {
      location.y = -radius;
    }
    if (location.y <  -radius) {
      location.y = height + radius;
    }

    location.add(velocity);
  }
  
 /***********************************************************************************************************
 * Method:     hit()
 *
 * Authors:    Adam Austin
 *
 * Function:   collision detection for the lasers. vs rocks
 *             
 * Parameters: None
 *
 * Returns:    Integer - Returns the level of the rock if a collision is detected, or -1 if no collision has occured
 *
 * Notes:      the collision algorithm works as follows:
 *              - grab the index of the last laser element
 *              - call the getPos() method for that laser object
 *              - compare the distance of the position of laser object to the position of the center of the rock object
 *              - if that distance is less than the radius of the asteroid, then a collsion must have occured
 *
 * 
 ************************************************************************************************************/  

  int hit() {
    for (int i = lasers.size() - 1; i >=0; i--) {
      //if lasers and rocks collide...
      if (dist(lasers.get(i).getPos().x, lasers.get(i).getPos().y, location.x, location.y) < radius) {
        //kill the laser
        lasers.remove(i);

        //kill the rock
        return rockLevel;
      }
    }
    return -1;
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
 * Returns:    position of the asteroid 
 *
 ************************************************************************************************************/
 
  PVector getPos() {
    return location;
  }
  
  
 /***********************************************************************************************************
 * Method:     getRadius()
 *
 * Authors:    Adam Austin
 *
 * Function:   getter for rock object radius
 *             
 * Parameters: None
 *
 * Returns:    float of the radius of the asteroid. Used for asteroid vs ship collision detection
 *
 ************************************************************************************************************/
  
  float getRadius() {
    return radius;
  }
  
  
 /***********************************************************************************************************
 * Method:     getRockLevel()
 *
 * Authors:    Adam Austin
 *
 * Function:   getter for rock level
 *             
 * Parameters: None
 *
 * Returns:    Integer of the level of the asteroid
 *
 ************************************************************************************************************/
  
  int getRockLevel() {
    return rockLevel;
  }
}