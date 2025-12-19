import 'package:flutter_bloc/flutter_bloc.dart';
import 'cart_event.dart';
import 'cart_state.dart';
import 'package:hive/hive.dart';
import '../../helpers/dummy_data.dart';

const _cartBoxName = 'cartBox';

class CartBloc extends Bloc<CartEvent, CartState> {
  CartBloc() : super(CartLoading()) {
    on<AddItem>(_onAddItem);
    on<RemoveItem>(_onRemoveItem);
    on<UpdateQuantity>(_onUpdateQuantity);
    on<ClearCart>(_onClearCart);
    _loadCart();
  }

  Future<void> _loadCart() async {
    emit(CartLoading());
    final box = await Hive.openBox(_cartBoxName);
    final items = box.get('items', defaultValue: []) as List<dynamic>;
    emit(_calculateState(items.cast<CartItem>()));
  }

  Future<void> _onAddItem(AddItem event, Emitter<CartState> emit) async {
    print(
      'CartBloc: AddItem event received for productId=${event.productId}, quantity=${event.quantity}',
    );
    final box = await Hive.openBox(_cartBoxName);
    List<CartItem> items = (box.get('items', defaultValue: []) as List<dynamic>)
        .cast<CartItem>();
    print('CartBloc: Current items before add: $items');
    final product = dummyProducts.firstWhere((p) => p['id'] == event.productId);
    final existing = items.where((i) => i.id == event.productId).toList();
    if (existing.isNotEmpty) {
      items = items
          .map(
            (i) => i.id == event.productId
                ? i.copyWith(quantity: i.quantity + event.quantity)
                : i,
          )
          .toList();
      print('CartBloc: Updated quantity for existing item.');
    } else {
      items.add(
        CartItem(
          id: product['id'],
          title: product['title'],
          price: product['price'],
          imageUrl: product['imageUrl'],
          quantity: event.quantity,
        ),
      );
      print('CartBloc: Added new item to cart.');
    }
    await box.put('items', items);
    print('CartBloc: Items after add: $items');
    emit(_calculateState(items));
  }

  Future<void> _onRemoveItem(RemoveItem event, Emitter<CartState> emit) async {
    print('CartBloc: RemoveItem event for productId=${event.productId}');
    final box = await Hive.openBox(_cartBoxName);
    List<CartItem> items = (box.get('items', defaultValue: []) as List<dynamic>)
        .cast<CartItem>();
    items.removeWhere((i) => i.id == event.productId);
    await box.put('items', items);
    emit(_calculateState(items));
  }

  Future<void> _onUpdateQuantity(
    UpdateQuantity event,
    Emitter<CartState> emit,
  ) async {
    print(
      'CartBloc: UpdateQuantity event for productId=${event.productId}, quantity=${event.quantity}',
    );
    final box = await Hive.openBox(_cartBoxName);
    List<CartItem> items = (box.get('items', defaultValue: []) as List<dynamic>)
        .cast<CartItem>();
    items = items
        .map(
          (i) => i.id == event.productId
              ? i.copyWith(quantity: event.quantity < 1 ? 1 : event.quantity)
              : i,
        )
        .toList();
    await box.put('items', items);
    emit(_calculateState(items));
  }

  Future<void> _onClearCart(ClearCart event, Emitter<CartState> emit) async {
    print('CartBloc: ClearCart event');
    final box = await Hive.openBox(_cartBoxName);
    await box.put('items', []);
    emit(_calculateState([]));
  }

  CartLoaded _calculateState(List<CartItem> items) {
    final subtotal = items.fold(0.0, (sum, i) => sum + i.price * i.quantity);
    final tax = subtotal * 0.05;
    final total = subtotal + tax;
    return CartLoaded(items: items, subtotal: subtotal, tax: tax, total: total);
  }
}
