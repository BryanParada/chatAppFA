import 'package:chat/helpers/show_alert.dart';
import 'package:chat/services/socket_service.dart';
import 'package:flutter/material.dart';
import 'package:chat/widgets/blue_button.dart';
import 'package:chat/widgets/custom_input.dart';
import 'package:chat/widgets/labels.dart';
import 'package:chat/widgets/logo.dart';
import 'package:provider/provider.dart';
import 'package:chat/services/auth_service.dart';


class RegisterPage extends StatelessWidget {

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
                  
                Logo(title: 'Register'),
                
                _Form(),
                
                Labels( title: 'Already have an account?', subTitle: 'Login here', route: 'login'),
                
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

    final nameCtrl = TextEditingController();
    final emailCtrl = TextEditingController();
    final passCtrl = TextEditingController();
 
  @override
  Widget build(BuildContext context) {
 
  final authService = Provider.of<AuthService>(context);
  final socketService = Provider.of<SocketService>(context);

    return Container(
      margin: EdgeInsets.only(top: 40),
      padding: EdgeInsets.symmetric(horizontal: 50),
      child: Column(
        children: <Widget>[

          CustomInput(
            icon: Icons.perm_identity,
            placeholder: 'user Name',
            keyboardType: TextInputType.text,
            textController: nameCtrl,
          ),

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

          BlueButton(text: 'Create Account', onPressed: authService.authenticating ? null : () async {
            print(nameCtrl.text);
            print(emailCtrl.text);
            print(passCtrl.text);
            final registerOk = await authService.register(nameCtrl.text.trim(), emailCtrl.text.trim(), passCtrl.text.trim());
            print(registerOk);
            
            if (registerOk['ok']){
              socketService.connect();
              Navigator.pushReplacementNamed(context, 'users');
            }else{
              showAlert(context, 'Incorrect Register', registerOk['msg'].toString());
            }

            // if (registerOk == true){
            //   //TODO: conectar a Socket server
            //   Navigator.pushReplacementNamed(context, 'users');
            // } else{
            //   showAlert(context, 'Incorrect Register', registerOk.toString());
            // }
          })

        ],
        
      ),
    );
  }
}

