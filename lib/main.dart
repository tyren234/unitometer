import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  static var colors = [
    ColorScheme.fromSeed(seedColor: Colors.red),
    ColorScheme.fromSeed(seedColor: Colors.green),
    ColorScheme.fromSeed(seedColor: Colors.blue),
  ];

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Unitometer',
      theme: ThemeData(
        colorScheme: colors[2],
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
        backgroundColor: Theme
            .of(context)
            .colorScheme
            .inversePrimary,
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
              color: Theme
                  .of(context)
                  .colorScheme
                  .primaryContainer,
              child: page, // ← Here.
            ),
          ),
        ],
      ),
    );
  }
}

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Text("Hey");
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  double _volume = 0;
  double _price = 0;

  void _changeVolume(String volume) {
    setState(() {
      if (volume.isEmpty) {
        _volume = 0;
      } else {
        _volume = double.parse(volume);
      }
    });
  }

  void _changePrice(String price) {
    setState(() {
      if (price.isEmpty) {
        _price = 0;
      } else {
        _price = double.parse(price);
      }
    });
  }

  String _displayString(double desiredVolume) {
    if (_price == 0) {
      return ("Fill the price field");
    }
    double output = _price / _volume * desiredVolume;
    return output.toStringAsFixed(2);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Flexible(
                    child: RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(
                        style: Theme
                            .of(context)
                            .textTheme
                            .bodyMedium,
                        children: [
                          const TextSpan(
                            text:
                            "Enter volume and it's price to display price per different popular volumes.\n\n",
                          ),
                          const TextSpan(
                            text: "Price is calculated with:\n",
                          ),
                          TextSpan(
                              style: Theme
                                  .of(context)
                                  .textTheme
                                  .titleSmall,
                              text: "outcome = price / volume * desiredVolume")
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          NumericInput(
                            label: "Enter volume",
                            onChanged: _changeVolume,
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          NumericInput(
                            label: "Enter price",
                            onChanged: _changePrice,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  RichText(
                    text: TextSpan(
                      style: Theme
                          .of(context)
                          .textTheme
                          .bodyMedium,
                      children: [
                        const TextSpan(
                          text: 'Price per 250 units: ',
                        ),
                        TextSpan(
                          text: "${_displayString(250)}\n",
                          style: Theme
                              .of(context)
                              .textTheme
                              .titleSmall,
                        ),
                        const TextSpan(
                          text: 'Price per 300 units: ',
                        ),
                        TextSpan(
                          text: "${_displayString(300)}\n",
                          style: Theme
                              .of(context)
                              .textTheme
                              .titleSmall,
                        ),
                        const TextSpan(
                          text: 'Price per 500 units: ',
                        ),
                        TextSpan(
                          text: "${_displayString(500)}\n",
                          style: Theme
                              .of(context)
                              .textTheme
                              .titleSmall,
                        ),
                        const TextSpan(
                          text: 'Price per 1000 units: ',
                        ),
                        TextSpan(
                          text: "${_displayString(1000)}\n",
                          style: Theme
                              .of(context)
                              .textTheme
                              .titleSmall,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class NumericInput extends StatelessWidget {
  const NumericInput({super.key, required this.label, required this.onChanged});

  final String label;
  final Function(String) onChanged;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onChanged: onChanged,
      keyboardType: const TextInputType.numberWithOptions(
        decimal: true,
      ),
      inputFormatters: [
        FilteringTextInputFormatter.allow(RegExp(r"^\d*\.?\d*$")),
      ],
      decoration: InputDecoration(
        border: const OutlineInputBorder(),
        labelText: label,
      ),
    );
  }
}
