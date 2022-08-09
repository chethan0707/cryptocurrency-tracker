import 'package:crypto_tracker/constants/themes.dart';
import 'package:crypto_tracker/models/local_storage.dart';
import 'package:crypto_tracker/pages/home_page.dart';
import 'package:crypto_tracker/providers/market_provider.dart';
import 'package:crypto_tracker/providers/news_provider.dart';
import 'package:crypto_tracker/providers/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main(List<String> args) async {
  WidgetsFlutterBinding.ensureInitialized();
  String currentTheme = await LocalStorage.getTheme() ?? "light";
  runApp(MyApp(
    theme: currentTheme,
  ));
}

class MyApp extends StatelessWidget {
  final String theme;
  const MyApp({Key? key, required this.theme}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<MarketProvider>(
          create: ((context) => MarketProvider()),
        ),
        ChangeNotifierProvider(
          create: (context) => ThemeProvider(theme),
        ),
        ChangeNotifierProvider(
          create: (context) => NewsProvider(),
        ),
      ],
      child: Consumer<ThemeProvider>(builder: (context, themeData, child) {
        return MaterialApp(
          themeMode: themeData.themeMode,
          theme: lightTheme,
          darkTheme: darkTheme,
          debugShowCheckedModeBanner: false,
          home: const HomePage(),
        );
      }),
    );
  }
}
