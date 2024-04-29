import 'package:flutter/material.dart';

enum ColorPallete {
  blue(Colors.blue),
  red(Colors.red),
  green(Colors.green),
  yellow(Colors.yellow),
  orange(Colors.orange),
  purple(Colors.purple);

  final Color color;
  const ColorPallete(this.color);
}

const defaultColorPallete = ColorPallete.blue;

final defaultColorPalleteName = defaultColorPallete.name;
