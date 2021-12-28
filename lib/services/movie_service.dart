import 'package:dio/dio.dart';
import 'package:flickd_app/models/movie.dart';
import 'package:flickd_app/services/http_service.dart';
import 'package:get_it/get_it.dart';

class MovieService {
  final GetIt getIt = GetIt.instance;

  late HTTPService _httpService;

  MovieService() {
    _httpService = getIt.get<HTTPService>();
  }

  Future<List<Movie>?> getPopularMovies({int? page}) async {
    Response? _response = await _httpService.get(
      '/movie/popular',
      query: {
        'page': page,
      },
    );

    if (_response!.statusCode == 200) {
      Map _data = _response.data;
      print('_data: $_data');
      print("_data['results']: ${_data['results']}");
      List<Movie>? _movies = _data['results'].map<Movie>((_movieData) {
        return Movie.fromJson(_movieData);
      }).toList();
      print('_movies: $_movies');
      return _movies;
    } else {
      throw Exception('Could\'t load popular movies.');
    }
  }
}
