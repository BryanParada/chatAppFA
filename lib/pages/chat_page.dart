import 'dart:io';

import 'package:chat/widgets/chat_message.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class ChatPage extends StatefulWidget {

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {

  final _textController = new TextEditingController();
  final _focusNode = new FocusNode();

  List<ChatMessage> _messages = [
    ChatMessage(text: 'hola', uid: '123'),
    ChatMessage(text: 'holaxdaj aksljdlkasjd lkasdjla ksdjlkasdj lkasjd lkasjdlkasjdlkasjdlkasjdlkasjdlkajsdlkajs dlasd', uid: '123'),
    ChatMessage(text: 'asd', uid: '222'),
    ChatMessage(text: 'asd', uid: '222'),
    ChatMessage(text: 'asd', uid: '222'),
    ChatMessage(text: 'hofdfla', uid: '123'),
  ];

  bool _isTyping = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Column( 
          mainAxisAlignment: MainAxisAlignment.center,
          children: [ 
            CircleAvatar( 
              child: Text('Te', style: TextStyle(fontSize: 12)),
              backgroundColor: Colors.blue[100],
              maxRadius: 14
            ),
             SizedBox(height: 3,),
            Text('John doe', style: TextStyle(color: Colors.black87, fontSize: 12))
          ],
        ),
        centerTitle: true,
        elevation: 1,
      ),

      body: Container(
        child: Column(
          children: <Widget>[


            Flexible(
              child: ListView.builder(
                physics: BouncingScrollPhysics(),
                itemCount: _messages.length,
                itemBuilder: (_, i ) => _messages[i],
                reverse: true,
                ) 
              ),


              Divider( height: 1, ),

              //TODO: caja de texto
              Container(
                color: Colors.white, 
                child: _inputChat(),
              ),

          ],
        )
      ),

   );
  }

  Widget _inputChat(){

      return SafeArea(
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 8),
          child: Row(
            children: <Widget>[

              Flexible(
                child: TextField(
                  controller: _textController,
                  onSubmitted: _handleSubmit,
                  onChanged: (String text){
                   setState(() {
                     if (text.trim().length > 0 ){
                      _isTyping = true;
                     }else{
                      _isTyping = false;
                     }
                   });
                  },
                  decoration: InputDecoration(
                    hintText: 'Type message'
                  ),
                  focusNode: _focusNode,
                )
              ),

              //Boton enviar
              Container(
                margin: EdgeInsets.symmetric(horizontal: 4.0),
                child: Platform.isIOS
                ? CupertinoButton(
                  child: Text('Send'),
                     onPressed: _isTyping
                                ? () => _handleSubmit(_textController.text.trim())
                                : null,
                   )
                 : Container(
                  margin: EdgeInsets.symmetric(horizontal: 4.0),
                  child: IconTheme(
                    data: IconThemeData(color: Colors.blue[400]),
                    child: IconButton(
                      highlightColor: Colors.transparent,
                      splashColor: Colors.transparent,
                      icon: Icon(Icons.send),
                      onPressed: _isTyping
                                ? () => _handleSubmit(_textController.text.trim())
                                : null,
                    ),
                  )
                 ),
              ),


            ]
          ),
        ),
        );


  }

  _handleSubmit( String text){
    print(text);

    _textController.clear();
    _focusNode.requestFocus();

    final newMessage = new ChatMessage(text: text, uid: '123');
    _messages.insert(0, newMessage);


    setState(() {
      _isTyping = false;
    });
  }
}