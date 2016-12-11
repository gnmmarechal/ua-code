void loadMaxScore(String filePath) //Carrega apenas o score do topo
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
  } catch (Exception e) { /* showMessageDialog(null, "Erro: " + e.getMessage()); // Dá erro se não existir score, não é relevante a maior parte das vezes, por isso removi o MessageDialog.*/ System.err.println("Erro: " + e.getMessage());};
}

void writeMaxScore(String filePath, long points) //Escreve o score no ficheiro (apenas um score)
{
  try 
  {
    PrintWriter scoreOut = new PrintWriter(filePath);
    scoreOut.println(points);
    scoreOut.close();    
  }
  catch (Exception e) { showMessageDialog(null, "Erro: " + e.getMessage()); System.err.println("Erro: " + e.getMessage());};  
}