/***********************************************************************************************************
 * Class:     HighScores
 *
 * Authors:   Scott Nicol
 *
 * Function:  Creates the high scores object 
 *             
 * Imports:   javax.swing.*
 *
 * Methods:   addScore() - Submits a high score be checked for admission to the high scores list
 *            loadScores() - Loads the saved high scores from the data/highscores.txt file
 *            saveScores() - Saves the updated high scores list to data/highscores.txt file
 *            displayScores() - Displays the high scores list to the screen
 *
 ************************************************************************************************************/

import javax.swing.*;

class HighScores {
  String[] names = new String[10];
  int[] scores = new int[10];
  String name;
  
  /***********************************************************************************************************
 * Method:     Constructor
 *
 * Authors:    Scott Nicol
 *
 * Function:   Create a new high scores object
 *             
 * Parameters: None
 *
 * Notes:      Loads the saved high scores from data/highscores.txt upon creation
 *
 ************************************************************************************************************/
  public HighScores()
  {
    loadScores();
  }
  
   /***********************************************************************************************************
 * Method:     addScore()
 *
 * Authors:    Scott Nicol
 *
 * Function:   Create a new high scores object
 *             
 * Parameters: int score
 *
 * Notes:      Submits a score to be checked by an algorithm to determine if it should be added to the high
 *             scores list.
 *
 ************************************************************************************************************/
  public void addScore(int score)
  {    
    for(int i = 0; i < scores.length; i++)
    {
      if(score > scores[i])
      {
        for(int j = scores.length - 1; j > i; j--)
        {
          scores[j] = scores[j-1];
          names[j] = names[j-1];
        }
        while(name == null || name.length() < 1)
        {
          name = JOptionPane.showInputDialog(frame, "Please input your name:", "Congratulations! You made a high score!", JOptionPane.INFORMATION_MESSAGE);
        }
        scores[i] = score;
        names[i] = name.trim();
        break;
      }
    }
    
    saveScores();
  }
  
   /***********************************************************************************************************
 * Method:     loadScores()
 *
 * Authors:    Scott Nicol
 *
 * Function:   Loads the saved high scores from the text file
 *             
 * Parameters: None
 *
 * Notes:      Loads the saved high scores from the data/highscores.txt file and then stores them in an array.
 *
 ************************************************************************************************************/
  private void loadScores()
  {
    String lines[] = loadStrings("data/highscores.txt");
    
    for(int i = 0; i < scores.length; i++)
    {
        names[i] = lines[i * 2];  
        scores[i] = Integer.parseInt(lines[(i * 2) + 1]);
    }
  }
  
    /***********************************************************************************************************
 * Method:     saveScores()
 *
 * Authors:    Scott Nicol
 *
 * Function:   Saves the updated high scores to text file
 *             
 * Parameters: None
 *
 * Notes:      Takes the updated high scores from an the array and then saves them data/highscores.txt.
 *
 ************************************************************************************************************/
  private void saveScores()
  {
    String[] lines = new String[20];
    
    for(int i = 0; i < scores.length; i++)
    {
        lines[i * 2] = names[i];  
        lines[(i * 2) + 1] = str(scores[i]);  
    }
    
    //Save the names and scores to file
    saveStrings("data/highscores.txt", lines);
  }
  
     /***********************************************************************************************************
 * Method:     displayScores()
 *
 * Authors:    Scott Nicol
 *
 * Function:   Displays the high scores to the screen
 *             
 * Parameters: None
 *
 * Notes:      Displays the high scores to the screen with formatting.
 *
 ************************************************************************************************************/
  public void displayScores()
  {
    textSize(30);
    text("HIGH SCORES", 260, 40);
    
    text("--------------------------------------", 20, 70);
    
    text("1", 20, 100); text(names[0], 250, 100); textAlign(RIGHT); text(scores[0], 680, 100); textAlign(LEFT);
    
    text("2", 20, 140); text(names[1], 250, 140); textAlign(RIGHT); text(scores[1], 680, 140); textAlign(LEFT);
    
    text("3", 20, 180); text(names[2], 250, 180); textAlign(RIGHT); text(scores[2], 680, 180); textAlign(LEFT);
    
    text("4", 20, 220); text(names[3], 250, 220); textAlign(RIGHT); text(scores[3], 680, 220); textAlign(LEFT);
    
    text("5", 20, 260); text(names[4], 250, 260); textAlign(RIGHT); text(scores[4], 680, 260); textAlign(LEFT);
    
    text("6", 20, 300); text(names[5], 250, 300); textAlign(RIGHT); text(scores[5], 680, 300); textAlign(LEFT);
    
    text("7", 20, 340); text(names[6], 250, 340); textAlign(RIGHT); text(scores[6], 680, 340); textAlign(LEFT);
    
    text("8", 20, 380); text(names[7], 250, 380); textAlign(RIGHT); text(scores[7], 680, 380); textAlign(LEFT);
    
    text("9", 20, 420); text(names[8], 250, 420); textAlign(RIGHT); text(scores[8], 680, 420); textAlign(LEFT);
    
    text("10", 20, 460); text(names[9], 250, 460); textAlign(RIGHT); text(scores[9], 680, 460); textAlign(LEFT);
    
    text("--------------------------------------", 20, 490);
    
    text("N - New Game", 350, 650);
  }
}
