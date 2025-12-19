import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'product_event.dart';
import 'product_state.dart';
import '../../helpers/dummy_data.dart';
import '../../models/product_model.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  ProductBloc() : super(ProductLoading()) {
    on<LoadProducts>(_onLoadProducts);
    on<RefreshProducts>(_onRefreshProducts);
  }

  Future<void> _onLoadProducts(
    LoadProducts event,
    Emitter<ProductState> emit,
  ) async {
    emit(ProductLoading());
    await Future.delayed(const Duration(seconds: 1)); // Simulate API delay
    try {
      final products = dummyProducts
          .map((e) => ProductModel.fromMap(e))
          .toList();
      emit(ProductLoaded(products));
    } catch (e) {
      emit(const ProductError('Failed to load products.'));
    }
  }

  Future<void> _onRefreshProducts(
    RefreshProducts event,
    Emitter<ProductState> emit,
  ) async {
    emit(ProductLoading());
    await Future.delayed(const Duration(seconds: 1));
    try {
      final products = dummyProducts
          .map((e) => ProductModel.fromMap(e))
          .toList();
      emit(ProductLoaded(products));
    } catch (e) {
      emit(const ProductError('Failed to refresh products.'));
    }
  }
}
