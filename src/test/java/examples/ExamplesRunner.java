package examples;

import com.intuit.karate.junit5.Karate;
import org.junit.jupiter.api.Test;

class ExamplesRunner {
    
    // this will run all *.feature files that exist in sub-directories
    // see https://github.com/intuit/karate#naming-conventions   
//    @Karate.Test
//    Karate testAll() {
//        return Karate.run().relativeTo(getClass());
//    }

    @Test
    public void exceptions() {
        System.out.println(Integer.parseInt ("notInteger!"));
    }

    @Test
    public void exceptionFromJava() {
        examples.NoMessageException.error();
    }


}
