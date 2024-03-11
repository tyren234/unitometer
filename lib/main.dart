import 'package:flutter/material.dart';
import 'package:unitometer/myHomePage.dart';
import 'package:unitometer/settingsPage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.

  ColorScheme colorScheme = ColorScheme.fromSeed(seedColor: Colors.blue);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Unitometer',
      theme: ThemeData(
        colorScheme: colorScheme,
        useMaterial3: true,
      ),
      home: const PageLoader(),
    );
  }
}

class PageLoader extends StatefulWidget {
  const PageLoader({super.key});

  Widget build(BuildContext context) {
    return const Scaffold(
      body: MyHomePage(),
    );
  }

  @override
  State<StatefulWidget> createState() => _PageLoaderState();
}

class _PageLoaderState extends State<PageLoader> {
  int selectedIndex = 0;

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  void _openDrawer() {
    _scaffoldKey.currentState!.openDrawer();
  }

  void _closeDrawer() {
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    Widget page;
    switch (selectedIndex) {
      case 0:
        page = const MyHomePage();
      case 1:
        page = const SettingsPage();
      default:
        throw UnimplementedError('no widget for $selectedIndex');
    }

    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text("Unitometer"),
      ),
      drawer: NavigationDrawer(
        selectedIndex: selectedIndex,
        onDestinationSelected: (value) {
          setState(() {
            selectedIndex = value;
          });
          _closeDrawer();
        },
        children: const [
          NavigationDrawerDestination(
            icon: Icon(Icons.home),
            label: Text('Home'),
          ),
          NavigationDrawerDestination(
            icon: Icon(Icons.settings),
            label: Text('Settings'),
          ),
        ],
      ),
      body: Row(
        children: [
          Expanded(
            child: Container(
              color: Theme.of(context).colorScheme.primaryContainer,
              child: page, // ← Here.
            ),
          ),
        ],
      ),
    );
  }
}
