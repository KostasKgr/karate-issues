import com.intuit.karate.junit5.Karate;

class _SyncRunner {
    @Karate.Test
    Karate testClientDebug() {
        return new Karate().feature();
    }
}