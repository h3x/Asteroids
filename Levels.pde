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

  /***********************************************************************************************************
   * Method:     nextLevel()
   *
   * Authors:    Scott Nicol
   *
   * Function:   Goes to the next level
   *             
   * Parameters: None
   *
   * Notes:      Increments level variable thereby going to the next level
   *
   ************************************************************************************************************/
  public void nextLevel()
  {
    
    level += 1;
  }

  /***********************************************************************************************************
   * Method:     resetLevels()
   *
   * Authors:    Scott Nicol
   *
   * Function:   Resets the levels
   *             
   * Parameters: None
   *
   * Notes:      Sets the level variable back to 1, thereby resetting the game levels
   *
   ************************************************************************************************************/
  public void resetLevels()
  {
    level = 1;
  }
  
  /***********************************************************************************************************
   * Method:     getLevel()
   *
   * Authors:    Scott Nicol
   *
   * Function:   Gets the current level
   *             
   * Parameters: None
   *
   * Notes:      Returns the level variable which is the current level
   *
   ************************************************************************************************************/
  public int getLevel()
  {
    return level;
  }
  
  /***********************************************************************************************************
   * Method:     displayLevel()
   *
   * Authors:    Scott Nicol
   *
   * Function:   Displays the current level
   *              
   * Parameters: None
   *
   * Notes:      Formats and displays the current level to screen
   *
   ************************************************************************************************************/
  public void displayLevel()
  {
    text("Level " + level, 580, 40);
  }
}
