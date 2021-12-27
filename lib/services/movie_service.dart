import 'package:flickd_app/services/http_service.dart';
import 'package:get_it/get_it.dart';

class MovieService {
  final GetIt getIt = GetIt.instance;

  late HTTPService _httpService;

  MovieService() {
    _httpService = getIt.get<HTTPService>();
  }
}