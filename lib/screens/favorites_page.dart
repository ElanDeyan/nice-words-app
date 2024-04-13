import 'package:flutter/material.dart';
import 'package:myapp/states/my_app_global_state.dart';
import 'package:provider/provider.dart';

final class FavoritesPage extends StatelessWidget {
  const FavoritesPage({super.key});

  @override
  Widget build(BuildContext context) {
    final appState = context.watch<MyAppGlobalState>();

    if (appState.favorites.isEmpty) {
      return const Center(
        child: Text(
          'No favorites',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      );
    }

    final colorScheme = Theme.of(context).colorScheme;
    final favorites = appState.favorites.toList();
    return ListView(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Center(
            child: Text(
              "You have ${favorites.length} favorites:",
              style: const TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        for (final favorite in favorites)
          Card(
            color: colorScheme.primary,
            child: ListTile(
              leading: Icon(
                Icons.favorite,
                color: colorScheme.onPrimary,
              ),
              title: Text(
                favorite.asCamelCase,
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onPrimary,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
      ],
    );
  }
}
