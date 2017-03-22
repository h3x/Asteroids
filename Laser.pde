class Laser {
  PVector position;
  PVector velocity;

  public Laser(float x, float y, float angle) {
    position = new PVector(x, y);
    //velocity = new PVector(0, -5);
    velocity = PVector.fromAngle(angle);
    velocity.setMag(12);
    this.velocity = velocity;
  }

  void display() {
    fill(30,127,30, 60);
    noStroke();
    ellipse(position.x, position.y, 20,20);
    stroke(255);
    strokeWeight(4);
    point(position.x, position.y);
  }

  void move() {
    position.add(velocity);
  }
  
  PVector getPos() {
    return position;
  }
  
 }