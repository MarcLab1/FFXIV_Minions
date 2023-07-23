import 'package:flutter/material.dart';
import 'package:image_network/image_network.dart';
import '../model/minion.dart';
import '../main.dart';
import 'my_app_bar.dart';

class FavouritePage extends StatefulWidget {
  const FavouritePage(
      {super.key,
      required this.setDarkTheme,
      required this.getAllMinionsAsStream});
  final Function setDarkTheme;
  final Function getAllMinionsAsStream;
  @override
  State<FavouritePage> createState() => _FavouritePageState();
}

class _FavouritePageState extends State<FavouritePage> {
  bool _isDarkTheme = false;

  @override
  Widget build(BuildContext context) {
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
            title: "Favourites"),
        body: Column(children: [
          Expanded(
              child: StreamBuilder(
                  stream: widget.getAllMinionsAsStream(),
                  builder: (_, snapshot) {
                    if (snapshot.data == null) return Container();
                    final list = snapshot.data! as List<Minion>;
                    if (list.length == 0)
                      return Center(child: Text("No favourites yet"));
                    return GridView.count(
                      crossAxisCount: 2,
                      children: List.generate(list.length, (index) {
                        Minion item = list[index];
                        return GestureDetector(
                            onTap: () {
                              Navigator.pushNamed(context, '/detail',
                                  arguments: item);
                            },
                            child: AbsorbPointer(
                                child: FavouriteCard(item: item)));
                      }),
                    );
                  }))
        ]));
  }
}

class FavouriteCard extends StatelessWidget {
  const FavouriteCard({super.key, required Minion item}) : _item = item;
  final Minion _item;

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(left: 5, right: 5),
        child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(4),
            ),
            clipBehavior: Clip.antiAliasWithSaveLayer,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                ImageNetwork(
                  image: _item.image ?? ImagePlaceHolder.placeHolder,
                  width: 125,
                  height: 125,
                ),
                Container(height: 10),
                Padding(
                  padding: const EdgeInsets.only(left: 5, right: 5),
                  child: SizedBox(
                      child: Text(_item.name.toString(),
                          style: Theme.of(context).textTheme.titleSmall)),
                ),
              ],
            )));
  }
}
