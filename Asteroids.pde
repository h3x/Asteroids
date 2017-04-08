/* 

 Asteroids  Game - Assignment One
 Authors:   Adam Austin
            Tahlia Disisto
            Scott Nicol
 Date:      T1 semester 2017
 Unit:      cosc101
 
 Description: 
 Create a version of the Atari game, Asteroids using the processing environment.
 For a more detailed overview of assignment aims and goals, please visit the game repository:
 https://github.com/smurfcs/Asteroids
 
 Program entry point: setup()
 
 Notes: 
 If game fails to run, please ensure you have the minim sound library installed. 
 Sketch > Import Library > Add Library > Search for minim
 
 Credits:  
 Background music used with permission.
 original content creator: FoxSynergy
 http://opengameart.org/content/blue-space
 
 Foom sound (Asteroid explosions) used with permission.
 original content creator: Unknown
 http://opengameart.org/content/spell-4-fire
 
 newLevel sound used with permission.
 Original content creator: CosmicD
 http://www.freesound.org/people/CosmicD/sounds/133018/
 
 */

import ddf.minim.*;
Minim minim = new Minim(this);
AudioPlayer mainTheme;
AudioSample shootSound;
AudioSample foomSound;
AudioSample newLevel;

//Debug
boolean isSound = true;
boolean isDebug = false;
boolean pause = false;







Ship ship;                                   //create ship object
Score score = new Score();                   //Create score object
HighScores highscore;                        //create high score object
Levels levels = new Levels();                //Create Levels object

boolean music = false;                       //bool test for background music
boolean laserFired = false;                  //Boolean to test if laser fired
boolean gameOver;                            //Boolean to test if game over
boolean levelOver;                           //Boolean to test if level over
boolean highScoreAdded;                      //Test if high score added

ArrayList<Rock> rocks = new ArrayList<Rock>();    //create an array list of rocks
ArrayList<Laser> lasers = new ArrayList<Laser>(); //create lasers array

int undamageable = 0;                       //Make ship un-damageable for a few seconds
int rockLevel = 4;                          //Rock level decides how many times rocks should split
int startingRocks = 2;                      //Decides how many asteroids at the beginning of the game
int totalRocks;

PImage backImg;                            //Background image object
float steering = 0.1;                      //ship steering speed

/***********************************************************************************************************
* Method:     setup()
* Authors:    Adam Austin
*             Tahlia Disisto
*             Scott Nicol
* Function:   Program entry point.
*             Setup for screen, class variables, sets up for levels, loads music and sound effects into memory
* Parameters: None
*
************************************************************************************************************/

void setup() {    
  rocks = new ArrayList<Rock>();
  lasers = new ArrayList<Laser>();
  ship = new Ship(width/2, height/2, rocks);

  if (gameOver == true) {
    score.setScore(0);    // initiallise score
    levels.resetLevels(); // go back to level 1
  }

  //Calculate the total number of rocks to be destroyed in the level
  totalRocks = (startingRocks + levels.getLevel() - 1) + (((startingRocks + levels.getLevel() - 1)) * 7);

  size(700, 700);

  addRocks((startingRocks - 1) + levels.getLevel(), rockLevel);

  backImg = loadImage("bg5.jpg");
  backImg.resize(height, width);

  mainTheme = minim.loadFile("BlueSpace.wav");
  shootSound = minim.loadSample("laser_1.wav");
  foomSound = minim.loadSample("foom_1.wav");
  newLevel =  minim.loadSample("newLevel.wav");  

  // If music is playing, dont start it again
  if (!music && isSound) {
    mainTheme.loop();
    music = true;
  }

  highscore = new HighScores();
  highScoreAdded = false;
  gameOver = false;
  levelOver = false;
}

/***********************************************************************************************************
* Method:     Draw()
* Authors:    Adam Austin
*             Tahlia Disisto
*             Scott Nicol
* Function:   Program game loop.
*             
* Parameters: None
*
************************************************************************************************************/
void draw() {
  background(backImg);
  //println(rocks.size());
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

    //Check if ship has crashed and if game is over
    if (ship.crash()) {
      if (ship.getDamage() == 100) {
        gameOver = true;
      }
    }

    //Go to next level if all rocks destroyed
    if (rocks.size() <= 0) {
      levels.nextLevel(); //Go to next level
      if(isSound){
        newLevel.trigger();
      }
      setup();
    }

    for (int i = rocks.size() -1; i >= 0; i--) {
      if(!pause){
        rocks.get(i).update();
      }
      rocks.get(i).setDebug(isDebug);
      rocks.get(i).display();

      //is hit servers as a test var, if the rock is hit it will return a +ve number (or 0), and if the rock has not been hit by a laser, it will return -1
      //it returns the level of the rock to be used in the next generation of rock creation
      int isHit = rocks.get(i).hit();
      if (isHit >= 0) {
        score.addScore(40);
        if( isSound){
          foomSound.trigger();
        }
        if (isHit > 1) { //level 1 is the lowest level of rocks. this avoids all sorts of nasty problems, some of which are * by 0 issues that plauge movement and col/detection
          addRocks(2, isHit - 1, rocks.get(i).getPos());
        }

        rocks.remove(i);
      }
    }

    ship.dispay();
    ship.displayDamage();
    score.displayScore();
    levels.displayLevel();
  } else {
    if (highScoreAdded == false) {
      highscore.addScore(score.getScore());
      highScoreAdded = true;
    }
    highscore.displayScores();
  }
}

void addRocks(int quant, int rLevel) {

  for (int i = 0; i < quant; i++) {
    rocks.add(new Rock(rLevel * 12, (int)random(width), (int)random(height), rLevel, lasers));
    //println("new rock");
  }
}
void addRocks(int quant, int rLevel, PVector deadPos) {

  for (int i = 0; i < quant; i++) {
    rocks.add(new Rock(rLevel * 12, (int)deadPos.x, (int)deadPos.y, rLevel, lasers ));
    //println("new rock");
  }
}


void keyPressed() {
  //debug
  
  switch(keyCode){
   case 115:
   case 83:
     isSound = !isSound;
     ship.setSound();
     println("sound: " + isSound);
     if(isSound){
      mainTheme.unmute();      
     }
     else{
       mainTheme.mute();
     }
     break;
     
   case 100:
   case 68:
      isDebug = !isDebug;
      ship.setDebug(isDebug);
      println("Debug: " + isDebug);
      break;
   
   case 112:
   case 80:
     pause = !pause;
     println("Pause: " + pause);
   
  }
  
  
  
  
  
  //end debug
  
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
      if( isSound){
        shootSound.trigger();
      }
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
    if (gameOver == true) {
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