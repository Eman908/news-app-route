// import 'package:hive_ce/hive.dart';

// @GenerateAdapters([AdapterSpec<Source>()])
// part 'source.g.dart';

class Sources {
  String? id;
  String? name;
  String? description;
  String? url;
  String? category;
  String? language;
  String? country;

  Sources({
    this.id,
    this.name,
    this.description,
    this.url,
    this.category,
    this.language,
    this.country,
  });

  factory Sources.fromJson(Map<String, dynamic> json) => Sources(
    id: json['id'] as String?,
    name: json['name'] as String?,
    description: json['description'] as String?,
    url: json['url'] as String?,
    category: json['category'] as String?,
    language: json['language'] as String?,
    country: json['country'] as String?,
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'description': description,
    'url': url,
    'category': category,
    'language': language,
    'country': country,
  };

  Sources copyWith({
    String? id,
    String? name,
    String? description,
    String? url,
    String? category,
    String? language,
    String? country,
  }) {
    return Sources(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      url: url ?? this.url,
      category: category ?? this.category,
      language: language ?? this.language,
      country: country ?? this.country,
    );
  }
}
