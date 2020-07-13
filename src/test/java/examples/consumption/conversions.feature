Feature: Matching and filtering in javascript

  Scenario Outline: Match native types in js: <type>
    * eval
    """
    var temp = karate.fromString(<data>);
    karate.log(temp);
    karate.log(temp.value);
    var val = temp.value;
    // Match handles type conversions, so no asMap or asList needed
    var res = karate.match(<match>);
    if (!res.pass) karate.fail(res.message);
    """

    Examples:
      | type      | data                                                        | match                                             |
      | json map  | '{ "foo": "bar", "nested": { "deeply": "here", "id": 5 } }' | "val contains deep { nested: { deeply: 'here' }}" |
      | json list | '[{"type": "car"}, {"type": "bicycle"}]'                    | "val contains [{type: 'car'}]"                    |
      | string    | 'hello world'                                               | "val contains 'hello'"                            |
      | xml       | '<greeting language="en">Hello World</greeting>'            | "val /greeting/@language == 'en'"                 |


  Scenario Outline: Filter native types in js: <type>
    * eval
    """
    var temp = karate.fromString(<data>);
    karate.log(temp);
    karate.log(temp.value);
    var val = temp.value;
    if(temp.json) {
      val = temp.mapLike ? temp.asMap : temp.asList;
    }
    var filter = function(data) { <filter> }
    var res = filter(val)
    if (!res) karate.fail("Filter did not match");
    """

    Examples:
      | type      | data                                                        | filter                                                    |
      | json map  | '{ "foo": "bar", "nested": { "deeply": "here", "id": 5 } }' | return data.nested.id == 5                                |
      | json list | '[{"type": "car"}, {"type": "bicycle"}]'                    | return data[0].type == "car"                              |
      | string    | 'hello world'                                               | return data.contains("hello")                             |
      | xml       | '<greeting language="en">Hello World</greeting>'            | return karate.xmlPath(data, '/greeting/@language') == 'en' |