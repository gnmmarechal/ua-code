void generateFile(String filePath) //Gera um ficheiro em branco com os scores
{
  try 
  {
    PrintWriter scoreOut = new PrintWriter(filePath);
    for (int i = 0; i < 5; i++)
    {
      scoreOut.println(0);
    }
    scoreOut.close();    
  }
  catch (Exception e) { showMessageDialog(null, "Erro: " + e.getMessage()); System.err.println("Erro: " + e.getMessage());};    
}

long[] readScores(String filePath)
{
  long[] temp = new long[5];
  try
  {
    File scoreFile = new File(filePath);
    Scanner fileRead = new Scanner(scoreFile);
    for (int i = 0; i < 5; i++)
    {
      temp[i] = fileRead.nextLong();
    }
  } catch (Exception e) { showMessageDialog(null, "Erro: " + e.getMessage()); System.err.println("Erro: " + e.getMessage()); };
  return temp;
}

void writeScores(String filePath, long[] points) //Esta função escreve os scores no ficheiro
{
  try 
  {
    PrintWriter scoreOut = new PrintWriter(filePath);
    for (int i = 0; i < points.length; i++)
    {
      scoreOut.println(points[i]);
    }
    scoreOut.close();    
  }
  catch (Exception e) { showMessageDialog(null, "Erro: " + e.getMessage()); System.err.println("Erro: " + e.getMessage());};   
}

boolean isRecord(long points, long[] recordArray) //Esta função verifica se há um novo recorde
{
  if (recordIndex(points, recordArray) == -1 )
    return false;
  else
    return true;
    
}

int recordIndex(long points, long[] recordArray) //Esta função verifica o índice onde colocar o novo recorde
{
  for (int i = 0; i < recordArray.length; i++)
  {
    if (points > recordArray[i])
      return i;
  }
  return -1;
}

long[] generateRecordArray(long points, long[] currentRecordArray, int index)
{
  long[] temp = currentRecordArray;
  for (int i = 4; i > index; i--)
  {
    temp[i] = temp[i - 1];
  }
  temp[index] = points;
  
  return temp;
}