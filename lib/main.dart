import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'core/theme/app_theme.dart';
import 'pages/product_detail_page/page/product_detail_page.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Holly Palm Case',
      theme: AppTheme.lightTheme,
      builder: BotToastInit(),
      navigatorObservers: [BotToastNavigatorObserver()],
      home: const ProductDetailPage(),
    );
  }
}
