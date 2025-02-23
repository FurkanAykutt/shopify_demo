import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:holly_palm_case/core/extensions/build_context_ext.dart';
import 'package:html/parser.dart' as html_parser;

import '../../../core/constants/strings.dart';
import '../../../core/constants/text_styles.dart';
import '../../../core/models/product_model.dart';
import '../providers/product_detail_provider.dart';

class ProductDetails extends ConsumerWidget {
  final String productId;

  const ProductDetails({super.key, required this.productId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final productState = ref.watch(productDetailProvider(productId));

    if (productState.isLoading) {
      return const Center(child: CircularProgressIndicator());
    } else if (productState.errorMessage != null) {
      return Center(
          child: Text(productState.errorMessage!, style: AppTextStyle.bodyM));
    } else if (productState.product == null) {
      return const Center(
          child: Text(Strings.productNotLoaded, style: AppTextStyle.bodyM));
    }

    return _buildProductDetails(context, ref, productState.product!);
  }
}

Widget _buildProductDetails(
    BuildContext context, WidgetRef ref, ProductModel product) {
  return Padding(
    padding: const EdgeInsets.all(16.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _ProductHeader(product: product),
        _variants(context, ref, product),
        const Divider(),
        _buildProductInfo(product),
      ],
    ),
  );
}

Widget _buildProductInfo(ProductModel product) {
  return Column(
    children: [
      _CustomExpansionTile(
        title: Strings.productDetails,
        children: [
          Text(
            html_parser.parse(product.descriptionHtml).body!.text,
            style: AppTextStyle.bodyS,
          ),
        ],
      ),
      const _CustomExpansionTile(
        title: Strings.installmentOptions,
        children: [
          Text(
            "Taksit Seçenekleri API'de yok.",
            style: AppTextStyle.bodyS,
          )
        ],
      ),
      const _CustomExpansionTile(
        title: Strings.returnAndDelivery,
        children: [
          Text(
            "İade, İptal ve Teslimat Koşulları API'de yok.",
            style: AppTextStyle.bodyS,
          )
        ],
      ),
      const _CustomExpansionTile(
        title: Strings.share,
        children: [
          Text(
            "Ürün linki API'de yok.",
            style: AppTextStyle.bodyS,
          )
        ],
      ),
    ],
  );
}

Widget _variants(BuildContext context, WidgetRef ref, ProductModel product) {
  final selectedVariantIndex = ref.watch(variantIndexProvider(product.id));
  final variantNotifier = ref.read(variantIndexProvider(product.id).notifier);

  return Container(
    height: context.height * .1,
    margin: EdgeInsets.symmetric(vertical: context.height * .022),
    child: ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: product.variants.length,
      itemBuilder: (context, index) {
        final variant = product.variants[index];

        return variant.availableForSale
            ? GestureDetector(
                onTap: () => variantNotifier.state = index,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4.0),
                  child: Column(
                    children: [
                      Container(
                        width: context.height * .075,
                        height: context.height * .075,
                        padding: const EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: selectedVariantIndex == index
                                ? Colors.black
                                : Colors.transparent,
                            width: 1,
                          ),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Image.network(
                          product.images.first,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) =>
                              _buildPlaceholder(),
                        ),
                      ),
                      const SizedBox(height: 4),
                      SizedBox(
                        width: context.height * .075,
                        child: Text(
                          variant.title,
                          style: AppTextStyle.bodyS.copyWith(
                            fontWeight: selectedVariantIndex == index
                                ? FontWeight.bold
                                : FontWeight.normal,
                          ),
                          textAlign: TextAlign.center,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ),
              )
            : const SizedBox.shrink();
      },
    ),
  );
}

class _CustomExpansionTile extends StatelessWidget {
  final String title;
  final List<Widget> children;

  const _CustomExpansionTile({
    required this.title,
    required this.children,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Theme(
          data: ThemeData(dividerColor: Colors.transparent),
          child: ExpansionTile(
            title: Text(
              title,
              style: AppTextStyle.bodyM,
            ),
            expandedAlignment: Alignment.centerLeft,
            childrenPadding: EdgeInsets.zero,
            tilePadding: EdgeInsets.zero,
            children: children,
          ),
        ),
        const Divider(),
      ],
    );
  }
}

Widget _buildPlaceholder() {
  return Container(
    width: 50,
    height: 50,
    decoration: BoxDecoration(
      color: Colors.grey[300],
      borderRadius: BorderRadius.circular(8),
    ),
    child: const Icon(Icons.image_not_supported, color: Colors.grey),
  );
}

class _ProductHeader extends ConsumerWidget {
  final ProductModel product;

  const _ProductHeader({required this.product});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isFavorite = ref.watch(favoriteProvider(product.id));
    final favoriteNotifier = ref.read(favoriteProvider(product.id).notifier);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          product.vendor,
          style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Text(
                product.title,
                style: AppTextStyle.productTitle,
              ),
            ),
            IconButton(
              icon: Icon(
                isFavorite ? Icons.favorite : Icons.favorite_border,
                color: isFavorite ? Colors.red : Colors.grey,
              ),
              onPressed: () => favoriteNotifier.state = !isFavorite,
            ),
          ],
        ),
      ],
    );
  }
}
