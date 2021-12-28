import 'package:flickd_app/models/app_config.dart';
import 'package:get_it/get_it.dart';

class Movie {
  final String? name;
  final String? language;
  final bool? isAdult;
  final String? decription;
  final String? posterPath;
  final String? backdropPath;
  final num? rating;
  final String? releaseDate;

  Movie({
    this.name,
    this.language,
    this.isAdult,
    this.decription,
    this.posterPath,
    this.backdropPath,
    this.rating,
    this.releaseDate,
  });

  factory Movie.fromJson(Map<String, dynamic> _json) {
    return Movie(
      name: _json['title'],
      language: _json['original_language'],
      isAdult: _json['adult'],
      decription: _json['overview'],
      posterPath: _json['poster_path'],
      backdropPath: _json['backdrop_path'],
      rating: _json['vote_average'],
      releaseDate: _json['release_date'],
    );
  }

  String posterURL() {
    final AppConfig _appConfig = GetIt.instance.get<AppConfig>();
    // "BASE_IMAGE_API_URL": "https://image.tmdb.org/t/p/original/"
    return '${_appConfig.BASE_IMAGE_API_URL}${this.posterPath}';
  }
}
