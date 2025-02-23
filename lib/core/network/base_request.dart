import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

import '../constants/text_styles.dart';
import '../graphql/graphql_client.dart';

class BaseRequest {
  static final BaseRequest _instance = BaseRequest._internal();
  factory BaseRequest() => _instance;
  BaseRequest._internal();

  final GraphQLClient _client = ShopifyGraphQLClient.client;

  Future<T?> execute<T>({
    required BuildContext context,
    required String query,
    Map<String, dynamic>? variables,
    bool isMutation = false,
    required T Function(Map<String, dynamic>) fromJson,
    bool showError = true,
  }) async {
    debugPrint(
        "📡 GraphQL Request: ${isMutation ? "MUTATION" : "QUERY"} \n$query");
    debugPrint("📡 Variables: ${variables ?? {}}");

    QueryResult result;
    try {
      result = await _performRequest(query, variables, isMutation);
    } catch (e) {
      _logError("🚨 Network Hatası: $e");
      if (showError && context.mounted) {
        _showError(context, "Bağlantı hatası oluştu.");
      }
      return null;
    }

    if (result.hasException) {
      _logError(result.exception.toString());
      if (showError && context.mounted) {
        _showError(
            context, "Bağlantı hatası. Lütfen internetinizi kontrol edin.");
      }
      return null;
    }

    if (result.data == null || result.data?['errors'] != null) {
      String errorMessage = result.data?['errors']?[0]['message'] ??
          "Beklenmeyen bir hata oluştu.";
      _logError(errorMessage);
      if (showError && context.mounted) _showError(context, errorMessage);
      return null;
    }

    final userErrors = result.data!.values
        .where((value) => value is Map && value.containsKey('userErrors'))
        .map((value) => value['userErrors'])
        .expand((errors) => errors)
        .toList();

    if (userErrors.isNotEmpty) {
      String errorMessage = userErrors.first['message'] ?? "Geçersiz işlem!";
      _logError(errorMessage);
      if (showError && context.mounted) _showError(context, errorMessage);
      return null;
    }

    debugPrint("✅ Başarılı yanıt alındı!");
    return fromJson(result.data!);
  }

  Future<QueryResult> _performRequest(
      String query, Map<String, dynamic>? variables, bool isMutation) async {
    return isMutation
        ? await _client.mutate(
            MutationOptions(document: gql(query), variables: variables ?? {}))
        : await _client.query(
            QueryOptions(document: gql(query), variables: variables ?? {}));
  }

  void _showError(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
          content: Text(
            message,
            style: AppTextStyle.bodyS,
          ),
          backgroundColor: Colors.red),
    );
  }

  void _logError(String message) {
    debugPrint("❌ GraphQL Hatası: $message");
  }
}
