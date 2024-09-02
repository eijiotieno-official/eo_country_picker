import 'package:eo_country_picker/src/databases/country_database.dart';
import 'package:eo_country_picker/src/models/country_model.dart';

class CountryService {
 static List<Country> getCountries() =>
      CountryDatabase.data.map((e) => Country.fromMap(e)).toList();
}
