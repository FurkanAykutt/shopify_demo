import 'package:graphql_flutter/graphql_flutter.dart';

class ShopifyGraphQLClient {
  static const String _apiUrl =
      "https://hollypalm-test.myshopify.com/api/2025-01/graphql.json";
  static const String _accessToken = "00e75e3bfd60f9cbb0d4f357c372d2b0";

  static final HttpLink _httpLink = HttpLink(
    _apiUrl,
    defaultHeaders: {
      "X-Shopify-Storefront-Access-Token": _accessToken,
      "Content-Type": "application/json",
    },
  );

  static final GraphQLClient _client = GraphQLClient(
    link: _httpLink,
    cache: GraphQLCache(),
  );

  static GraphQLClient get client => _client;
}
