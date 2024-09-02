import 'dart:convert';

class Country {
  final String name;
  final String flag;
  final String code;
  final String dial;
  Country({
    required this.name,
    required this.flag,
    required this.code,
    required this.dial,
  });

  Country copyWith({
    String? name,
    String? flag,
    String? code,
    String? dial,
  }) {
    return Country(
      name: name ?? this.name,
      flag: flag ?? this.flag,
      code: code ?? this.code,
      dial: dial ?? this.dial,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'flag': flag,
      'code': code,
      'dial': dial,
    };
  }

  factory Country.fromMap(Map<String, dynamic> map) {
    return Country(
      name: map['name'] ?? '',
      flag: map['flag'] ?? '',
      code: map['code'] ?? '',
      dial: map['dial'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory Country.fromJson(String source) =>
      Country.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Country(name: $name, flag: $flag, code: $code, dial: $dial)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Country &&
        other.name == name &&
        other.flag == flag &&
        other.code == code &&
        other.dial == dial;
  }

  @override
  int get hashCode {
    return name.hashCode ^ flag.hashCode ^ code.hashCode ^ dial.hashCode;
  }
}
