import 'dart:io';

import 'package:chat/services/auth_service.dart';
import 'package:chat/services/chat_service.dart';
import 'package:chat/services/socket_service.dart';
import 'package:chat/widgets/chat_message.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class ChatPage extends StatefulWidget {

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> with TickerProviderStateMixin{

  final _textController = new TextEditingController();
  final _focusNode = new FocusNode();

  late ChatService chatService;
  late SocketService socketService;
  late AuthService authService;

  List<ChatMessage> _messages = [ 
  ];

  bool _isTyping = false;

  @override
  void initState() {
    super.initState();
    this.chatService = Provider.of<ChatService>(context, listen: false);
    this.socketService = Provider.of<SocketService>(context, listen: false);
    this.authService = Provider.of<AuthService>(context, listen: false);

    this.socketService.socket.on('personal-msg',_listenMessage);
  }

  void _listenMessage(dynamic payload){
    // print('got message $data');
    //print(payload['msg']);
    

    ChatMessage message = new ChatMessage(
      text: payload['msg'],
      uid: payload['from'],
      animationController: AnimationController(vsync: this, duration: Duration(milliseconds: 300))
    );

    setState(() {
      _messages.insert(0, message);
    });

    message.animationController.forward();
    
  }

  @override
  Widget build(BuildContext context) {
 
    final toUser = chatService.toUser;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Column( 
          mainAxisAlignment: MainAxisAlignment.center,
          children: [ 
            CircleAvatar( 
              child: Text(toUser.name.substring(0,2), style: TextStyle(fontSize: 12)),
              backgroundColor: Colors.blue[100],
              maxRadius: 14
            ),
             SizedBox(height: 3,),
            Text(toUser.name, style: TextStyle(color: Colors.black87, fontSize: 12))
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
    //print(text);

    if(text.length == 0) return;

    _textController.clear();
    _focusNode.requestFocus();

    final newMessage = new ChatMessage(
      text: text,
       uid: '123',
       animationController: AnimationController(vsync: this, duration: Duration(milliseconds: 200)),);
    _messages.insert(0, newMessage);
    //activar animation
    newMessage.animationController.forward();


    setState(() {
      _isTyping = false;
    });

    this.socketService.emit('personal-msg', {
      'from': this.authService.user.uid,
      'to': this.chatService.toUser.uid,
      'msg': text
    });
    
  }

  @override
  void dispose() { 
    //for memory optimization when closing ChatPage
    for( ChatMessage message in _messages){
      message.animationController.dispose();
    }

    this.socketService.socket.off('personal-msg');
    super.dispose();
  }
}