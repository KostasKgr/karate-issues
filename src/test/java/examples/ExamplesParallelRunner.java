package examples;

import com.intuit.karate.Results;
import com.intuit.karate.Runner;
import org.junit.jupiter.api.Test;

import static org.junit.jupiter.api.Assertions.assertEquals;

class ExamplesParallelRunner {

    @Test
    public void testAll() {
        Results results = Runner.path("classpath:examples").parallel(1);
        assertEquals(0, results.getFailCount(), results.getErrorMessages());
    }

}
