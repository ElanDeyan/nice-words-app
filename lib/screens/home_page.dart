import 'package:flutter/material.dart';
import 'package:myapp/screens/favorites_page.dart';
import 'package:myapp/screens/generator_page.dart';

final class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    final Widget page = switch (selectedIndex) {
      0 => const GeneratorPage(),
      1 => const FavoritesPage(),
      _ => throw UnimplementedError('no widget for $selectedIndex'),
    };
    return LayoutBuilder(
      builder: (context, constraints) {
        return Scaffold(
          body: Row(
            children: <Widget>[
              SafeArea(
                child: NavigationRail(
                  extended: constraints.maxWidth >= 600,
                  destinations: const <NavigationRailDestination>[
                    NavigationRailDestination(
                      icon: Icon(Icons.home),
                      label: Text(
                        "Home",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    NavigationRailDestination(
                      icon: Icon(Icons.favorite),
                      label: Text(
                        "Favorites",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                  selectedIndex: selectedIndex,
                  onDestinationSelected: (int value) => setState(() {
                    selectedIndex = value;
                  }),
                ),
              ),
              Expanded(
                child: ColoredBox(
                  color: Theme.of(context).colorScheme.primaryContainer,
                  child: page,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
