import 'package:chat/pages/login_page.dart';
import 'package:chat/pages/users_page.dart';
import 'package:chat/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class LoadingPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: checkLoginState(context),
        builder: (context, snapshot){
          return Center(
            child: Text('Wait Please...')
          );
        },
        
      ),
   );
  }

  Future checkLoginState( BuildContext context) async{

    final authService = Provider.of<AuthService>(context, listen: false);

    final authenticated = await authService.isLoggedIn();

    if (authenticated){
      //TODO: conectar al SS
      // Navigator.pushReplacementNamed(context, 'users');
      Navigator.pushReplacement(context, 
      PageRouteBuilder(
        pageBuilder: ( _, __, ___) => UsersPage(),
        transitionDuration: Duration(milliseconds: 0)
          )
        );
    }else{
      // Navigator.pushReplacementNamed(context, 'login');
       Navigator.pushReplacement(context, 
      PageRouteBuilder(
        pageBuilder: ( _, __, ___) => LoginPage(),
        transitionDuration: Duration(milliseconds: 0)
          )
        );
    }

  }


}