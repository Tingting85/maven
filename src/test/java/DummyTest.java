import org.junit.jupiter.api.Test;

import static org.junit.jupiter.api.Assertions.*;

public class DummyTest {
    @Test
    void testDummy(){
        assertEquals(true,Dummy.dummyMethod());
    }
    @Test
    void testDummy2(){
        assertEquals(false,Dummy.dummyMethod());
    }
}


