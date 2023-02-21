import 'package:chat/helpers/show_alert.dart';
import 'package:chat/services/auth_service.dart';
import 'package:chat/services/socket_service.dart';
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

    final emailCtrl = TextEditingController();
    final passCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
 
    final authService   = Provider.of<AuthService>(context);//no sera necesario colocar listener porque en el build podemos redibujar si la propiedad cambia o el provider del authservice dispara el notifyListeners 
    final socketService = Provider.of<SocketService>(context);
 
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

          BlueButton(text: 'Sign in',
           onPressed: authService.authenticating ? null : () async{
            // print(emailCtrl.text);
            // print(passCtrl.text);
            
            FocusScope.of(context).unfocus();

            final loginOk = await authService.login(emailCtrl.text.trim(), passCtrl.text.trim());

            if ( loginOk ){
              socketService.connect();
              //Navegar a otra pantalla
              Navigator.pushReplacementNamed(context, 'users'); //para no regresar al login
            }else{
              //TODO: Mostar alerta
              showAlert(context, 'Invalid Login', 'Check your credentials');
            }

          })

        ],
        
      ),
    );
  }
}

