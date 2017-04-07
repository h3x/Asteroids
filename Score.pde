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
  
  //Adds to the player's score
  public void addScore(int s)
  {
    score += s;  
  }
  
  //setScore() - Sets the player's score
  public void setScore(int s)
  {
    score = s;  
  }
  
  //Gets the player's score
  public int getScore()
  {
    return score;  
  }
  
  //Displays the player's score
  public void displayScore()
  {
    textSize(32);
    fill(127);
    text(score, 20, 40);  
  }
}
