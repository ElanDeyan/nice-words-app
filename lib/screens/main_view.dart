import 'dart:async';

import 'package:flutter/material.dart';
import 'package:myapp/screens/favorites_page.dart';
import 'package:myapp/screens/generator_page.dart';
import 'package:myapp/states/preferences.dart';
import 'package:provider/provider.dart';

final class MainView extends StatefulWidget {
  const MainView({super.key});

  @override
  State<MainView> createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  int selectedIndex = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final Widget page = switch (selectedIndex) {
      0 => const GeneratorPage(),
      1 => const FavoritesPage(),
      2 => const Placeholder(),
      _ => throw UnimplementedError('no widget for $selectedIndex'),
    };

    final appPreferences = Provider.of<AppPreferences>(context);

    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          IconButton(
            onPressed: () => scheduleMicrotask(() {
              appPreferences.toggleThemeMode();
            }),
            icon: const Icon(Icons.brightness_auto),
          ),
          const SizedBox(
            width: 10,
          ),
          IconButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => const Placeholder()),
              );
            },
            icon: const Icon(Icons.settings),
          ),
        ],
      ),
      body: ColoredBox(
        color: Theme.of(context).colorScheme.primaryContainer,
        child: page,
      ),
      bottomNavigationBar: NavigationBar(
        destinations: const <Widget>[
          NavigationDestination(icon: Icon(Icons.home), label: "Home"),
          NavigationDestination(icon: Icon(Icons.favorite), label: "Favorites"),
        ],
        selectedIndex: selectedIndex,
        onDestinationSelected: (value) => setState(
          () {
            selectedIndex = value;
          },
        ),
      ),
    );
  }
}
