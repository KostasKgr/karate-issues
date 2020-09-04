package examples;

import com.fasterxml.jackson.databind.ObjectMapper;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;
import java.util.stream.IntStream;

public class CatProvider {

  public static List<Cat> getCats(int count) {
    return IntStream.range(0, count)
        .mapToObj(i -> new Cat(i))
        .collect(Collectors.toList());
  }


  public static List<Map<String, Object>> getCatsAsMap(int count) {
    ObjectMapper mapper = new ObjectMapper();
    return IntStream.range(0, count)
        .mapToObj(i -> {
          var cat = new Cat(i);
          Map<String, Object> catMap = mapper.convertValue(cat, Map.class);
          return catMap;
        })
        .collect(Collectors.toList());
  }

}
