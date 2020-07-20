package examples;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

public class Amazing {
    private static final Logger logger = LoggerFactory.getLogger(Amazing.class);

    public static void doWork() {
        logger.info("Doing lots of work");
        System.out.println("Doing lots of work in system out");

        com.intuit.karate.Logger karateLogger = new com.intuit.karate.Logger();

        karateLogger.info("Karate logger - doing work");
    }
}
