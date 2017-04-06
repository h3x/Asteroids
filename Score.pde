/***********************************************************************************************************
 * Class:     Score
 *
 * Authors:   Scott Nicol
 *
 * Function:   
 *             
 * Imports:   None
 *
 * Methods:      
 *
 ************************************************************************************************************/

class Score
{
  int score = 0;
  
  public void addScore(int s)
  {
    score += s;  
  }
  
  public void setScore(int s)
  {
    score = s;  
  }
  
  public int getScore()
  {
    return score;  
  }
  
  public void displayScore()
  {
    textSize(32);
    fill(127);
    text(score, 20, 40);  
  }
}