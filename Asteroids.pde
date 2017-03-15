float steering = 0.1;

//creat ship object
Ship ship;

//create lasers array
ArrayList<Laser> lasers = new ArrayList<Laser>();


void setup() {
  ship = new Ship(width/2, height/2);
  size(800, 800);
}

void draw() {
  background(51);

  //lasers
  for (int i = lasers.size() - 1; i >=0; i--) {
    lasers.get(i).move();
    lasers.get(i).display();
    
  }

  ship.update();
  ship.dispay();
}


void keyPressed() {
  if (keyCode == UP) {
    ship.go(true);
  }

  if (keyCode == LEFT) {
    ship.steering(steering);
  }

  if (keyCode == RIGHT) {

    ship.steering(steering * -1);
  }

  //spacebar ascii code is 32
  if (keyCode == 32) {
    //make new laser at ship position, heading in direction ship is facing
    lasers.add(new Laser(ship.getPos().x, ship.getPos().y, ship.getAngle()));
  }
}

void keyReleased() {
  if (keyCode == UP) {
    ship.go(false);
  }

  if (keyCode == LEFT) {
    ship.steering(0);
  }

  if (keyCode == RIGHT) {

    ship.steering(0);
  }
}