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
      child: ShaderMask(
        blendMode: BlendMode.dstOut,
        shaderCallback: (bounds) => LinearGradient(
          colors: [
            Theme.of(context).colorScheme.primary,
            Colors.transparent,
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          stops: const [
            0.0,
            0.7,
          ],
        ).createShader(bounds),
        child: ListView.builder(
          physics: const BouncingScrollPhysics(),
          shrinkWrap: true,
          controller: ScrollController(),
          reverse: true,
          itemCount: generatedWords.length,
          itemBuilder: (context, index) => Center(
            child: GeneratedWordText(
              wordPair: [...generatedWords.reversed][index],
            ),
          ),
        ),
      ),
    );
  }
}
