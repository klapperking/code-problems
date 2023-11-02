package com.baseconverter;

import java.lang.Math;
import org.junit.jupiter.api.Test;
import static org.junit.jupiter.api.Assertions.assertEquals;

public class ConverterTest {
  @Test
  void testConverter() {
    assertEquals("103", Converter.converter(13, 0, Math.PI));
  }
}
