import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:holly_palm_case/core/constants/text_styles.dart';
import 'package:holly_palm_case/pages/product_detail_page/widgets/toast/bot_toast.dart';

import '../../../core/constants/strings.dart';
import '../providers/product_detail_provider.dart';
import '../widgets/footer.dart';
import '../widgets/product_carousel.dart';
import '../widgets/product_details.dart';

class ProductDetailPage extends ConsumerStatefulWidget {
  const ProductDetailPage({super.key});

  @override
  ConsumerState<ProductDetailPage> createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends ConsumerState<ProductDetailPage> {
  @override
  void initState() {
    super.initState();

    Future.microtask(() {
      ref
          .read(productDetailProvider("gid://shopify/Product/8740231577837")
              .notifier)
          .fetchProductDetail(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    final productState =
        ref.watch(productDetailProvider("gid://shopify/Product/8740231577837"));

    return Scaffold(
      body: productState.isLoading
          ? const Center(child: CircularProgressIndicator())
          : productState.errorMessage != null
              ? Center(
                  child: Text(
                  productState.errorMessage!,
                  style: AppTextStyle.bodyM,
                ))
              : const _ProductDetailBody(
                  productId: "gid://shopify/Product/8740231577837"),
      bottomNavigationBar: (productState.product?.variants.isNotEmpty ?? false)
          ? ProductDetailFooter(
              price: productState.product!.variants.first.price,
              buttonText: Strings.addToCart,
              onAddToCart: () => showToast(Strings.cartSuccessMessage,
                  toastType: ToastType.success),
            )
          : null, //
    );
  }
}

class _ProductDetailBody extends StatelessWidget {
  final String productId;

  const _ProductDetailBody({required this.productId});

  @override
  Widget build(BuildContext context) {
    return NotificationListener<ScrollNotification>(
      onNotification: (scrollNotification) => false,
      child: CustomScrollView(
        slivers: [
          _ProductDetailAppBar(productId: productId),
          SliverToBoxAdapter(child: ProductDetails(productId: productId)),
        ],
      ),
    );
  }
}

class _ProductDetailAppBar extends ConsumerWidget {
  final String productId;

  const _ProductDetailAppBar({required this.productId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final productState = ref.watch(productDetailProvider(productId));
    final product = productState.product;
    final carouselIndex = ref.watch(carouselIndexProvider(productId));

    return SliverAppBar(
      expandedHeight: MediaQuery.of(context).size.height * 0.47,
      collapsedHeight: kToolbarHeight,
      floating: false,
      pinned: false,
      flexibleSpace: FlexibleSpaceBar(
        background: ProductCarousel(
          imageUrls: product?.images ?? [],
          currentIndex: carouselIndex,
        ),
      ),
    );
  }
}
