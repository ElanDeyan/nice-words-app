import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';
import 'package:myapp/states/generated_words_state.dart';
import 'package:provider/provider.dart';

final class GeneratedWordText extends StatelessWidget {
  const GeneratedWordText({required this.wordPair, super.key});
  final WordPair wordPair;

  @override
  Widget build(BuildContext context) {
    final appState = context.watch<GeneratedWords>();
    final favorites = appState.favorites;
    final isFavorite = favorites.contains(wordPair);

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
          wordPair.asLowerCase,
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
