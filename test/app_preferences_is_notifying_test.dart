import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:myapp/constants/color_pallete.dart';
import 'package:myapp/constants/theme_mode.dart';
import 'package:myapp/services/shared_preferences_service.dart';
import 'package:myapp/states/local_app_preferences.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  testWidgets('AppPreferences theme mode', (widgetTester) async {
    SharedPreferences.setMockInitialValues(mockPreferences);
    const localPreferencesHandler = LocalPreferencesWithSharedPreferences();
    final appPreferences =
        AppPreferences(localPreferencesHandler: localPreferencesHandler);

    await widgetTester.pumpWidget(
      ChangeNotifierProvider.value(
        value: appPreferences,
        child: const MaterialApp(
          home: AppPreferencesTestWidget(),
        ),
      ),
    );

    expect(
      find.textContaining(mockPreferences[themeModePreferencesKey]!),
      findsOneWidget,
    );

    appPreferences.themeMode = ThemeMode.light;

    expect(
      mockPreferences[themeModePreferencesKey],
      isNot(ThemeMode.light),
    );

    await widgetTester.pump();

    expect(
      find.textContaining(ThemeMode.light.name),
      findsOneWidget,
    );
  });

  testWidgets('App preferences color pallete', (widgetTester) async {
    SharedPreferences.setMockInitialValues(mockPreferences);
    const localPreferencesHandler = LocalPreferencesWithSharedPreferences();
    final appPreferences =
        AppPreferences(localPreferencesHandler: localPreferencesHandler);

    await widgetTester.pumpWidget(
      ChangeNotifierProvider.value(
        value: appPreferences,
        child: const MaterialApp(
          home: AppPreferencesTestWidget(),
        ),
      ),
    );

    expect(
      find.textContaining(mockPreferences[colorPalletePreferencesKey]!),
      findsOneWidget,
    );

    appPreferences.colorPallete = ColorPallete.green;

    expect(
      mockPreferences[colorPalletePreferencesKey],
      isNot(ColorPallete.green),
    );

    await widgetTester.pump();

    expect(
      find.textContaining(ColorPallete.green.name),
      findsOneWidget,
    );
  });
}

final mockPreferences = <String, String>{
  colorPalletePreferencesKey: ColorPallete.red.name,
  themeModePreferencesKey: ThemeMode.dark.name,
};

final class AppPreferencesTestWidget extends StatelessWidget {
  const AppPreferencesTestWidget();
  @override
  Widget build(BuildContext context) {
    return Consumer<AppPreferences>(
      builder: (context, value, child) => Column(
        children: <Widget>[
          Text('themeMode: ${value.themeMode.name}'),
          Text('colorPallete: ${value.colorPallete.name}'),
        ],
      ),
    );
  }
}
