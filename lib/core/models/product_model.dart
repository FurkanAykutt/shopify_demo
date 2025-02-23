class ProductModel {
  final String id;
  final String title;
  final String descriptionHtml;
  final String vendor;
  final List<String> images;
  final List<ProductVariant> variants;

  ProductModel({
    required this.id,
    required this.title,
    required this.descriptionHtml,
    required this.vendor,
    required this.images,
    required this.variants,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'],
      title: json['title'],
      descriptionHtml: json['descriptionHtml'] ?? "",
      vendor: json['vendor'],
      images: (json['images']['edges'] as List)
          .map((e) => e['node']['url'].toString())
          .toList(),
      variants: (json['variants']['edges'] as List)
          .map((e) => ProductVariant.fromJson(e['node']))
          .toList(),
    );
  }
}

class ProductVariant {
  final String id;
  final String title;
  final String price;
  final bool availableForSale;

  ProductVariant({
    required this.id,
    required this.title,
    required this.price,
    required this.availableForSale,
  });

  factory ProductVariant.fromJson(Map<String, dynamic> json) {
    return ProductVariant(
      id: json['id'],
      title: json['title'],
      price: "${json['price']['amount']} ${json['price']['currencyCode']}",
      availableForSale: json['availableForSale'],
    );
  }
}
