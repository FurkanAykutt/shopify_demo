class ProductQueries {
  static String getProductDetail(String productId) {
    return '''
      query {
        product(id: "$productId") {
          id
          title
          descriptionHtml
          vendor
          images(first: 5) {
            edges {
              node {
                url
              }
            }
          }
          options(first: 5){
          
          }
          variants(first: 5) {
            edges {
              node {
                id
                title
                availableForSale
                price {
                  amount
                  currencyCode
                }
              }
            }
          }
        }
      }
    ''';
  }
}
