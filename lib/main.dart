import 'package:crypto_tracker/constants/themes.dart';
import 'package:crypto_tracker/pages/home_page.dart';
import 'package:crypto_tracker/providers/market_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main(List<String> args) {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<MarketProvider>(
          create: ((context) => MarketProvider()),
        )
      ],
      child: MaterialApp(
          themeMode: ThemeMode.dark,
          theme: lightTheme,
          darkTheme: darkTheme,
          debugShowCheckedModeBanner: false,
          home: const HomePage()),
    );
  }
}
