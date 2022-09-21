class MyQueries {
  String getCustomers() {
    return """
      query MyQuery {
  getCustomers {
    name
    value {
      email
      name
    }
  }
}

""";
  }

  String getOrders() {
    return """
query MyQuery {
  getOrders {
    name
    value {
      Address
      City
      Lat
      Lng
      carrier
      createdAt
      shippingCost
      trackingId
      trackingItems {
        customer_id
        customer {
          email
          name
        }
        items {
          item_id
          name
          price
          quantity
        }
      }
    }
  }
}

""";
  }

  String getCustomerByID(String id) {
    return """
query MyQuery {
  getCustomerById(id: "$id") {
    email
    name
  }
}

""";
  }

  String getTrackingItems() {
    return """
query MyQuery {
  getTrackingItems {
    name
    value {
      customer {
        email
        name
      }
      customer_id
      items {
        item_id
        name
        price
      }
    }
  }
}
""";
  }

  String getTrackingItemsbyId(String id) {
    return """
query MyQuery {
  getTrackingItemsById(id: "$id") {
    customer {
      email
      name
    }
    customer_id
    items {
      item_id
      name
      price
    }
  }
}


""";
  }

  String getItems() {
    return """

query MyQuery {
  getOrders {
    name
    value {
      trackingItems {
        items {
          item_id
          name
          price

        }
        customer_id
      }
    }
  }
}
""";
  }
}
