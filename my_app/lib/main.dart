import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:my_app/ui/detail_page.dart';
import 'package:my_app/ui/favourite_page.dart';
import 'package:my_app/ui/home_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'network/MinionRepository.dart';
import 'database/MinionEntityRepository.dart';
import 'model/minion.dart';
import 'package:json_theme/json_theme.dart';
import 'package:flutter/services.dart';
import 'dart:convert';
import 'di/locator.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final themeStrLight =
      await rootBundle.loadString('assets/appainter_theme.json');
  final themeJsonLight = jsonDecode(themeStrLight);
  final themeLight = ThemeDecoder.decodeThemeData(themeJsonLight)!;

  final themeStrDark =
      await rootBundle.loadString('assets/appainter_theme_dark.json');
  final themeJsonDark = jsonDecode(themeStrDark);
  final themeDark = ThemeDecoder.decodeThemeData(themeJsonDark)!;

  setup();
  runApp(MyApp(themeLight: themeLight, themeDark: themeDark));
}

class MyApp extends StatefulWidget {
  final ThemeData themeLight;
  final ThemeData themeDark;

  const MyApp({Key? key, required this.themeLight, required this.themeDark})
      : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool _isDarkTheme = false;
  SharedPreferences? _prefs;
  List<Minion>? _resultsList;
  late IMinionRepository _minionRepo;
  late IMinionEntityRepository _minionEntityRepo;

  @override
  void initState() {
    super.initState();
    _initTheme();
    _initMinion();

    //getSystemIsDarkTheme();
  }

  void _addToFavourite(Minion minion) async {
    await _minionEntityRepo.insertMinion(minion);
  }

  void _removeFromFavourite(Minion minion) async {
    await _minionEntityRepo.removeMinion(minion);
  }

  Stream<Minion?> _findMinionByIdAsStream(int id) async* {
    yield* _minionEntityRepo.findMinionByIdAsStream(id ?? -1);
  }

  Stream<List<Minion>> _getAllMinionsAsStream() async* {
    yield* _minionEntityRepo.getAllMinionsAsStream();
  }

  void _initMinion() async {
    _minionRepo = GetIt.I.get<IMinionRepository>();
    _minionEntityRepo = GetIt.I.get<IMinionEntityRepository>();
    setState(() {
      _resultsList = [];
    });
  }

  void _populateList(String query) async {
    var temp = await _minionRepo.getMinions(query);
    setState(() {
      _resultsList = temp;
    });
  }

  void _initTheme() async {
    _prefs = await SharedPreferences.getInstance();
    bool theme = await _getBoolFromShared();
    setState(() {
      _isDarkTheme = theme;
    });
  }

/*
  bool getSystemIsDarkTheme() {
    var brightness =
        SchedulerBinding.instance.platformDispatcher.platformBrightness;
    return brightness == Brightness.dark;
  }
  */

  void _setIsDarkTheme() {
    setState(() {
      _isDarkTheme = !_isDarkTheme;
      _setBoolToShared(_isDarkTheme);
    });
  }

  void _setBoolToShared(bool value) async {
    _prefs?.setBool('isDarkTheme', value);
  }

  Future<bool> _getBoolFromShared() async {
    return _prefs?.getBool('isDarkTheme') ?? false;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: widget.themeLight,
        darkTheme: widget.themeDark,
        themeMode: (_isDarkTheme) ? ThemeMode.dark : ThemeMode.light,
        initialRoute: '/home',
        onGenerateRoute: (settings) {
          if (settings.name == '/home') {
            return PageRouteBuilder(
                settings: settings,
                pageBuilder: (_, __, ___) => HomePage(
                    title: "??",
                    setDarkTheme: _setIsDarkTheme,
                    resultsList: _resultsList,
                    search: _populateList),
                transitionsBuilder: (_, a, __, c) =>
                    FadeTransition(opacity: a, child: c));
          }
          if (settings.name == "/detail") {
            return PageRouteBuilder(
                settings: settings,
                pageBuilder: (_, __, ___) => DetailPage(
                    setDarkTheme: _setIsDarkTheme,
                    addToFavourite: _addToFavourite,
                    removeFromFavourite: _removeFromFavourite,
                    findMinionByIdAsStream: _findMinionByIdAsStream),
                transitionsBuilder: (_, a, __, c) =>
                    FadeTransition(opacity: a, child: c));
          }
          if (settings.name == "/favourites") {
            return PageRouteBuilder(
                settings: settings,
                pageBuilder: (_, __, ___) => FavouritePage(
                    setDarkTheme: _setIsDarkTheme,
                    getAllMinionsAsStream: _getAllMinionsAsStream),
                //dao: minionEntityRepo.getDao()),
                transitionsBuilder: (_, a, __, c) =>
                    FadeTransition(opacity: a, child: c));
          }
          // Unknown route
          //return MaterialPageRoute(
          //  builder: (_) => DetailPage(setDarkTheme: setIsDarkTheme),
          // );
        });
  }
}

abstract class ImagePlaceHolder {
  static final placeHolder =
      'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ_FkCArkpzh2CoDJSViCmbVHn4V6HYQBYrrmYKiMt8KDSty0FQaASekthpKkHKltPBk7g&usqp=CAU';
}
