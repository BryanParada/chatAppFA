import 'package:flutter/material.dart';


class Labels extends StatelessWidget { 

  final String title;
  final String subTitle;
  final String route;


  const Labels({
    super.key,
     required this.route,  
     required this.title,
     required this.subTitle});

  

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Text(this.title, style: TextStyle(color: Colors.black54, fontSize: 15, fontWeight: FontWeight.w300), ),
          SizedBox(height: 10),
          GestureDetector(
            child: Text(this.subTitle, style: TextStyle( color: Colors.blue[600], fontWeight: FontWeight.bold),),
            onTap: (){
              // print('tap');
              Navigator.pushReplacementNamed(context, this.route);
            },
            )
        ],
      ),
    );
  }
}