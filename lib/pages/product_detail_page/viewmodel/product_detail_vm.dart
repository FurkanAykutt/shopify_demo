import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/services/product_service.dart';
import '../providers/product_detail_provider.dart';

class ProductDetailViewModel extends StateNotifier<ProductDetailState> {
  final String productId;
  final ProductService _productService = ProductService();

  ProductDetailViewModel(this.productId) : super(const ProductDetailState());

  /// **📌 Ürün Detaylarını API'den Çek**
  Future<void> fetchProductDetail(BuildContext context) async {
    state = state.copyWith(isLoading: true, errorMessage: null);

    try {
      final product =
          await _productService.getProductDetail(context, productId);

      if (product != null) {
        state = state.copyWith(
          product: product,
          isLoading: false,
        );
      } else {
        state = state.copyWith(
          isLoading: false,
          errorMessage: "Ürün detayları alınamadı.",
        );
      }
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        errorMessage: "Bir hata oluştu: ${e.toString()}",
      );
    }
  }
}
