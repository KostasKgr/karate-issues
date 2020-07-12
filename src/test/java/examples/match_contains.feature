Feature: match_contains

    Scenario: Deeply nested contains used to work in 0.9.5 but in 0.9.6 seems to require all fields to be present
      Given def message =
      """
          {
              "correlationId": "101",
              "text": "Hello to everyone",
              "data": {
                  "deeply": {
                      "nested": "no",
                      "id": "1010"
                  }
              }
          }
          """
      Then match message contains { text: "Hello to everyone" }
      Then match message contains { data: { deeply: { nested: "no" } } } }


  Scenario: Match contains for sublist works even if simple list elements are reversed
    Given def message =
      """
      {
          order_id: 5,
          products: [100,101]
      }
      """
    Then match message contains { order_id: 5, products: [101, 100] }


  Scenario: Match contains for sublist works even if complex list elements are reversed
    Given def message =
      """
      {
          order_id: 5,
          products: [
            { product_id: 100, name: "bicycle" },
            { product_id: 101, name: "car" }
          ]
      }
      """
    Then match message contains
      """
      {
          order_id: 5,
          products: [
            { product_id: 101, name: "car" },
            { product_id: 100, name: "bicycle" }
          ]
      }
      """