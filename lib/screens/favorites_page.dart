import 'package:flutter/material.dart';
import 'package:myapp/states/generated_words_state.dart';
import 'package:provider/provider.dart';

final class FavoritesPage extends StatefulWidget {
  const FavoritesPage({super.key});

  @override
  State<FavoritesPage> createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage> {
  @override
  Widget build(BuildContext context) {
    final appState = context.watch<GeneratedWords>();

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

    final favorites = appState.favorites;

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Center(
        child: Column(
          children: <Widget>[
            Text(
              'You have ${favorites.length} favorites:',
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            Flexible(
              fit: FlexFit.tight,
              child: GridView.count(
                crossAxisCount: 2,
                mainAxisSpacing: 1,
                crossAxisSpacing: 1,
                children: favorites
                    .map(
                      (e) => Row(
                        children: [
                          IconButton(
                            onPressed: () => setState(() {
                              appState.deleteFavorite(e);
                            }),
                            icon: const Icon(Icons.delete_forever),
                          ),
                          Text(
                            e.asLowerCase,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    )
                    .toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
