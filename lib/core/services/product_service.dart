import 'package:flutter/material.dart';

import '../graphql/queries/product_detail_queries.dart';
import '../models/product_model.dart';
import '../network/base_request.dart';

class ProductService {
  Future<ProductModel?> getProductDetail(
      BuildContext context, String productId) async {
    return await BaseRequest().execute<ProductModel>(
      context: context,
      query: ProductQueries.getProductDetail(productId),
      fromJson: (data) => ProductModel.fromJson(data['product']),
    );
  }
}
