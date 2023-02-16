
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http; 

import 'package:chat/global/environment.dart';
import 'package:chat/models/login_response.dart';
import 'package:chat/models/user.dart';
class AuthService with ChangeNotifier{

  late User user;

  Future login( String email, String password ) async{

    final data = {
      'email': email,
      'password': password
    };

    final uri = Uri.parse('${Environment.apiUrl}/login');
    print(uri);
    final resp = await http.post(uri,
      body: jsonEncode(data),
      headers: {
        'Content-Type': 'application/json'
      }
    );

    print(resp.body);
    if (resp.statusCode == 200){
      final loginResponse = loginResponseFromMap(resp.body);
      this.user = loginResponse.user;
    }
    


  }

}