import com.intuit.karate.KarateOptions;
import com.intuit.karate.junit5.Karate;

//@KarateOptions(tags = {"~@ignore"})
class _SyncRunner {
    @Karate.Test
    Karate testClientDebug() {
        return new Karate().tags("~@ignore").feature();
    }
}