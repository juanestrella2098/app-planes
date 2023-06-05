import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/user_model.dart';

class UserService {
  final url = 'http://192.168.0.103:3000/api/users';

  Future<UserModel> getUsuario(String id) async {
    final uri = Uri.parse("$url/$id");
    final response = await http.get(uri);
    try {
      final UserModel resp = UserModel.fromJson(response.body);

      return resp;
    } catch (e) {
      final UserModel resp = UserModel(
          id: '',
          idFirebase: '',
          nombre: '',
          apellido: '',
          edad: 0,
          viajesFavoritos: [],
          viajesRealizados: []);
      return resp;
    }
  }

  Future<UserModel> postUsuario(UserModel userModel) async {
    final uri = Uri.parse("$url");
    print(jsonEncode(userModel.toJson()));
    final http.Response response = await http.post(uri,
        body: userModel.toJson(),
        headers: {"Content-Type": "application/json"});
    return userModel;
  }

  Future<UserModel> putUsuario(UserModel userModel) async {
    final uri = Uri.parse("$url/${userModel.idFirebase}");
    print(userModel.toJson());
    print(jsonEncode(userModel.toJson()));
    final http.Response response = await http.put(uri,
        body: userModel.toJson(),
        headers: {"Content-Type": "application/json"});
    return userModel;
  }

  Future<void> eliminaUsuario(String id) async {
    final uri = Uri.parse("$url/$id");
    final http.Response response = await http.delete(uri);
  }
}
