package examples;

import com.intuit.karate.Runner;
import com.intuit.karate.junit5.Karate;
import org.junit.jupiter.api.Test;

import static org.junit.jupiter.api.Assertions.assertEquals;

class ExamplesRunner {

    @Test
    public void testAll() {
        var results = Runner.path("classpath:.")
                .tags("~@ignore")
                .reportDir("target/surefire-reports")
                .parallel(5);
        assertEquals(0, results.getFailCount(), results.getErrorMessages());
    }
    
}
