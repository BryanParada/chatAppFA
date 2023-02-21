
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http; 

import 'package:chat/global/environment.dart';
import 'package:chat/models/login_response.dart';
import 'package:chat/models/user.dart';
class AuthService with ChangeNotifier{

  late User user;
  bool _authenticating = false;

  final _storage = new FlutterSecureStorage();

  bool get authenticating => this._authenticating;
  set authenticating(bool value){
    this._authenticating = value;
    notifyListeners();
  }

  //Getters del token de forma estatica 
  static Future<String?> getToken() async{
    final _storage = new FlutterSecureStorage();
    final token = await _storage.read(key: 'token');
    return token;
  }

  static Future<void> deleteToken() async{
    final _storage = new FlutterSecureStorage();
    await _storage.delete(key: 'token'); 
  }



  Future<bool> login( String email, String password ) async{

    this.authenticating = true;


    final data = {
      'email': email,
      'password': password
    };

    final uri = Uri.parse('${Environment.apiUrl}/login');
    //print(uri);
    final resp = await http.post(uri,
      body: jsonEncode(data),
      headers: {
        'Content-Type': 'application/json'
      }
    );

    print(resp.body);
    this.authenticating = false;
    if (resp.statusCode == 200){
      final loginResponse = loginResponseFromMap(resp.body);
      this.user = loginResponse.user;

      await this._saveToken(loginResponse.token);

      return true;
    }else{
      return false;
    }
 
  }

   Future<Map<String, dynamic>> register(String name, String email, String password ) async{
        this.authenticating = true;


    final data = {
      'name': name,
      'email': email,
      'password': password
    };

    final uri = Uri.parse('${Environment.apiUrl}/login/new');
    print(uri);
    final resp = await http.post(uri,
      body: jsonEncode(data),
      headers: { 'Content-Type': 'application/json' }
    );

    print(resp.body);
    this.authenticating = false;
    if (resp.statusCode == 200){
      final loginResponse = loginResponseFromMap(resp.body);
      this.user = loginResponse.user;

      await this._saveToken(loginResponse.token);

      // return true; //bool si sale bien

      return {
        'ok': true,
        'msg': '',
      };

    }else{
      // final respBody = jsonDecode(resp.body);
      // return respBody['msg']; //string si sale mal

      Map<String, dynamic> json = jsonDecode(resp.body);
      final jsonM = json["errors"]["email"]["msg"];
    
      return {
        'ok': false,
        'msg': jsonM,
      };

    }
   }

  Future<bool> isLoggedIn() async{

    final token = await this._storage.read(key: 'token');

    final uri = Uri.parse('${Environment.apiUrl}/login/renew');
    print(uri);
    final resp = await http.get(uri, 
      headers: { 
        'Content-Type': 'application/json',
        'x-token': token!
         }
    );

    print(resp.body);
    this.authenticating = false;
    if (resp.statusCode == 200){
      final loginResponse = loginResponseFromMap(resp.body);
      this.user = loginResponse.user;

      await this._saveToken(loginResponse.token);
      return true;

    } else{
      this.logout();
      return false;
    }

      

  }

  Future _saveToken( String token) async{
    return await _storage.write(key: 'token', value: token);
  }

  Future logout() async{
    await _storage.delete(key: 'token');
  }

}