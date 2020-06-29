import java.util.LinkedList;
import java.util.List;

public class RecordHolder {
    static public List<String> getRecords(String topic) {
        List<String> records = new LinkedList<>();
        records.add("{\"correlationId\":\"100\",\"text\":\"Hello world\"}\n");
        records.add("{\"correlationId\":\"101\",\"text\":\"Hello to everyone\"}\n");
        return records;
    }
}
