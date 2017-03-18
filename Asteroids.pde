/* creadits: Song used with permission from creator.
             original content creator: FoxSynergy
             http://opengameart.org/content/blue-space
*/

import processing.sound.*;

float steering = 0.1;

PImage backImg;
SoundFile mainTheme;

//creat ship object
Ship ship;

//create lasers array
ArrayList<Laser> lasers = new ArrayList<Laser>();


void setup() {
  ship = new Ship(width/2, height/2);
  ship.setScore(0); // initiallise score
  size(800, 800);
  
  
  backImg = loadImage("bg5.jpg");
  backImg.resize(height,width);
  
  mainTheme = new SoundFile(this, "BlueSpace.wav");
  mainTheme.play();
}

void draw() {
  background(backImg);

  //lasers
  for (int i = lasers.size() - 1; i >=0; i--) {
    lasers.get(i).move();
    lasers.get(i).display();
    
  }

  ship.update();
  ship.dispay();
  
  ship.displayScore();
  
  //this is for testing to make sure the score is going to work.
  if( frameCount % 120 == 0){
    ship.setScore(40);
  }
  
  
  
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