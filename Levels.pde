/***********************************************************************************************************
 * Class:     Levels
 *
 * Authors:   Scott Nicol
 *
 * Function:  Creates the object which controls in-game levels 
 *             
 * Imports:   None
 *
 * Methods:   nextLevel() - Goes to the next level
 *            resetLevel() - Resets to the first level
 *            getLevel() - Gets the current level
 *            displayLevel() - Displays the current level
 *
 ************************************************************************************************************/


class Levels
{
  private int level = 1;

  //Goes to the next level
  public void nextLevel()
  {
    
    level += 1;
  }

  //Resets to the first level
  public void resetLevels()
  {
    level = 1;
  }
  
  //Gets the current level
  public int getLevel()
  {
    return level;
  }
  
  //Displays the current level
  public void displayLevel()
  {
    text("Level " + level, 580, 40);
  }
}
