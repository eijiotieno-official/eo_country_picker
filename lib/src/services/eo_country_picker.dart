import 'package:eo_country_picker/src/models/country_model.dart';
import 'package:eo_country_picker/src/widgets/country_picker_view.dart';
import 'package:flutter/material.dart';

class CountryPicker {
  static Future<Country?> open(BuildContext context) async =>
      await showModalBottomSheet<Country>(
        backgroundColor: Theme.of(context).colorScheme.surface,
        context: context,
        showDragHandle: true,
        useSafeArea: true,
        isScrollControlled: true,
        builder: (context) {
          return const CountryPickerView();
        },
      );
}
