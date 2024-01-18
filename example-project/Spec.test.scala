import io.github.arturopala.examples.Example

class Spec extends munit.FunSuite {

  test("test") {
    assertEquals(new Example("bar").foo, "bar")
  }
}
