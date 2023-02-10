import 'package:chat/widgets/custom_input.dart';
import 'package:chat/widgets/labels.dart';
import 'package:chat/widgets/logo.dart';
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
      
            Logo(),

            _Form(),

            Labels(),

            Text('Terms and conditions', style: TextStyle(fontWeight: FontWeight.w200))
      
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
 
    final emailCtrl = TextEditingController();
    final passCtrl = TextEditingController();
 
    return Container(
      margin: EdgeInsets.only(top: 40),
      padding: EdgeInsets.symmetric(horizontal: 50),
      child: Column(
        children: <Widget>[

          CustomInput(
            icon: Icons.mail_outline,
            placeholder: 'Email',
            keyboardType: TextInputType.emailAddress,
            textController: emailCtrl,
          ),

          CustomInput(
            icon: Icons.lock_outline,
            placeholder: 'Password', 
            textController: passCtrl, 
            isPassword: true,
          ),


          //TODO: crear boton
          //raisedButton deprecated
          ElevatedButton(onPressed: (){
            print(emailCtrl.text);
            print(passCtrl.text);
          }, child: null,)

        ],
        
      ),
    );
  }
}

