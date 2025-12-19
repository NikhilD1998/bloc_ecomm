import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';

part 'cart_state.g.dart';

@HiveType(typeId: 0)
class CartItem extends Equatable {
  @HiveField(0)
  final String id;
  @HiveField(1)
  final String title;
  @HiveField(2)
  final double price;
  @HiveField(3)
  final String imageUrl;
  @HiveField(4)
  final int quantity;

  const CartItem({
    required this.id,
    required this.title,
    required this.price,
    required this.imageUrl,
    required this.quantity,
  });

  CartItem copyWith({int? quantity}) => CartItem(
    id: id,
    title: title,
    price: price,
    imageUrl: imageUrl,
    quantity: quantity ?? this.quantity,
  );

  @override
  List<Object?> get props => [id, title, price, imageUrl, quantity];
}

abstract class CartState extends Equatable {
  const CartState();
  @override
  List<Object?> get props => [];
}

class CartLoading extends CartState {}

class CartLoaded extends CartState {
  final List<CartItem> items;
  final double subtotal;
  final double tax;
  final double total;

  const CartLoaded({
    required this.items,
    required this.subtotal,
    required this.tax,
    required this.total,
  });

  @override
  List<Object?> get props => [items, subtotal, tax, total];
}

class CartError extends CartState {
  final String message;
  const CartError(this.message);
  @override
  List<Object?> get props => [message];
}
