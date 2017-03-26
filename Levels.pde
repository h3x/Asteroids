class Levels
{
  private int level = 1;
  
  public void nextLevel()
  {
      level += 1;
  }
  
  public void resetLevels()
  {
    level = 1;  
  }
  
  public int getLevel()
  {
    return level;  
  }
  
  public void displayLevel()
  {
    text("Level " + level, 580, 40);
  }
}