class Asteroid {

  float radius;
  PVector location;
  PVector velocity;

  Asteroid(float radius, int x, int y) {
    this.radius = radius;
    this.location = new PVector(x, y);
    velocity  = new PVector(1,2);
  }
  
  //this is the asteroid make function. can be replaced with other shapes as required
  void make(){
    ellipse(location.x, location.y, radius * 2, radius * 2);
    
  }
  void display(){
    make();  // draw our asteroid
  }
  
  void update(){

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

}