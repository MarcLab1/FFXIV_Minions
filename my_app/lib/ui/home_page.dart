import 'package:flutter/material.dart';
import '../model/minion.dart';
import 'package:image_network/image_network.dart';
import '../main.dart';
import 'my_app_bar.dart';

class HomePage extends StatefulWidget {
  const HomePage({
    super.key,
    required this.title,
    required this.setDarkTheme,
    required this.resultsList,
    required this.search,
  });

  final String title;
  final Function setDarkTheme;
  final List<Minion>? resultsList;
  final Function search;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool _isDarkTheme = false;
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(
          leading: false,
          isDarkTheme: _isDarkTheme,
          setDarkTheme: () {
            setState(() {
              _isDarkTheme = !_isDarkTheme;
              widget.setDarkTheme();
            });
          },
          navigateToFavouritesPage: () {
            Navigator.pushNamed(context, '/favourites');
          },
          title: "Search"),
      body: Center(
          child: (widget.resultsList != null)
              ? Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 30, right: 30),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Expanded(
                              child: TextField(
                                controller: _controller,
                                onChanged: (value) {},
                                decoration: const InputDecoration(
                                  hintText: 'Search for minion',
                                ),
                              ),
                            ),
                            IconButton(
                              icon: const Icon(Icons.search),
                              onPressed: () {
                                widget.search(_controller.text);
                              },
                            ),
                          ]),
                    ),
                    (widget.resultsList!.isEmpty)
                        ? const Center(child: Text(""))
                        : Expanded(
                            child: ListView.builder(
                                scrollDirection: Axis.vertical,
                                shrinkWrap: true,
                                itemCount: widget.resultsList?.length,
                                itemBuilder: (context, index) {
                                  Minion item = widget.resultsList![index];
                                  return GestureDetector(
                                      onTap: () {
                                        Navigator.pushNamed(context, '/detail',
                                            arguments: item);
                                      },
                                      child: AbsorbPointer(
                                          child: MyCard(item: item)));
                                }),
                          ),
                  ],
                )
              : const CircularProgressIndicator()),
    );
  }
}

class MyCard extends StatelessWidget {
  const MyCard({super.key, required Minion item}) : _item = item;
  final Minion _item;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        // Define the shape of the card
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(4),
        ),
        clipBehavior: Clip.antiAliasWithSaveLayer,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(15),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  ImageNetwork(
                    image: _item.image ?? ImagePlaceHolder.placeHolder,
                    width: 75,
                    height: 75,
                  ),
                  Container(width: 20),
                  Expanded(
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(height: 5),
                          Text(_item.name.toString(),
                              style: Theme.of(context).textTheme.titleSmall),
                          Container(
                            width: 4.0,
                            height: 4.0,
                          ),
                          Text(_item.id.toString(),
                              style: Theme.of(context).textTheme.labelLarge),
                          Container(
                            width: 4.0,
                            height: 4.0,
                          ),
                          Text(_item.description.toString(),
                              maxLines: 2,
                              style: Theme.of(context).textTheme.bodyMedium)
                        ]),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
