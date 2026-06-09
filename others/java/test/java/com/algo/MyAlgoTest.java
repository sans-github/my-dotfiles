package com.algo;

import org.junit.jupiter.api.Assertions;
import org.junit.jupiter.api.Test;

public class MyAlgoTest {

  MyAlgo app = new MyAlgo();
  @Test
  public void testDoubleIt() {
    System.out.println("Testing double");
    Assertions.assertEquals(app.doubleIt(2), 4);
  }
}