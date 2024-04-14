import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';

final class BigCard extends StatelessWidget {
  const BigCard({super.key, required this.pair});

  final WordPair pair;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textStyle = theme.textTheme.displayMedium!.copyWith(
      color: theme.colorScheme.onPrimary,
    );

    return Card(
      color: theme.colorScheme.primary,
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text(
              pair.first,
              style: textStyle.copyWith(
                fontWeight: FontWeight.w100,
              ),
              semanticsLabel: pair.first,
            ),
            Text(
              pair.second,
              style: textStyle.copyWith(
                fontWeight: FontWeight.bold,
              ),
              semanticsLabel: pair.second,
            ),
          ],
        ),
      ),
    );
  }
}
