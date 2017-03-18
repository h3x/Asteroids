/* creadits: Song used with permission from creator.
 original content creator: FoxSynergy
 http://opengameart.org/content/blue-space
 */

import ddf.minim.*;
Minim minim;
AudioPlayer mainTheme;
AudioSample shootSound;

float steering = 0.1;

PImage backImg;


//creat ship object
Ship ship;

//create an array list of rocks
ArrayList<Rock> rocks = new ArrayList<Rock>();

//create lasers array
ArrayList<Laser> lasers = new ArrayList<Laser>();

//Boolean to test if laser fired
boolean laserFired = false;

//Rock level decides how many times rocks should split
int rockLevel = 3;
int startingRocks = 5;

void setup() {
  ship = new Ship(width/2, height/2);
  ship.setScore(0); // initiallise score
  size(700, 700);

  addRocks(startingRocks, rockLevel);

  backImg = loadImage("bg5.jpg");
  backImg.resize(height, width);

  minim = new Minim(this);

  mainTheme = minim.loadFile("BlueSpace.wav");
  shootSound = minim.loadSample("laser_0.wav");

  mainTheme.play();
}

void draw() {
  background(backImg);

  //limit laser rate of fire to once every 10 frames
  if (laserFired == true && frameCount % 10 == 0) {
    laserFired = false;
  }

  //lasers
  for (int i = lasers.size() - 1; i >=0; i--) {
    lasers.get(i).move();
    lasers.get(i).display();
  }


  ship.update();
  ship.dispay();

  ship.displayScore();

  for (int i = rocks.size() -1; i >= 0; i--) {
    rocks.get(i).update();

    rocks.get(i).display();
    int isHit = rocks.get(i).hit();
    if (isHit >= 0) {

      ship.setScore(40);
      if (isHit > 0) {
        addRocks(2, isHit - 1);
      }

      rocks.remove(i);
    }
  }

  //this is for testing to make sure the score is going to work.
  //if( frameCount % 120 == 0){
  //  ship.setScore(40);
  //}
}

void addRocks(int quant, int rLevel) {

  for (int i = 0; i < quant; i++) {
    rocks.add(new Rock(rLevel * 12, (int)random(width), (int)random(height), rLevel, lasers));
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
    //fire lasers if laser is not already fired
    if (laserFired == false) {
      //pew pew
      shootSound.trigger();
      //make new laser at ship position, heading in direction ship is facing
      lasers.add(new Laser(ship.getPos().x, ship.getPos().y, ship.getAngle()));

      //set laser to fired
      laserFired = true;
    }
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