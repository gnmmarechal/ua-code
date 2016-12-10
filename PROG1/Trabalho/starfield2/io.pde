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

long[] readScoreFile(String filePath) //Função para carregar os scores para um array a partir de um ficheiro
{
  long[] temp = new long[5];
  try
  {
    File scoreFile = new File(filePath);
    Scanner fileRead = new Scanner(scoreFile);
    int i = 0;
    while (fileRead.hasNextLong())
    {
      if (i < 4) //Só lê os primeiros 5 scores
      {
        temp[i++] = fileRead.nextLong();
      }
    }
  } catch (Exception e) { showMessageDialog(null, "Erro: " + e.getMessage()); System.err.println("Erro: " + e.getMessage());};
  return temp;
}

int newRecordPosition(long[] recordArray, long recordScore)//Verifica se há um novo recorde
{
  for (int z = recordArray.length - 1; z > 0 ; z--)
  {
    if (recordScore > recordArray[z]) return z;
  }
  return -1;
}

void writeRecord(String filePath, long[] points) //Escreve o array no ficheiro
{
  try 
  {
    PrintWriter scoreOut = new PrintWriter(filePath);
    for (int z = 0; z < points.length; z++)
    {
      scoreOut.println(points[z]);
    }
    scoreOut.close();    
  }
  catch (Exception e) { showMessageDialog(null, "Erro: " + e.getMessage()); System.err.println("Erro: " + e.getMessage());};  
}