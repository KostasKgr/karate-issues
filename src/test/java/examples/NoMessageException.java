package examples;

import java.util.ConcurrentModificationException;

public class NoMessageException {

    public static void error() {
        System.out.println("Throwing an exception without a message");
        throw new ConcurrentModificationException();
    }
}
