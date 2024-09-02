import 'package:eo_country_picker/src/models/country_model.dart';
import 'package:eo_country_picker/src/services/country_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CountryPickerView extends StatefulWidget {
  final Color? themeColor;
  final Color? backgroundColor;
  const CountryPickerView({super.key, this.themeColor, this.backgroundColor});

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
      bool matchName = country.name.toLowerCase().replaceAll(" ", "").contains(
          _searchController.text.trim().toLowerCase().replaceAll(" ", ""));
      bool matchDial = country.dial.toLowerCase().replaceAll(" ", "").contains(
          _searchController.text.trim().toLowerCase().replaceAll(" ", ""));
      if (matchDial || matchName) {
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

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        systemNavigationBarColor: widget.backgroundColor,
        systemNavigationBarIconBrightness:
            Theme.of(context).brightness == Brightness.dark
                ? Brightness.light
                : Brightness.dark,
      ),
      child: SizedBox(
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
                  labelText: "Search name or dial",
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
                            SystemChrome.setSystemUIOverlayStyle(
                              const SystemUiOverlayStyle(
                                systemNavigationBarColor: null,
                              ),
                            );

                            Navigator.pop(context, country);
                          },
                          leading: Text(
                            country.flag,
                            style: TextStyle(
                              fontSize: Theme.of(context)
                                  .textTheme
                                  .titleLarge
                                  ?.fontSize,
                            ),
                          ),
                          title: Text(country.name),
                          trailing: Text(
                            country.dial,
                            style: TextStyle(
                              fontSize: Theme.of(context)
                                  .textTheme
                                  .titleMedium
                                  ?.fontSize,
                              color: widget.themeColor,
                            ),
                          ),
                        );
                      },
                    ),
            ),
            SizedBox(height: MediaQuery.of(context).viewInsets.bottom),
          ],
        ),
      ),
    );
  }
}
