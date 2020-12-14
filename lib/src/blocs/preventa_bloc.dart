import 'package:cinema/src/Utils/alert_dialog.dart';
import 'package:cinema/src/blocs/validators.dart';
import 'package:cinema/src/repository/cinema_api_repository.dart';
import 'package:flutter/cupertino.dart';

class PreventaBloc with Validators{
  final _repository = CinemaApiRepository();



 Future<void> registrarVenta(BuildContext context, String user, String pelicula, String cantidad, String valor) async {
      var apiResponse = await _repository.registrarVenta(user, pelicula, cantidad, valor);

      if (apiResponse.body != '') {
      AlertDialogCustom.showAlertChangePage(context, 'Compra Exitosa.','cine');
      } else {
        AlertDialogCustom.showAlert(context, 'No se completo la compra.');
      }
  }


}