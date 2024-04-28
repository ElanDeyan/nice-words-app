import 'package:flutter/material.dart';
import 'package:myapp/states/generated_words_state.dart';
import 'package:provider/provider.dart';

final class FavoritesPage extends StatefulWidget {
  const FavoritesPage({super.key});

  @override
  State<FavoritesPage> createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage> {
  @override
  Widget build(BuildContext context) {
    final userFavorites = Provider.of<GeneratedWords>(context);

    if (userFavorites.favorites.isEmpty) {
      return const Center(
        child: Text(
          'No favorites',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      );
    }

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Center(
        child: Consumer<GeneratedWords>(
          builder: (context, value, child) {
            final favoritesAsList = value.favorites.toList();
            return Column(
              children: <Widget>[
                Text(
                  'You have ${favoritesAsList.length} favorites:',
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                Flexible(
                  fit: FlexFit.tight,
                  child: GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 1,
                      crossAxisSpacing: 1,
                      childAspectRatio: 16 / 9,
                    ),
                    itemCount: favoritesAsList.length,
                    itemBuilder: (context, index) {
                      return Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            onPressed: () => setState(() {
                              userFavorites
                                  .deleteFavorite(favoritesAsList[index]);
                            }),
                            icon: const Icon(Icons.delete_forever),
                          ),
                          Text(
                            favoritesAsList[index].asPascalCase,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
