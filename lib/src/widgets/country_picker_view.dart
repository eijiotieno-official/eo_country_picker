import 'package:eo_country_picker/src/models/country_model.dart';
import 'package:eo_country_picker/src/services/country_service.dart';
import 'package:flutter/material.dart';

class CountryPickerView extends StatefulWidget {
  const CountryPickerView({super.key});

  @override
  State<CountryPickerView> createState() => _CountryPickerViewState();
}

class _CountryPickerViewState extends State<CountryPickerView> {
  final TextEditingController _searchController = TextEditingController();

  List<Country> _loadedCountries = [];

  @override
  void initState() {
    _loadedCountries = CountryService.getCountries();
    super.initState();
  }

  final List<Country> _searchResult = [];

  void _search() {
    setState(() {
      _searchResult.clear();
    });
    for (var country in _loadedCountries) {
      if (country.name.toLowerCase().replaceAll(" ", "").contains(
          _searchController.text.trim().toLowerCase().replaceAll(" ", ""))) {
        bool added = _searchResult.any((s) => s.dial == country.dial);
        if (!added) {
          setState(() {
            _searchResult.add(country);
          });
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final countries =
        _searchResult.isNotEmpty ? _searchResult : _loadedCountries;

    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.75,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: _searchController,
              autofocus: false,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
                labelText: "Search",
              ),
              onChanged: (v) {
                _search();
              },
            ),
          ),
          Expanded(
            child: countries.isEmpty
                ? const Center(
                    child: CircularProgressIndicator(
                      strokeCap: StrokeCap.round,
                    ),
                  )
                : ListView.builder(
                    physics: const BouncingScrollPhysics(),
                    itemCount: countries.length,
                    itemBuilder: (context, index) {
                      final country = countries[index];
                      return ListTile(
                        onTap: () {
                          Navigator.pop(context, country);
                        },
                        title: Text(country.name),
                      );
                    },
                  ),
          ),
          SizedBox(height: MediaQuery.of(context).viewInsets.bottom),
        ],
      ),
    );
  }
}
