import 'package:chat/global/environment.dart';
import 'package:chat/models/messages_response.dart';
import 'package:chat/models/user.dart';
import 'package:chat/services/auth_service.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

class ChatService with ChangeNotifier{

  late User toUser;

  Future<List<Message>> getChat( String userID )async{

    final uri = Uri.parse('${Environment.apiUrl}/messages/$userID'); 
    String? token = await AuthService.getToken();

    final resp = await http.get(uri, 
    headers:{
      'Content-type': 'application/json',
      'x-token': token.toString()
    });

    final messagesResp = messagesResponseFromMap(resp.body);

    return messagesResp.messages;

  }


}