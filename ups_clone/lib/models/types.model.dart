class Customer {
  Customer(
    this.typename,
    this.email,
    this.name,
  );

  String? typename;
  String? email;
  String? name;

  factory Customer.fromJson(Map<String, dynamic> json) => Customer(
        json["__typename"],
        json["email"],
        json["name"],
      );

  Map<String, dynamic> toJson() => {
        "__typename": typename,
        "email": email,
        "name": name,
      };
}

class Item {
  Item(this.typename, this.itemId, this.name, this.price, this.quantity);

  String? typename;
  String? itemId;
  String? name;
  String? price;
  int? quantity;

  factory Item.fromJson(Map<String, dynamic> json) => Item(
        json["__typename"],
        json["item_id"],
        json["name"],
        json["price"],
        json["quantity"],
      );

  Map<String, dynamic> toJson() => {
        "__typename": typename,
        "item_id": itemId,
        "name": name,
        "price": price,
        "quantity": quantity,
      };
}

class TrackingItems {
  TrackingItems(
    this.typename,
    this.customerId,
    this.customer,
    this.items,
  );

  String? typename;
  String? customerId;
  Customer? customer;
  List<Item>? items;

  factory TrackingItems.fromJson(Map<String, dynamic> json) => TrackingItems(
        json["__typename"],
        json["customer_id"],
        Customer.fromJson(json["customer"]),
        List<Item>.from(json["items"].map((x) => Item.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "__typename": typename,
        "customer_id": customerId,
        "customer": customer?.toJson(),
        "items": List<dynamic>.from(items ?? [].map((x) => x.toJson())),
      };
}

class OrderDescription {
  OrderDescription(
    this.typename,
    this.address,
    this.city,
    this.lat,
    this.lng,
    this.carrier,
    this.createdAt,
    this.shippingCost,
    this.trackingId,
    this.trackingItems,
  );

  String? typename;
  String? address;
  String? city;
  double? lat;
  double? lng;
  String? carrier;
  DateTime? createdAt;
  int? shippingCost;
  String? trackingId;
  TrackingItems? trackingItems;

  factory OrderDescription.fromJson(Map<String, dynamic> json) =>
      OrderDescription(
        json["__typename"],
        json["Address"],
        json["City"],
        json["Lat"],
        json["Lng"],
        json["carrier"],
        DateTime.parse(json["createdAt"]),
        json["shippingCost"],
        json["trackingId"],
        TrackingItems.fromJson(json["trackingItems"]),
      );

  Map<String, dynamic> toJson() => {
        "__typename": typename,
        "Address": address,
        "City": city,
        "Lat": lat,
        "Lng": lng,
        "carrier": carrier,
        "createdAt":
            "${createdAt?.year.toString().padLeft(4, '0')}-${createdAt?.month.toString().padLeft(2, '0')}-${createdAt?.day.toString().padLeft(2, '0')}",
        "shippingCost": shippingCost,
        "trackingId": trackingId,
        "trackingItems": trackingItems?.toJson(),
      };
}

class OrderList {
  OrderList([
    this.typename,
    this.name,
    this.value,
  ]);

  String? typename;
  String? name;
  OrderDescription? value;

  factory OrderList.fromJson(Map<String, dynamic> json) => OrderList(
        json["__typename"],
        json["name"],
        OrderDescription.fromJson(json["value"]),
      );

  Map<String, dynamic> toJson() => {
        "__typename": typename,
        "name": name,
        "value": value?.toJson(),
      };
}

class CustomerList {
  CustomerList(
    this.typename,
    this.name,
    this.value,
  );

  String? typename;
  String? name;
  Customer? value;

  factory CustomerList.fromJson(Map<String, dynamic> json) => CustomerList(
        json["__typename"],
        json["name"],
        Customer.fromJson(json["value"]),
      );

  Map<String, dynamic> toJson() => {
        "__typename": typename,
        "name": name,
        "value": value?.toJson(),
      };
}

class TrackingItemsList {
  TrackingItemsList(
    this.typename,
    this.name,
    this.value,
  );

  String? typename;
  String? name;
  TrackingItems? value;

  factory TrackingItemsList.fromJson(Map<String, dynamic> json) =>
      TrackingItemsList(
        json["__typename"],
        json["name"],
        TrackingItems.fromJson(json["value"]),
      );

  Map<String, dynamic> toJson() => {
        "__typename": typename,
        "name": name,
        "value": value?.toJson(),
      };
}
