import javax.swing.*;

class HighScores {
  String[] names = new String[10];
  int[] scores = new int[10];
  String name;
  
  public HighScores()
  {
    loadScores();
  }
  
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
        names[i] = name;
        break;
      }
    }
    
    saveScores();
  }
  
  private void loadScores()
  {
    String lines[] = loadStrings("data/highscores.txt");
    
    for(int i = 0; i < scores.length; i++)
    {
        names[i] = lines[i * 2];  
        scores[i] = Integer.parseInt(lines[(i * 2) + 1]);
    }
  }
  
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
  
  public void displayScores()
  {
    textSize(40);
    text("HIGH SCORES", 270, 40);
    
    text("1", 20, 100); text(names[0], 250, 100); textAlign(RIGHT); text(scores[0], 780, 100); textAlign(LEFT);
    
    text("2", 20, 160); text(names[1], 250, 160); textAlign(RIGHT); text(scores[1], 780, 160); textAlign(LEFT);
    
    text("3", 20, 220); text(names[2], 250, 220); textAlign(RIGHT); text(scores[2], 780, 220); textAlign(LEFT);
    
    text("4", 20, 280); text(names[3], 250, 280); textAlign(RIGHT); text(scores[3], 780, 280); textAlign(LEFT);
    
    text("5", 20, 340); text(names[4], 250, 340); textAlign(RIGHT); text(scores[4], 780, 340); textAlign(LEFT);
    
    text("6", 20, 400); text(names[5], 250, 400); textAlign(RIGHT); text(scores[5], 780, 400); textAlign(LEFT);
    
    text("7", 20, 460); text(names[6], 250, 460); textAlign(RIGHT); text(scores[6], 780, 460); textAlign(LEFT);
    
    text("8", 20, 520); text(names[7], 250, 520); textAlign(RIGHT); text(scores[7], 780, 520); textAlign(LEFT);
    
    text("9", 20, 580); text(names[8], 250, 580); textAlign(RIGHT); text(scores[8], 780, 580); textAlign(LEFT);
    
    text("10", 20, 640); text(names[9], 250, 640); textAlign(RIGHT); text(scores[9], 780, 640); textAlign(LEFT);
    
    text("N - New Game", 450, 750);
  }
}