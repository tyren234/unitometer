import 'package:flutter/material.dart';
import 'package:unitometer/numericInput.dart';

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
                        style: Theme.of(context).textTheme.bodyMedium,
                        children: [
                          const TextSpan(
                            text:
                                "Enter volume and it's price to display price per different popular volumes.\n\n",
                          ),
                          const TextSpan(
                            text: "Price is calculated with:\n",
                          ),
                          TextSpan(
                              style: Theme.of(context).textTheme.titleSmall,
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
                      style: Theme.of(context).textTheme.bodyMedium,
                      children: [
                        const TextSpan(
                          text: 'Price per 250 units: ',
                        ),
                        TextSpan(
                          text: "${_displayString(250)}\n",
                          style: Theme.of(context).textTheme.titleSmall,
                        ),
                        const TextSpan(
                          text: 'Price per 300 units: ',
                        ),
                        TextSpan(
                          text: "${_displayString(300)}\n",
                          style: Theme.of(context).textTheme.titleSmall,
                        ),
                        const TextSpan(
                          text: 'Price per 500 units: ',
                        ),
                        TextSpan(
                          text: "${_displayString(500)}\n",
                          style: Theme.of(context).textTheme.titleSmall,
                        ),
                        const TextSpan(
                          text: 'Price per 1000 units: ',
                        ),
                        TextSpan(
                          text: "${_displayString(1000)}\n",
                          style: Theme.of(context).textTheme.titleSmall,
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
