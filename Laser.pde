/***********************************************************************************************************
 * Class:     Laser
 *
 * Authors:   Adam Austin
 *
 * Function:  Creates and controlls lasers being fired
 *             
 * Imports:   None
 *
 * Methods:   display() - Draws the laser
 *            move()    - Draws the laser in the new location
 *            getPos()  - Getter - returns the position of the laser
 *
 ************************************************************************************************************/


class Laser {
  PVector position;
  PVector velocity;

 /***********************************************************************************************************
 * Method:     Constructor
 *
 * Authors:    Adam Austin
 *
 * Function:   Create a new laser object
 *             
 * Parameters: x     - the x position of the nex laser
 *             y     - The y position of the new laser
 *             angle - The direction of travel of the new laser
 *
 * Notes:      The angle variable is determined by the heading of the ship at the time of creation
 *
 *
 ************************************************************************************************************/
 
  public Laser(float x, float y, float angle) {
    position = new PVector(x, y);
    velocity = PVector.fromAngle(angle);
    velocity.setMag(12); // Velocity for all laser obects is magnitute 12
  }

 /***********************************************************************************************************
 * Method:     display()
 *
 * Authors:    Adam Austin
 *
 * Function:   Draw laser object to the screen
 *             
 * Parameters: None
 *
 * Returns:    None
 *
 ************************************************************************************************************/
 
  void display() {
    fill(30,127,30, 60);
    noStroke();
    ellipse(position.x, position.y, 20,20);
    stroke(255);
    strokeWeight(4);
    point(position.x, position.y);
  }

 /***********************************************************************************************************
 * Method:     move()
 *
 * Authors:    Adam Austin
 *
 * Function:   update the posistion of the object, according to velocity
 *             
 * Parameters: None
 *
 * Returns:    None
 *
 ************************************************************************************************************/
 
  void move() {
    position.add(velocity);
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
 * Returns:    position
 *
 ************************************************************************************************************/
  
  PVector getPos() {
    return position;
  }
  
 }