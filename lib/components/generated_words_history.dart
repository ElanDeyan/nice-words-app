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
      child: ListView.builder(
        clipBehavior: Clip.antiAliasWithSaveLayer,
        reverse: true,
        shrinkWrap: true,
        controller: ScrollController(),
        itemCount: generatedWords.length,
        itemBuilder: (context, index) => Center(
          child: GeneratedWordText(
            wordPair: generatedWords[index],
          ),
        ),
      ),
    );
  }
}
