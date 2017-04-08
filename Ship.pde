class Ship {
  
  //debug
  boolean isSound = true;
  boolean isDebug = false;
  
  
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
  
  void displayDamage() {
    textSize(32);
    fill(127);
    text("Damage: " + damage + "%", 200, 40);
  }

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
    //location.x = mouseX;
    //location.y = mouseY;
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


  //draws the ship, can be replaced later without disrupting any other functions
  void make() {
    
    stroke(200);
    strokeWeight(1);

    //controls blink speed of the warp nacelles
    if (frameCount % 4 == 0) {
      col = map(sin(frameCount), -1, 1, 0, 127);
    }
    noStroke();

    //triangle(0, -40, -40, 40, 40, 40);
    imageMode(CENTER);

    shipImg.resize(200, 200);


    image(shipImg, 0, 0); 
    fill(255, 0, 0);

    //make the binking warp nacelles
    fill(200, 0, 0, col);
    ellipse(-28, 0, 10, 10);    
    ellipse(28, 0, 10, 10);

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
  
  int getDamage()
  {
    return damage;
  }

  void setScore(int points) {
    score = score + points;
  }
  
  void addDamage(int dam) {
    damage += dam;  
  }

  boolean crash() {
    //stroke(255);
    //strokeWeight(4);


    //point(20 + location.x ,40 + location.y ); //bottom right
    //point(-20 + location.x, 40 + location.y); //bottom left
    //point(20 + location.x, - 40 + location.y); //top right
    //point(-20 + location.x, -40 + location.y); //top left

    float tempX = -100;
    float tempY = -100;
    

    for (int i = rocks.size() -1; i >= 0; i--) {
      PVector rockPos = rocks.get(i).getPos();
      float rockRad = rocks.get(i).getRadius();


      if (rockPos.x > location.x - 20 && rockPos.x < location.x + 20) {
        tempX = rockPos.x;
      } else if (rockPos.x < location.x -20) {
        tempX = location.x - 20;
      } else {
        tempX = location.x + 20;
      }      

      if (rockPos.y > location.y -40 && rockPos.y < location.y + 40) {
        tempY = rockPos.y;
      } else if (rockPos.y < location.y -40) {
        tempY = location.y-40;
      } else {
        tempY = location.y + 40;

      }
      float d = sqrt(sq(tempX - rockPos.x) + sq(tempY - rockPos.y));
      if (d < rockRad) {
        
        //Destroy rocks if ship hits them
        if(hitRock == false)
        {
          addDamage(20);
          if(isSound){
            foomSound.trigger();
          }
          if (rocks.get(i).getRockLevel() > 1) { //level 1 is the lowest level of rocks. this avoids all sorts of nasty problems, some of which are * by 0 issues that plauge movement and col/detection
            addRocks(2, rocks.get(i).getRockLevel() - 1, rocks.get(i).getPos());
          }
          rocks.remove(i);
          
          undamageable = frameCount;
          hitRock = true;
        }
        
        //Make ship un-damageable momentarily after a rock is hit
        if(frameCount > undamageable + 100)
        {
          hitRock = false;
        }
        
        return true;
      }
      
    if(isDebug){
      strokeWeight(2);
      fill(255,0,0);
      stroke(255, 0, 0);
      ellipse(tempX, tempY, 5, 5); 
      stroke(0,255,0);
      line(tempX, tempY, rockPos.x, rockPos.y);
      stroke(0,0,255);
      noFill();
      rect(location.x - 20, location.y - 40, 40, 80); 
    }  
  }

  

    return  false;
  }
  
  //debug options
  void setSound(){
    isSound = !isSound;
  }
  
  void setDebug(boolean state){
   isDebug = state; 
  }
  
}