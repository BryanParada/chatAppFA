import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class ChatPage extends StatefulWidget {

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {

  final _textController = new TextEditingController();
  final _focusNode = new FocusNode();

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
                itemBuilder: (_, i ) => Text('$i'),
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
                    //TODO: cuando hay un valor, para poder postear
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
                   onPressed: (){}
                   )
                 : Container(
                  margin: EdgeInsets.symmetric(horizontal: 4.0),
                  child: IconButton(
                    icon: Icon(Icons.send, color: Colors.blue[400], ),
                    onPressed: (){},
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
  }
}