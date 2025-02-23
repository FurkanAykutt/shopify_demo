import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:holly_palm_case/core/extensions/build_context_ext.dart';

class ProductCarousel extends StatelessWidget {
  final List<String> imageUrls;
  final int currentIndex;

  const ProductCarousel(
      {super.key, required this.imageUrls, required this.currentIndex});

  @override
  Widget build(BuildContext context) {
    //? IOS Cihazlarda Dynamic Island alanı olduğu için safe area kullandım. O sebeple tasarımdan farklı.
    return imageUrls.isEmpty
        ? _buildPlaceholder(context)
        : SafeArea(
            child: Stack(
              children: [
                _buildCarouselSlider(imageUrls, context),
                Positioned(
                    bottom: 15,
                    right: 0,
                    left: 0,
                    child: _PageIndicator(
                      currentIndex: currentIndex,
                      itemCount: imageUrls.length,
                    ))
              ],
            ),
          );
  }

  Widget _buildCarouselSlider(List<String> imageUrls, BuildContext context) {
    return CarouselSlider.builder(
      itemCount: imageUrls.length,
      itemBuilder: (context, index, realIndex) {
        return _buildImage(imageUrls[index]);
      },
      options: CarouselOptions(
        height: context.height * .47,
        autoPlay: imageUrls.length > 1,
        viewportFraction: 1.0,
        enlargeCenterPage: false,
        enableInfiniteScroll: imageUrls.length > 1,
      ),
    );
  }

  Widget _buildImage(String imageUrl) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        image:
            DecorationImage(image: NetworkImage(imageUrl), fit: BoxFit.cover),
      ),
    );
  }

  Widget _buildPlaceholder(BuildContext context) {
    return Container(
      width: double.infinity,
      height: context.height * .47,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.grey[300],
      ),
      child: const Center(
        child: Icon(Icons.image_not_supported, size: 60, color: Colors.grey),
      ),
    );
  }
}

class _PageIndicator extends StatelessWidget {
  final int currentIndex;
  final int itemCount;

  const _PageIndicator({required this.currentIndex, required this.itemCount});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        itemCount,
        (index) => AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          margin: const EdgeInsets.symmetric(horizontal: 4.0),
          width: currentIndex == index ? 16.0 : 8.0,
          height: 8.0,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.0),
            border: Border.all(width: 1, color: Colors.white),
            color: currentIndex == index
                ? Colors.black
                : Colors.black.withOpacity(0.5),
          ),
        ),
      ),
    );
  }
}
