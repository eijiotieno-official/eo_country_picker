import 'package:eo_country_picker/eo_country_picker.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Example(),
    );
  }
}

class Example extends StatefulWidget {
  const Example({super.key});

  @override
  State<Example> createState() => _ExampleState();
}

class _ExampleState extends State<Example> {
  Country? _selectedCountry;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            if (_selectedCountry != null) Text(_selectedCountry.toString()),
            FilledButton(
              onPressed: () async {
                final result = await CountryPicker.open(context);
                if (result != null) {
                  setState(() {
                    _selectedCountry = result;
                  });
                }
              },
              child: Text("Pick a Country"),
            ),
          ],
        ),
      ),
    );
  }
}
