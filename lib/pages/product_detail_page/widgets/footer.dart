import 'package:flutter/material.dart';
import 'package:holly_palm_case/core/extensions/build_context_ext.dart';

import '../../../core/constants/text_styles.dart';

class ProductDetailFooter extends StatelessWidget {
  final String price;
  final String buttonText;
  final VoidCallback onAddToCart;

  const ProductDetailFooter({
    super.key,
    required this.price,
    required this.buttonText,
    required this.onAddToCart,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: const BoxDecoration(
        color: Colors.white,
        boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 5.0)],
      ),
      child: SafeArea(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(price, style: AppTextStyle.price),
            InkWell(
              onTap: onAddToCart,
              child: Container(
                alignment: Alignment.center,
                width: context.width * .4,
                height: context.height * .055,
                color: Colors.black,
                child: Text(buttonText, style: AppTextStyle.buttonText),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
