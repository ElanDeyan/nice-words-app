// import 'package:flutter/material.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// import 'package:myapp/states/preferences.dart';
// import 'package:provider/provider.dart';
// import 'package:url_launcher/url_launcher.dart';


// final class SettingsPage extends StatelessWidget {
//   const SettingsPage();

//   @override
//   Widget build(BuildContext context) {
//     final preferences = Provider.of<AppPreferences>(context);
//     final colorPallete = preferences.colorPallete;
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Settings'),
//       ),
//       body: Column(
//         children: <Widget>[
//           ListTile(
//             title: const Text('Choose your color pallete'),
//             subtitle: Row(
//               children: [
//                 CircleAvatar(
//                   backgroundColor: colorPallete.color,
//                   maxRadius: 5.0,
//                   minRadius: 5.0,
//                 ),
//                 const SizedBox(
//                   width: 5.0,
//                 ),
//                 Text(colorPallete.name),
//               ],
//             ),
//             onTap: () => showDialog(
//               context: context,
//               builder: (_) => const Dialog(
//                 child: RadioOptions(),
//               ),
//             ),
//           ),
//           ListTile(
//             title: const Text('Nice words'),
//             subtitle: const Text('Version 1.0.0'),
//             onTap: () => showAboutDialog(
//               context: context,
//               applicationName: 'Nice words',
//               applicationVersion: '1.0.0',
//               children: [
//                 const Text('Thanks for use this app!'),
//                 const Text('Follow me in my social medias:'),
//                 Wrap(
//                   children: [
//                     IconButton(
//                       onPressed: () async => await launchUrl(
//                         Uri.parse('https://github.com/ElanDeyan'),
//                         mode: LaunchMode.externalApplication,
//                       ),
//                       icon: const FaIcon(FontAwesomeIcons.github),
//                     ),
//                     IconButton(
//                       onPressed: () async => await launchUrl(
//                         Uri.parse(
//                           'https://www.linkedin.com/in/elan-almeida-a3391225b/',
//                         ),
//                         mode: LaunchMode.externalApplication,
//                       ),
//                       icon: const FaIcon(FontAwesomeIcons.linkedin),
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// final class RadioOptions extends StatefulWidget {
//   const RadioOptions();

//   @override
//   State<RadioOptions> createState() => _RadioOptionsState();
// }

// class _RadioOptionsState extends State<RadioOptions> {
//   late ColorPallete _colorPallete;

//   @override
//   Widget build(BuildContext context) {
//     final preferences = Provider.of<AppPreferences>(context);
//     _colorPallete = preferences.colorPallete;

//     return Column(
//       mainAxisSize: MainAxisSize.min,
//       children: [
//         for (final colorPallete in ColorPallete.values)
//           RadioListTile<ColorPallete>(
//             value: colorPallete,
//             groupValue: _colorPallete,
//             onChanged: (value) {
//               setState(() {
//                 _colorPallete = value!;
//                 preferences.colorPallete = value;
//               });
//             },
//             selected: colorPallete == preferences.colorPallete,
//             title: Text(colorPallete.name),
//           ),
//       ],
//     );
//   }
// }
