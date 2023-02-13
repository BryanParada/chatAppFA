import 'package:flutter/material.dart';


class ChatPage extends StatelessWidget {

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
                height: 50,
              ),

          ],
        )
      ),

   );
  }
}