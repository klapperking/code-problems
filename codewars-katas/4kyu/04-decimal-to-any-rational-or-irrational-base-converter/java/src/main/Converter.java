import java.util.ArrayList;
import java.util.List;

public class Converter {

  // Convert numbers between 10-36 to A-Z
  private static String getStringFromInt(int i) {

    // use ASCII table for conversion
    if (i >= 10 && i <= 36) {
      System.out.println(List.of("Converting", i, "to", String.valueOf((char)(i + 'A'))));
      return String.valueOf((char)(i + 'A'));
    }

    return Integer.toString(i);
  }

	public static String converter(double n, int decimals, double base) {

    System.out.println(List.of(n, decimals, base));
    ArrayList<String> result = new ArrayList<String>();
    boolean negative_flag = false;

    // n * -1 if n < 0, to also account for negatives
    if (n < 0) {
      negative_flag = true;
      n *= -1;
    }

    // find highest exponent k for which Math.pow(base, k) <= n; logbase (n) = log10(n) / log10(b)
    int k = (int)((Math.floor(Math.log(n) / Math.log(base))) + 1);

    // decreasing k, find the next digit for result and adjust n. Add . when needed to separate before and after comma
    for (int i = k-1; i > (-1) * decimals - 1; i--) {
      if (result.size() == k) {
        result.add(".");
      }

      int digit = (int)(Math.floor(n / Math.pow(base, i)) % base);
      n -= digit * Math.pow(base, i);
      result.add(Converter.getStringFromInt(digit));
    }

    if (negative_flag) {
      result.add(0, "-");
    }

    return String.join("", result);
  }
}
