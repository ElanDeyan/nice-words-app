import 'package:flutter/material.dart';
import 'package:myapp/components/big_card.dart';
import 'package:myapp/states/my_app_global_state.dart';
import 'package:provider/provider.dart';

final class GeneratorPage extends StatelessWidget {
  const GeneratorPage();

  @override
  Widget build(BuildContext context) {
    final appState = context.watch<MyAppGlobalState>();
    final pair = appState.currentWordPair;

    final isFavorited = appState.favorites.contains(pair);
    final icon = isFavorited ? Icons.favorite : Icons.favorite_border;
    final label = isFavorited ? 'Unfavorite' : 'Favorite';

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          BigCard(pair: pair),
          const SizedBox(height: 10),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ElevatedButton(
                onPressed: () => appState.toggleFavorites(pair),
                child: Row(
                  children: <Widget>[
                    Icon(icon),
                    const SizedBox(width: 4),
                    Text(label),
                  ],
                ),
              ),
              const SizedBox(width: 10),
              ElevatedButton(
                onPressed: () => appState.nextWord(),
                child: const Text('Next'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
