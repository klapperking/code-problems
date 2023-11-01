
import static org.junit.Assert.*;
import org.junit.Test;
import java.lang.Math;

public class ConverterTest {

	@Test
	public void test1() {
	  assertEquals("103", Converter.converter(13, 0, Math.PI));
	}
}
