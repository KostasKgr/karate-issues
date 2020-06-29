function(topic, filter, format) {
  var KafkaLib = Java.type('RecordHolder')
  karate.log("wtf 1")
  if (!format) {
    format = "STRING";
  }

  karate.log("Getting records for " + topic + " with format: " + format)


  // TODO would prefer to not pass a format and have Karate dynamically
  //      understand the type and convert to the relevant native type
  var records

  if (format == "STRING") {
    records = KafkaLib.getRecords(topic)
  } else if (format == "JSON") {
    records = KafkaLib.getRecordsAsJson(topic)
  //} else if (format == "XML") {
    // ???
  } else {
    throw "Unexpected format: " + format
  }

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