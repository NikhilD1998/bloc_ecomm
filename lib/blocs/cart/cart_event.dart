import 'package:equatable/equatable.dart';

abstract class CartEvent extends Equatable {
  const CartEvent();
  @override
  List<Object?> get props => [];
}

class AddItem extends CartEvent {
  final String productId;
  final int quantity;
  const AddItem(this.productId, {this.quantity = 1});
  @override
  List<Object?> get props => [productId, quantity];
}

class RemoveItem extends CartEvent {
  final String productId;
  const RemoveItem(this.productId);
  @override
  List<Object?> get props => [productId];
}

class UpdateQuantity extends CartEvent {
  final String productId;
  final int quantity;
  const UpdateQuantity(this.productId, this.quantity);
  @override
  List<Object?> get props => [productId, quantity];
}

class ClearCart extends CartEvent {}
