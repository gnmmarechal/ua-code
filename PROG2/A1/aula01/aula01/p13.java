import static java.lang.System.*;
import java.util.Scanner;

public class p13
{
  public static final Scanner in = new Scanner(System.in);

  public static void main(String[] args)
  {
    int n;
    do
    {
      out.print("N: ");
      n = in.nextInt();
      if(n < 1)
        err.println("ERROR: invalid number!");
    }
    while(n < 1);

    String verb = isPrime(n)? "is" : "is not";
    out.printf("Number %d %s prime\n", n, verb);
  }

  public static boolean isPrime(int n)
  {
    // Complete a função para verificar se n é primo...

  }
}
