package sunabako;

import org.junit.jupiter.api.Test;

import static org.junit.jupiter.api.Assertions.assertEquals;

class HelloWorldTest {
    @Test
    void helloWorld() {
        assertEquals("HelloWorld", HelloWorld.hello());
    }
}
