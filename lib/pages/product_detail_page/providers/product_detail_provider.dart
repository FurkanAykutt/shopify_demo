import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/models/product_model.dart';
import '../viewmodel/product_detail_vm.dart';

class ProductDetailState {
  final ProductModel? product;
  final bool isLoading;
  final String? errorMessage;

  const ProductDetailState({
    this.product,
    this.isLoading = false,
    this.errorMessage,
  });

  ProductDetailState copyWith({
    ProductModel? product,
    bool? isLoading,
    String? errorMessage,
  }) {
    return ProductDetailState(
      product: product ?? this.product,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}

final productDetailProvider = StateNotifierProvider.autoDispose
    .family<ProductDetailViewModel, ProductDetailState, String>(
  (ref, productId) => ProductDetailViewModel(productId),
);

final carouselIndexProvider =
    StateProvider.family<int, String>((ref, productId) {
  return 0;
});

final favoriteProvider = StateProvider.family<bool, String>((ref, productId) {
  return false;
});

final variantIndexProvider =
    StateProvider.family<int, String>((ref, productId) {
  return 0;
});
