package examples;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.slf4j.MDC;

public class Amazing {
    private static final Logger logger = LoggerFactory.getLogger(Amazing.class);

    public static void doWork() {
        MDC.put("logFileName", Thread.currentThread().getName());
        logger.info("Doing lots of work");
        System.out.println("Doing lots of work in system out");

        com.intuit.karate.Logger karateLogger = new com.intuit.karate.Logger();

        karateLogger.info("Karate logger - doing work");
    }
}
