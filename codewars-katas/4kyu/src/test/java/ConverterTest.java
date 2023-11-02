
import static org.junit.Assert.*;
import org.junit.Test;
import java.lang.Math;
import com.baseconverter.Converter;

public class ConverterTest {

	@Test
	public void test1() {
	  assertEquals("103", Converter.converter(13, 0, Math.PI));
    assertEquals("N.8000", Converter.converter(13.5, 4, 16.0));
    assertEquals("-3PL0U.L0000000", Converter.converter(-867832.5, 8, 22.0));
	}
}
