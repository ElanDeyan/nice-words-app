import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';
import 'package:myapp/states/generated_words_state.dart';
import 'package:provider/provider.dart';

final class GeneratedWordText extends StatelessWidget {
  const GeneratedWordText({required WordPair wordPair, super.key})
      : _wordPair = wordPair;
  final WordPair _wordPair;

  @override
  Widget build(BuildContext context) {
    final appState = context.watch<GeneratedWords>();
    final favorites = appState.favorites;
    final isFavorite = favorites.contains(_wordPair);

    final colorScheme = Theme.of(context).colorScheme;

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        if (isFavorite) ...[
          Icon(
            Icons.favorite,
            color: colorScheme.primary,
          ),
          const SizedBox(width: 15),
        ],
        Text(
          _wordPair.asLowerCase,
          style: TextStyle(
            fontSize: 16,
            color: colorScheme.primary,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
