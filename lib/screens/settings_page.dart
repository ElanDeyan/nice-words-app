import 'package:flutter/material.dart';
import 'package:myapp/states/preferences.dart';
import 'package:provider/provider.dart';

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

final class SettingsPage extends StatelessWidget {
  const SettingsPage();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: const Column(
        children: <Widget>[
          Text("Choose your color pallete"),
          RadioOptions(),
        ],
      ),
    );
  }
}

final class RadioOptions extends StatefulWidget {
  const RadioOptions();

  @override
  State<RadioOptions> createState() => _RadioOptionsState();
}

class _RadioOptionsState extends State<RadioOptions> {
  late ColorPallete _colorPallete;

  @override
  Widget build(BuildContext context) {
    final preferences = Provider.of<AppPreferences>(context);
    _colorPallete = preferences.colorPallete;

    return Column(
      children: [
        for (final colorPallete in ColorPallete.values)
          RadioListTile<ColorPallete>(
            value: colorPallete,
            groupValue: _colorPallete,
            onChanged: (value) {
              setState(() {
                _colorPallete = value!;
                preferences.colorPallete = value;
              });
            },
            selected: colorPallete == preferences.colorPallete,
            title: Text(colorPallete.name),
          ),
      ],
    );
  }
}
