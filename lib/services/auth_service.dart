
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http; 

import 'package:chat/global/environment.dart';
import 'package:chat/models/login_response.dart';
import 'package:chat/models/user.dart';
class AuthService with ChangeNotifier{

  late User user;
  bool _authenticating = false;

  bool get authenticating => this._authenticating;
  set authenticating(bool value){
    this._authenticating = value;
    notifyListeners();
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

      return true;
    }else{
      return false;
    }

    


  }

}