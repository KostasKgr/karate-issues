function(topic, filter, format) {
  var KafkaLib = Java.type('RecordHolder')

  if (!format) {
    format = "automatic";
  }

  karate.log("Getting records for " + topic + " with format: " + format)

  // TODO would prefer to not pass a format and have Karate dynamically
  //      understand the type and convert to the relevant native type
  var records

  if (format == "json") {
    records = KafkaLib.getRecordsAsJson(topic)
  } else {
      records = KafkaLib.getRecords(topic)
  }

  karate.log("Got " + records.length + " records")
  karate.log("Details: " + records)

  for (record_id in records) {
    var record = records[record_id]
     if (format == "automatic") {
        // Convert string to karate native type
        var native = karate.fromString(record)
        karate.log("Native object:", native)
        record = native.value
    }
    karate.log("Evaluating: " + record)
    // TODO find a way to convert to native data type
    if (filter(record)) {
      karate.log("Record matched: " + record)
      return record
    }
  }

  throw "No records found matching the filter: " + filter
}