class Ship {
  PVector location;
  PVector velocity;
  PVector acceleration;
  PVector direction;

  boolean goingUp;
  boolean rotating;

  float angle;
  float steeringSpeed;
  float col;

  int score;

  PImage shipImg;

  ArrayList<Rock> rocks;

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

    shipImg = loadImage("spaceship.png");
  }

  void dispay() {


    //TODO: scaleFactor will be used to scale the ship according to window size
    // will be moved to the constructor at a later stage when class testing is complete    
    float scaleFactor = 0.5;

    //push and pop seperate the translate and rotate functions from the rest of the program
    //needed!! do not delete these!

    pushMatrix();
    translate(location.x, location.y);
    rotate(angle);
    scale(scaleFactor);
    make();  // draw our ship
    popMatrix();
  }

  void displayScore() {
    textSize(32);
    fill(127);
    text(score, 20, 40);
  }

  void update() {
    // this is just the screen wrap around effect.
    //TODO: fix this to grab the domensions of the ship image and apply screen wrap depending on scale

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
    // println(velocity); // for testing
  }

  //called if the up key is pressed or released
  void go(boolean go) { 
    if ( go ) {
      goingUp = true;
    } else {
      goingUp = false;
    }
  }

  //sets stearing direction and speed, as called by keyPressed function in main class
  void steering(float dir) {
    steeringSpeed = dir;
    setDirection();
  }

  void shoot() {
    /* TODO:
     
     this function will be used to add bullets to an ArrayList<PVector>.
     the bullets ArrayList will be used to keep track of each bullet's position, and direction as
     defined by the PVector.
     At a later stage, a destroy function will be created to delete bullets from the array if:
     * they leave the scope of the window
     * The hit an asteroid
     
     Note:
     when itterating through the ArrayList to decide which ones to remove, the for loop MUST run 
     backwards to avoid a warp core breach (lol). but seriously, itterate the destroy loop backwards
     due to how array lists work, when deleting an element from the list, the rest of the array is 
     shifted down 1 spot to the left. As a for loop is created, it assigns the number of itterations 
     at the instigation of the loop, so if it sees 10 bullets, then delets one, it will still try and 
     reach the 10th index, which no longer exists. This will result in a Null Pointer Exception, and 
     crash the game.
     
     p.s, the destroy loop will probably be in its own function, but the rule still applies.         
     Note 2: 
     i have implemented this in a seperate class. i tried to do this in a functional way, but its
     just too messy to do it that way. im leaving this here for now for now so everyone is on the same
     page but this whole thing should be removed before handing the assignment in
     */
  }


  //draws the triangle for the ship, can be replaced later without disrupting any other functions
  void make() {
    pushMatrix();
    stroke(200);
    strokeWeight(1);
    crash();
    //controls blink speed of the warp nacelles
    if (frameCount % 4 == 0) {
      col = map(sin(frameCount), -1, 1, 0, 127);
    }
    noStroke();
    fill(200, 0, 0, col);
    //triangle(0, -40, -40, 40, 40, 40);
    imageMode(CENTER);

    shipImg.resize(200, 200);


    image(shipImg, 0, 0); 
    rectMode(CENTER); //testing
    rect(0, 0, shipImg.width - 120, shipImg.height - 20); //testing
   
    //make the binking warp nacelles
    ellipse(-28, 0, 10, 10);    
    ellipse(28, 0, 10, 10);
    popMatrix();
  }

  //returns the position of the ship to any calling function or class
  PVector getPos() {
    return location;
  }

  //returns the heading of the ship in radians to any calling function or class
  float getAngle() {
    return angle - HALF_PI;
  }

  //sets the direction PVector variable depending on which way the shipo is currently heading.
  //direction is used in other places in this class and when creating the Laser objects
  void setDirection() {
    direction = PVector.fromAngle(angle - HALF_PI);
  }

  float getScore() {
    return score;
  }

  void setScore(int points) {
    score = score + points;
  }

  void crash() {
    pushMatrix();
    translate(location.x, location.y);
    rotate(getAngle());
    for (int i = rocks.size() - 1; i >= 0; i--) {
      float d = location.dist(rocks.get(i).getPos());
      float r = rocks.get(i).getRadius();
      PVector rockLoc = rocks.get(i).getLocation();
      
      
      //ship.location - rock.location < rock radius + ship width
      //TODO: this fucking thing!!!!!!!!!!!


    }
    popMatrix();
  }
}