class Rock {
  
  boolean isDebug = false;
  
  
  float radius;
  int rockLevel;
  PVector location;
  PVector velocity;
  ArrayList<Laser> lasers;
  float rotationSpeed;
  PImage rockImg;
  float scale;
  float rot;


  Rock(float radius, int x, int y, int rockLevel, ArrayList<Laser> lasers) {
    this.radius = radius;
    this.location = new PVector(x, y);
    this.rockLevel = rockLevel;
    this.lasers = lasers;

    float tempX = random(-rockLevel, rockLevel);
    float tempY = random(-rockLevel, rockLevel);
    
    rotationSpeed = random(-0.05, 0.05);
    rot = 0;
    rockImg = loadImage("RockAsteroid.png");

    velocity  = new PVector(tempX, tempY);
  }

  //this is the asteroid make function. can be replaced with other shapes as required
  void make() {
    pushMatrix();
    
    imageMode(CENTER);
    translate(location.x, location.y);
    rotate(rot+= rotationSpeed);
    rockImg.resize(((int)radius + 10) * 2, ((int)radius + 10) * 2);
    image(rockImg, 0,0); 
    popMatrix();
    if( isDebug){
     // fill(100);
      noFill();
      strokeWeight(2);
      stroke(255,0,0);
      ellipse(location.x, location.y, radius * 2, radius * 2);
    }
  }
  void display() {
    make();  // draw our asteroid
  }

  void update() {

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

  int hit() {
    // collision detection for the lasers. vs rocks
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

  PVector getPos() {
    return location;
  }

  float getRadius() {
    //println(radius);
    return radius;
  }

  int getRockLevel() {
    return rockLevel;
  }
  
  void setDebug(boolean state){
    isDebug = state;
  }
}