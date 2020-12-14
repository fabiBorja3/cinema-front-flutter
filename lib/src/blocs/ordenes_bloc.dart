import 'package:cinema/src/models/venta.dart';
import 'package:cinema/src/repository/cinema_api_repository.dart';

class OrdenesBloc {
  final _repository = CinemaApiRepository();

   Future<List<Venta>> getOrdenes() async {
    return await _repository.getOrdenes();
  }
}
