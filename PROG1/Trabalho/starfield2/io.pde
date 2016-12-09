void loadMaxScore(String filePath)
{
  try 
  {
    File scoreFile = new File(filePath);
    Scanner fileRead = new Scanner(scoreFile);
    while (fileRead.hasNextLong())
    {
      maxScore = fileRead.nextLong();
    }
    fileRead.close();
  } catch (Exception e) { System.err.println("Erro: " + e.getMessage());};
}

void writeMaxScore(String filePath, long points)
{
  try 
  {
    PrintWriter scoreOut = new PrintWriter(filePath);
    scoreOut.println(points);
    scoreOut.close();    
  }
  catch (Exception e) { System.err.println("Erro: " + e.getMessage()); };  
}