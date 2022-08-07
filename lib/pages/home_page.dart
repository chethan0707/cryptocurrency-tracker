import 'package:crypto_tracker/pages/favourites.dart';
import 'package:crypto_tracker/pages/markets.dart';
import 'package:crypto_tracker/providers/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  late TabController tabContoller;

  @override
  void initState() {
    super.initState();
    tabContoller = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    ThemeProvider themeProvider =
        Provider.of<ThemeProvider>(context, listen: false);
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding:
              const EdgeInsets.only(top: 20, right: 20, left: 20, bottom: 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text("Welcome back", style: TextStyle(fontSize: 20)),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Crypto today",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 40,
                    ),
                  ),
                  IconButton(
                      onPressed: () {
                        themeProvider.toggleTheme();
                      },
                      icon: (themeProvider.themeMode == ThemeMode.light)
                          ? const Icon(Icons.dark_mode)
                          : const Icon(Icons.light_mode))
                ],
              ),
              TabBar(
                controller: tabContoller,
                tabs: [
                  Tab(
                    child: Text(
                      "Market",
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                  ),
                  Tab(
                    child: Text("Favorites",
                        style: Theme.of(context).textTheme.bodyText1),
                  )
                ],
              ),
              Expanded(
                child: TabBarView(
                  physics: const BouncingScrollPhysics(
                    parent: AlwaysScrollableScrollPhysics(),
                  ),
                  controller: tabContoller,
                  children: const [
                    Markets(),
                    Favourites(),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
