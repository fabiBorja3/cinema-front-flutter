import 'package:cinema/src/models/api_response.dart';
import 'package:cinema/src/repository/cinema_api_repository.dart';

class PreventaBloc {
  final _repository = CinemaApiRepository();

 Future<ApiResponse> registrarVenta(String user, String pelicula, String cantidad, String valor) async {
    return await _repository.registrarVenta(user, pelicula, cantidad, valor);
  }


}