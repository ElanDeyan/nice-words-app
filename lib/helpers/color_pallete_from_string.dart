import 'package:myapp/constants/color_pallete.dart';

ColorPallete colorPalleteFromString(String string) => switch (string) {
      'blue' => ColorPallete.blue,
      'green' => ColorPallete.green,
      'orange' => ColorPallete.orange,
      'purple' => ColorPallete.purple,
      'yellow' => ColorPallete.yellow,
      'red' => ColorPallete.red,
      _ => throw ArgumentError.value(
          string,
          null,
          "Unrecognized color pallete value",
        ),
    };
