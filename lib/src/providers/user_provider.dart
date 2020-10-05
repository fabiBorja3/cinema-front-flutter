import 'dart:convert';

import 'package:cinema/src/models/user_model.dart';
import 'package:http/http.dart' as http;

class UserProvider {
  final String _url = 'http://192.168.1.6:8088/cinema';

  Future<bool> loginUser(UserModel user) async {
    final url = '$_url/token';

    //final response = await http.post(url, body: userModelToJson(user));
    final response = await http.post('$url/?username=${user.username}&password=${user.password}');

    final decodeData = json.decode(response.body);
    print(decodeData);

    return true;
  }
}
