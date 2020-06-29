import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;

import java.util.HashMap;
import java.util.LinkedList;
import java.util.List;
import java.util.Map;

public class RecordHolder {

    static Map<String,List<String>> records = new HashMap<>();
    static {
        // json.topic records
        List<String> jsonTopic = new LinkedList<>();
        jsonTopic.add("{\"correlationId\":\"100\",\"text\":\"Hello world\"}\n");
        jsonTopic.add("{\"correlationId\":\"101\",\"text\":\"Hello to everyone\"}\n");

        records.put("json.topic", jsonTopic);
    }

    static public List<String> getRecords(String topic) {
        return records.get(topic);
    }

    static public List<Map<String, Object>> getRecordsAsJson(String topic) throws JsonProcessingException {
        var record = getRecords(topic).get(1);
        // TODO It would seem preferable to keep the java layer as thin as possible
        //      and parse json from string in Karate, as it can already do that in
        //      def X = {....} clauses
        Map<String,Object> result = new ObjectMapper().readValue(record, HashMap.class);
        return List.of(result);
    }
}
