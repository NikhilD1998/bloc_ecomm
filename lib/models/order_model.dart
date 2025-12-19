import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';

part 'order_model.g.dart';

@HiveType(typeId: 2)
class OrderModel extends HiveObject with EquatableMixin {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String name;

  @HiveField(2)
  final String address;

  @HiveField(3)
  final String city;

  @HiveField(4)
  final String zip;

  @HiveField(5)
  final List<OrderItem> items;

  @HiveField(6)
  final double total;

  @HiveField(7)
  final DateTime date;

  OrderModel({
    required this.id,
    required this.name,
    required this.address,
    required this.city,
    required this.zip,
    required this.items,
    required this.total,
    required this.date,
  });

  @override
  List<Object?> get props => [id, name, address, city, zip, items, total, date];
}

@HiveType(typeId: 3)
class OrderItem extends HiveObject with EquatableMixin {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String title;

  @HiveField(2)
  final double price;

  @HiveField(3)
  final int quantity;

  @HiveField(4)
  final String imageUrl;

  OrderItem({
    required this.id,
    required this.title,
    required this.price,
    required this.quantity,
    required this.imageUrl,
  });

  @override
  List<Object?> get props => [id, title, price, quantity, imageUrl];
}
