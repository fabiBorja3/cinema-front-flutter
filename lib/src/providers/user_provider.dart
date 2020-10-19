import 'package:cinema/src/Utils/alert_dialog.dart';
import 'package:cinema/src/models/user_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_session/flutter_session.dart';
import 'package:http/http.dart' as http;

class UserProvider {
  final String _url = 'http://192.168.1.11:8088/cinema';

  //final String _url = 'http://cinema7.herokuapp.com/cinema';

  Future<bool> loginUser(BuildContext context, UserModel user) async {
    final url = '$_url/token';

    //final response = await http.post(url, body: userModelToJson(user));
    final response = await http
        .post('$url/?username=${user.username}&password=${user.password}');

    if (response.body.contains('token')) {
      AlertDialogCustom.showAlert(context, 'Autorizacion Invalida');
    } else {
      var session = FlutterSession();
      await session.set('token', response.body);
      Navigator.pushReplacementNamed(context, 'home');
    }

    return true;
  }
}
//http://cinema7.herokuapp.com/cinema/
