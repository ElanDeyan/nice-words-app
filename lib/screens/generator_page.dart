import 'package:flutter/material.dart';
import 'package:myapp/components/generated_words_history.dart';
import 'package:myapp/components/word_actions.dart';
import 'package:myapp/states/generated_words_state.dart';
import 'package:provider/provider.dart';

final class GeneratorPage extends StatelessWidget {
  const GeneratorPage();

  @override
  Widget build(BuildContext context) {
    final appState = context.watch<GeneratedWords>();
    final generatedWords = appState.wordPairHistory;

    return Center(
      child: Column(
        children: [
          if (generatedWords.isNotEmpty)
            Expanded(
              flex: 4,
              child: GeneratedWordsHistory(
                generatedWords: generatedWords,
              ),
            ),
          Expanded(
            flex: generatedWords.isNotEmpty ? 6 : 1,
            child: const WordActions(),
          ),
        ],
      ),
    );
  }
}
