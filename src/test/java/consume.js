function(topic, filter) {
  var KafkaLib = Java.type('RecordHolder')

  karate.log("Getting records for " + topic)


  // TODO make it possible to get from last position instead of get all
  // TODO also make it efficient to continue from last position
  var records = KafkaLib.getRecords(topic)

  karate.log("Got " + records.length + " records")
  karate.log("Details: " + records)

  for (record_id in records) {
    var record = records[record_id]
    karate.log("Evaluating: " + record)
    // TODO find a way to convert to native data type
    if (filter(record)) {
      karate.log("Record matched: " + record)
      return record
    }
  }

  throw "No records found matching the filter: " + filter
}