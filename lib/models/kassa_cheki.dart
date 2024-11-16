import 'package:meta/meta.dart';
import 'dart:convert';

class KassaChekiModel {
  bool status;
  String brand;
  String phone;
  String address;
  List<Order> orders;
  String date;

  KassaChekiModel({
    required this.status,
    required this.brand,
    required this.phone,
    required this.address,
    required this.orders,
    required this.date,
  });

  KassaChekiModel copyWith({
    bool? status,
    String? brand,
    String? phone,
    String? address,
    List<Order>? orders,
    String? date,
  }) =>
      KassaChekiModel(
        status: status ?? this.status,
        brand: brand ?? this.brand,
        phone: phone ?? this.phone,
        address: address ?? this.address,
        orders: orders ?? this.orders,
        date: date ?? this.date,
      );

  factory KassaChekiModel.fromRawJson(String str) => KassaChekiModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory KassaChekiModel.fromJson(Map<String, dynamic> json) => KassaChekiModel(
    status: json["status"],
    brand: json["brand"],
    phone: json["phone"],
    address: json["address"],
    orders: List<Order>.from(json["orders"].map((x) => Order.fromJson(x))),
    date: json["date"],
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "brand": brand,
    "phone": phone,
    "address": address,
    "orders": List<dynamic>.from(orders.map((x) => x.toJson())),
    "date": date,
  };
}

class Order {
  int id;
  String room;
  List<Item> items;
  int total;

  Order({
    required this.id,
    required this.room,
    required this.items,
    required this.total,
  });

  Order copyWith({
    int? id,
    String? room,
    List<Item>? items,
    int? total,
  }) =>
      Order(
        id: id ?? this.id,
        room: room ?? this.room,
        items: items ?? this.items,
        total: total ?? this.total,
      );

  factory Order.fromRawJson(String str) => Order.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Order.fromJson(Map<String, dynamic> json) => Order(
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
