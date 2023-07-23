import 'package:flutter/material.dart';

class MyAppBar extends StatefulWidget implements PreferredSizeWidget {
  const MyAppBar(
      {super.key,
      required this.leading,
      required this.title,
      required this.isDarkTheme,
      required this.setDarkTheme,
      this.navigateToHomePage,
      this.navigateToFavouritesPage});

  final bool isDarkTheme;
  final Function setDarkTheme;
  final String title;
  final bool leading;
  final Function? navigateToHomePage;
  final Function? navigateToFavouritesPage;

  @override
  State<MyAppBar> createState() => _MyAppBarState();
  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _MyAppBarState extends State<MyAppBar> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: (widget.leading == true) ? true : false,
      actions: [
        (widget.navigateToHomePage != null)
            ? IconButton(
                onPressed: () {
                  widget.navigateToHomePage!();
                },
                icon: const Icon(Icons.home))
            : Container(),
        (widget.navigateToFavouritesPage != null)
            ? IconButton(
                onPressed: () {
                  widget.navigateToFavouritesPage!();
                },
                icon: const Icon(Icons.favorite))
            : Container(),
        Switch(
            value: widget.isDarkTheme,
            onChanged: (value) {
              widget.setDarkTheme();
            }),
      ],
      title: Text(widget.title),
    );
  }
}
