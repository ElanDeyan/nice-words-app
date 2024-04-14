import 'package:flutter/material.dart';
import 'package:myapp/components/big_card.dart';
import 'package:myapp/states/generated_words_state.dart';
import 'package:provider/provider.dart';

final class WordActions extends StatelessWidget {
  const WordActions({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final appState = context.watch<GeneratedWords>();
    final pair = appState.currentWordPair;
    final icon = appState.favorites.contains(pair)
        ? Icons.favorite
        : Icons.favorite_border;
    final label = appState.favorites.contains(pair) ? 'Dislike' : 'Like';

    return Column(
      mainAxisAlignment: appState.generatedWords.isEmpty
          ? MainAxisAlignment.center
          : MainAxisAlignment.start,
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
                  const SizedBox(width: 5),
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
    );
  }
}
