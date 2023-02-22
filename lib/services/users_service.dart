
//tambien se puede hacer con changeNotifier
import 'package:chat/global/environment.dart';
import 'package:chat/services/auth_service.dart';
import 'package:chat/models/users_response.dart';
import 'package:http/http.dart' as http;
import 'package:chat/models/user.dart';

class UsersService {

Future<List<User>> getUser() async {
    //obteniendo el token
    String? token = await AuthService.getToken();
    try {
      final resp = await http.get(Uri.parse('${ Environment.apiUrl}/users'),
          headers: {
            'Content-Type': 'application/json',
            'x-Token': token.toString()
          });
 
      final usuarioResponse = userResponseFromMap(resp.body);
      return usuarioResponse.users;

    } catch (e) {
      return [];
    }
  }

}