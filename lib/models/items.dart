import 'dart:convert';

class ItemsModel {
  List<Datum> data;

  ItemsModel({
    required this.data,
  });

  ItemsModel copyWith({
    List<Datum>? data,
  }) =>
      ItemsModel(
        data: data ?? this.data,
      );

  factory ItemsModel.fromRawJson(String str) =>
      ItemsModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ItemsModel.fromJson(Map<String, dynamic> json) => ItemsModel(
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class Datum {
  int id;
  String room;
  List<Item> items;
  int total;

  Datum({
    required this.id,
    required this.room,
    required this.items,
    required this.total,
  });

  Datum copyWith({
    int? id,
    String? room,
    List<Item>? items,
    int? total,
  }) =>
      Datum(
        id: id ?? this.id,
        room: room ?? this.room,
        items: items ?? this.items,
        total: total ?? this.total,
      );

  factory Datum.fromRawJson(String str) => Datum.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        room: json["room"],
        items: List<Item>.from(json["items"].map((x) => Item.fromJson(x))),
        total: json["total"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "room": room,
        "items": List<dynamic>.from(items.map((x) => x.toJson())),
        "total": total,
      };
}

class Item {
  int id;
  String product;
  String price;
  String qty;

  Item({
    required this.id,
    required this.product,
    required this.price,
    required this.qty,
  });

  Item copyWith({
    int? id,
    String? product,
    String? price,
    String? qty,
  }) =>
      Item(
        id: id ?? this.id,
        product: product ?? this.product,
        price: price ?? this.price,
        qty: qty ?? this.qty,
      );

  factory Item.fromRawJson(String str) => Item.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Item.fromJson(Map<String, dynamic> json) => Item(
        id: json["id"],
        product: json["product"],
        price: json["price"],
        qty: json["qty"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "product": product,
        "price": price,
        "qty": qty,
      };
}
