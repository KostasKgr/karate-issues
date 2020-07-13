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
        jsonTopic.add("{\n" +
                "    \"correlationId\": \"100\",\n" +
                "    \"text\": \"Hello World\",\n" +
                "    \"data\": {\n" +
                "        \"deeply\": {\n" +
                "            \"nested\": \"yes\",\n" +
                "            \"id\": \"1000\"\n" +
                "        }\n" +
                "    }\n" +
                "}");
        jsonTopic.add("[\n" +
                "    {\"order_id\": 5, \"name\": \"bicycle\"},\n" +
                "    {\"order_id\": 6, \"name\": \"car\"}\n" +
                "]");
        jsonTopic.add("{\n" +
                "    \"correlationId\": \"101\",\n" +
                "    \"text\": \"Hello to everyone\",\n" +
                "    \"data\": {\n" +
                "        \"deeply\": {\n" +
                "            \"nested\": \"no\",\n" +
                "            \"id\": \"1010\"\n" +
                "        }\n" +
                "    }\n" +
                "}");

        records.put("json.topic", jsonTopic);
    }

    static public List<String> getRecords(String topic) {
        return records.get(topic);
    }

    static public List<Map<String, Object>> getRecordsAsJson(String topic) throws JsonProcessingException {
        System.out.println("Converting record to json in java layer");
        var record = getRecords(topic).get(1);
        // TODO It would seem preferable to keep the java layer as thin as possible
        //      and parse json from string in Karate, as it can already do that in
        //      def X = {....} clauses
        Map<String,Object> result = new ObjectMapper().readValue(record, HashMap.class);
        return List.of(result);
    }
}
