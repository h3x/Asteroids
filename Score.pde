/***********************************************************************************************************
 * Class:     Score
 *
 * Authors:   Scott Nicol
 *
 * Function:  Creates object which keeps track of the player's score 
 *             
 * Imports:   None
 *
 * Methods:   addScore() - Adds to the player's score
 *            setScore() - Sets the player's score
 *            getScore() - Gets the player's score
 *            displayScore() - Displays the player's score
 *
 ************************************************************************************************************/

class Score
{
  int score = 0;
  
  /***********************************************************************************************************
  * Method:     addScore()
  *
  * Authors:    Scott Nicol
  *
  * Function:   Increments the player's score
  *             
  * Parameters: int s
  *
  * Notes:      Increments the player's score by the value specified in the parameter
  *
  ************************************************************************************************************/
  public void addScore(int s)
  {
    score += s;  
  }
  
  /***********************************************************************************************************
  * Method:     setScore()
  *
  * Authors:    Scott Nicol
  *
  * Function:   Sets the player's score
  *             
  * Parameters: int s
  *
  * Notes:      Set the player's score to the value specified in the parameter
  *
  ************************************************************************************************************/
  public void setScore(int s)
  {
    score = s;  
  }
  
  /***********************************************************************************************************
  * Method:     getScore()
  *
  * Authors:    Scott Nicol
  *
  * Function:   Gets the player's score
  *             
  * Parameters: None
  *
  * Notes:      Returns the score variable which is the player's score
  *
  ************************************************************************************************************/
  public int getScore()
  {
    return score;  
  }
  
  /***********************************************************************************************************
  * Method:     displayScore()
  *
  * Authors:    Scott Nicol
  *
  * Function:   Displays the player's score
  *             
  * Parameters: None
  *
  * Notes:      Formats and displays the player's score to the screen
  *
  ************************************************************************************************************/
  
  public void displayScore()
  {
    textSize(32);
    fill(127);
    text(score, 20, 40);  
  }
}