import java.util.*;

public class ReverseByWords {
    public static void main(String args[]) {
      Scanner scan = new Scanner(System.in);  
      String s[] = scan.nextLine().split(" "); 
      String ans = ""; 
      for (int i = s.length - 1; i >= 0; i--) { 
        ans += s[i] + " "; 
      } 
      System.out.println("Reversed String: " + ans); 
    }
}
