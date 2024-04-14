import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';
import 'package:myapp/components/generated_word_text.dart';

final class GeneratedWordsHistory extends StatelessWidget {
  const GeneratedWordsHistory({
    super.key,
    required this.generatedWords,
  });

  final List<WordPair> generatedWords;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20),
      child: SingleChildScrollView(
        reverse: true,
        controller: ScrollController(),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            for (final word in generatedWords) ...[
              GeneratedWordText(wordPair: word),
              const SizedBox(
                height: 15,
              ),
            ],
          ],
        ),
      ),
    );
  }
}
