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

//Create score object
Score score = new Score();

//create high score object
HighScores highscore;

//bool test for background music
boolean music = false;

//Create Levels object
Levels levels = new Levels();

//create an array list of rocks
ArrayList<Rock> rocks = new ArrayList<Rock>();

//create lasers array
ArrayList<Laser> lasers = new ArrayList<Laser>();

//Boolean to test if laser fired
boolean laserFired = false;

//Boolean to test if game over
boolean gameOver;

//Boolean to test if level over
boolean levelOver;

//Test if high score added
boolean highScoreAdded;

//Make ship un-damageable for a few seconds
int undamageable = 0;

//Rock level decides how many times rocks should split
int rockLevel = 3;
int startingRocks = 2;

int totalRocks;

void setup() {    
  rocks = new ArrayList<Rock>();
  lasers = new ArrayList<Laser>();
  ship = new Ship(width/2, height/2, rocks);
    
  if(gameOver == true) {
    score.setScore(0); // initiallise score
    levels.resetLevels(); // go back to level 1
  }
  
  //Calculate the total number of rocks to be destroyed in the level
  totalRocks = (startingRocks + levels.getLevel() - 1) + (((startingRocks + levels.getLevel() - 1)) * 7);
  
  size(700, 700);

  addRocks((startingRocks - 1) + levels.getLevel(), rockLevel);

  backImg = loadImage("bg5.jpg");
  backImg.resize(height, width);

  minim = new Minim(this);

  mainTheme = minim.loadFile("BlueSpace.wav");
  shootSound = minim.loadSample("laser_0.wav");

  if(!music){
    mainTheme.play();
    music = true;
  }
  
  highscore = new HighScores();
  highScoreAdded = false;
  gameOver = false;
  levelOver = false;
}

void draw() {
  background(backImg);
  
  if (gameOver == false) {
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
    if(frameCount > 240){
      if(ship.crash()){
        if(undamageable + 100 < frameCount) {
          ship.addDamage(20);
          
          //Make ship un-damageable for a few seconds
          undamageable = frameCount;
        }
        if(ship.getDamage() == 100) {
          gameOver = true;  
        }
      }
    }

    //Go to next level if all rocks destroyed
    if(rocks.size() >= totalRocks) {
      levels.nextLevel(); //Go to next level
      setup();
    }

    ship.displayDamage();
    score.displayScore();
    levels.displayLevel();

    for (int i = rocks.size() -1; i >= 0; i--) {
      rocks.get(i).update();

      rocks.get(i).display();
      int isHit = rocks.get(i).hit();
      if (isHit >= 0) {
        
        score.addScore(40);
        if (isHit > 0) {
          addRocks(2, isHit - 1);
        }

        rocks.remove(i);
      }
    }
  }
  else {
    if(highScoreAdded == false) {
      highscore.addScore(score.getScore());
      highScoreAdded = true;
    }
    highscore.displayScores();
  }

}

void addRocks(int quant, int rLevel) {

  for (int i = 0; i < quant; i++) {
    rocks.add(new Rock(rLevel * 12, (int)random(width), (int)random(height), rLevel, lasers));
  }
}


void keyPressed() {
  if (keyCode == UP && gameOver == false) {
    ship.go(true);
  }

  if (keyCode == RIGHT && gameOver == false) {
    ship.steering(steering);
  }

  if (keyCode == LEFT && gameOver == false) {

    ship.steering(steering * -1);
  }

  //spacebar ascii code is 32
  if (keyCode == 32 && gameOver == false) {
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
  
  //if 'q' key is pressed to quit to high scores screen
  if (keyCode == 81 || keyCode == 113) {
    gameOver = true;  
  }
  
  //if 'n' key is pressed start a new game
  if (keyCode == 78 || keyCode == 110) {
    if(gameOver == true) {
      minim.stop();
      music = false;
      setup();
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