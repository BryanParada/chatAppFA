import 'package:flutter/material.dart';


class Labels extends StatelessWidget { 
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