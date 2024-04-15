import 'package:flutter/material.dart';
import 'package:myapp/screens/favorites_page.dart';
import 'package:myapp/screens/generator_page.dart';
import 'package:myapp/states/preferences.dart';
import 'package:provider/provider.dart';

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

    final appPreferences = Provider.of<AppPreferences>(context);

    final changeThemeIcon = switch (appPreferences.themeMode) {
      ThemeMode.light => Icons.light_mode,
      ThemeMode.dark => Icons.dark_mode,
      ThemeMode.system => Icons.brightness_auto,
    };

    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          IconButton(
            onPressed: () => appPreferences.toggleThemeMode(),
            icon: Icon(changeThemeIcon),
          ),
          const SizedBox(
            width: 10,
          ),
          const IconButton(onPressed: null, icon: Icon(Icons.settings)),
        ],
      ),
      body: Expanded(
        child: ColoredBox(
          color: Theme.of(context).colorScheme.primaryContainer,
          child: page,
        ),
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
