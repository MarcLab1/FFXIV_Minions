import 'package:flutter/material.dart';
import 'package:my_app/main.dart';
import 'package:image_network/image_network.dart';
import '../model/minion.dart';
import 'my_app_bar.dart';

class DetailPage extends StatefulWidget {
  const DetailPage(
      {super.key,
      required this.setDarkTheme,
      required this.addToFavourite,
      required this.removeFromFavourite,
      required this.findMinionByIdAsStream});
  final Function setDarkTheme;
  final Function addToFavourite;
  final Function removeFromFavourite;
  final Function findMinionByIdAsStream;

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  bool _isDarkTheme = false;

  @override
  Widget build(BuildContext context) {
    var map = ModalRoute.of(context)?.settings.arguments;
    if (map is! Minion) return Container();
    Minion? _minion = map;

    const _removedSnackbar = SnackBar(
      content: Text('Removed from favourites'),
    );
    const _addedSnackbar = SnackBar(
      content: Text('Added to favourites'),
    );

    return Scaffold(
      appBar: MyAppBar(
          leading: true,
          isDarkTheme: _isDarkTheme,
          setDarkTheme: () {
            setState(() {
              _isDarkTheme = !_isDarkTheme;
              widget.setDarkTheme();
            });
          },
          navigateToHomePage: () {
            Navigator.of(context).popUntil((route) => route.isFirst);
          },
          navigateToFavouritesPage: () {
            Navigator.pushNamed(context, '/favourites');
          },
          title: _minion.id.toString()),
      body: SingleChildScrollView(
          padding:
              const EdgeInsets.only(top: 10, bottom: 10, left: 10, right: 10),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ImageNetwork(
                    image: _minion.image ?? ImagePlaceHolder.placeHolder,
                    height: 200,
                    width: 200),
                Text("id: ${_minion.id}"),
                const Padding(
                  padding: EdgeInsets.only(top: 10),
                ),
                Text("${_minion.name}",
                    style: Theme.of(context).textTheme.titleSmall),
                const Padding(
                  padding: EdgeInsets.only(top: 10),
                ),
                Text("${_minion.description}",
                    style: Theme.of(context).textTheme.bodyMedium),
                const Padding(
                  padding: EdgeInsets.only(top: 10),
                ),
                Text("${_minion.enhancedDescription}",
                    style: Theme.of(context).textTheme.bodySmall),
                const SizedBox(width: 0, height: 40),
                StreamBuilder(
                    stream: widget.findMinionByIdAsStream(_minion.id ?? -1),
                    builder: (_, snapshot) {
                      if (!snapshot.hasData) {
                        return FavouritesButton(
                            function: () {
                              widget.addToFavourite(_minion);
                              ScaffoldMessenger.of(context).clearSnackBars();
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(_addedSnackbar);
                            },
                            label: "Add to favourites",
                            icon: Icons.add);
                      } else {
                        return FavouritesButton(
                            function: () {
                              widget.removeFromFavourite(_minion);
                              ScaffoldMessenger.of(context).clearSnackBars();
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(_removedSnackbar);
                            },
                            label: "Remove from favourites",
                            icon: Icons.remove);
                      }
                    }),
              ])),
    );
  }
}

class FavouritesButton extends StatelessWidget {
  FavouritesButton(
      {super.key,
      required this.label,
      required this.icon,
      required this.function});
  final Function function;
  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: GestureDetector(
        onTap: () {
          function();
        },
        child: Padding(
          padding: const EdgeInsets.only(top: 10, bottom: 10),
          child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            Text(label),
            Container(
              height: 0,
              width: 5,
            ),
            Icon(icon),
          ]),
        ),
      ),
    );
  }
}
