import 'package:chat/widgets/custom_input.dart';
import 'package:flutter/material.dart';


class LoginPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffF2F2F2),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
      
            _Logo(),

            _Form(),

            _Labels(),

            Text('Terms and conditions', style: TextStyle(fontWeight: FontWeight.w200))
      
          ],
        ),
      ),
   );
  }
}


class _Logo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 170,
        margin: EdgeInsets.only(top:50),
        child: Column(
          children: [
              Image(image: AssetImage('assets/tag-logo.png')),
              SizedBox(height: 20,),
              Text('Messenger', style: TextStyle(fontSize: 30))
          ],
        ),
      ),
    );
  }
}

class _Form extends StatefulWidget { 

  @override
  State<_Form> createState() => __FormState();
}

class __FormState extends State<_Form> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 40),
      padding: EdgeInsets.symmetric(horizontal: 50),
      child: Column(
        children: <Widget>[

          CustomInput(),
          CustomInput(),


          //TODO: crear boton
          //raisedButton deprecated
          //ElevatedButton(onPressed: (){}, child: null,)

        ],
        
      ),
    );
  }
}

class _Labels extends StatelessWidget { 
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Text("Don't have an account?", style: TextStyle(color: Colors.black54, fontSize: 15, fontWeight: FontWeight.w300), ),
          SizedBox(height: 10),
          Text('Create account now', style: TextStyle( color: Colors.blue[600], fontWeight: FontWeight.bold),)
        ],
      ),
    );
  }
}