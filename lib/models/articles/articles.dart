import 'source.dart';

class Articles {
  String? status;
  List<Source>? sources;

  Articles({this.status, this.sources});

  factory Articles.fromJson(Map<String, dynamic> json) => Articles(
    status: json['status'] as String?,
    sources:
        (json['sources'] as List<dynamic>?)
            ?.map((e) => Source.fromJson(e as Map<String, dynamic>))
            .toList(),
  );

  Map<String, dynamic> toJson() => {
    'status': status,
    'sources': sources?.map((e) => e.toJson()).toList(),
  };

  Articles copyWith({String? status, List<Source>? sources}) {
    return Articles(
      status: status ?? this.status,
      sources: sources ?? this.sources,
    );
  }
}
