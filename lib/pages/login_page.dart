import 'package:chat/services/auth_service.dart';
import 'package:chat/widgets/blue_button.dart';
import 'package:chat/widgets/custom_input.dart';
import 'package:chat/widgets/labels.dart';
import 'package:chat/widgets/logo.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class LoginPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffF2F2F2),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: SafeArea(
          child: Container(
            height: MediaQuery.of(context).size.height * 0.9,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                  
                Logo( title: 'Messenger'),
                
                _Form(),
                
                Labels(title: "Don't have an account?", subTitle: 'Create account now', route: 'register'),
                
                Text('Terms and conditions', style: TextStyle(fontWeight: FontWeight.w200))
                  
              ],
            ),
          ),
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
          // ElevatedButton( 
          //   onPressed: (){
          //   // print(emailCtrl.text);
          //   // print(passCtrl.text);
          // }, child: null,)

          BlueButton(text: 'Sign in', onPressed: (){
            print(emailCtrl.text);
            print(passCtrl.text);
            final authService = Provider.of<AuthService>(context, listen: false);//que no redibuje
            authService.login(emailCtrl.text, passCtrl.text);
          })

        ],
        
      ),
    );
  }
}

