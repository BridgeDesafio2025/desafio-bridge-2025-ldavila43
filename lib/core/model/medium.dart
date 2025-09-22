import 'package:movies__series_app/core/model/streaming_platform.dart';
import '../enums/media_type.dart';

class Medium {
  final int id;
  final MediaType type;
  final String title;
  final List<String> genres;
  final String synopsis;
  final double rating;
  final String? poster;
  final int year;
  final String duration;
  final int? episodes;
  final int? seasons;
  final List<StreamingPlatform> streamingPlatforms;

  Medium({
    required this.id,
    required this.type,
    required this.title,
    required this.genres,
    required this.synopsis,
    required this.rating,
    this.poster,
    required this.year,
    required this.duration,
    this.episodes,
    this.seasons,
    required this.streamingPlatforms,
  });


  factory Medium.fromJson(Map<String, dynamic> json) {
    final List<dynamic> rawPlatformList = json['streamingPlatforms'] as List? ??[];

    final List<StreamingPlatform> platformItems = [];

    for (var item in rawPlatformList) {
      platformItems.add(StreamingPlatform.fromJson(item));
    }

    return Medium(
      id: json['id'],
      type: MediaType.values.firstWhere(
        (type) => type.name.toLowerCase() == json['type'].toString().toLowerCase(),
        orElse: () => MediaType.movie,
      ),
      title: json['title'],
      genres: List<String>.from(json['genre']),
      synopsis: json['synopsis'],
      rating: (json['rating'] as num).toDouble(),
      poster: json['poster'],
      year: json['year'],
      duration: json['duration'],
      episodes: json['episodes'],
      seasons: json['seasons'],
      streamingPlatforms: platformItems,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'type': type.name,
      'title': title,
      'genre': genres,
      'synopsis': synopsis,
      'rating': rating,
      'poster': poster,
      'year': year,
      'duration': duration,
      'episodes': episodes,
      'seasons': seasons,
      'streamingPlatforms': streamingPlatforms.map((platform) => platform.toJson()).toList(),
    };
  }
}
