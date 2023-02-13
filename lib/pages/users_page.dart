import 'package:chat/models/user.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';


class UsersPage extends StatefulWidget { 
  @override
  State<UsersPage> createState() => _UsersPageState();
}

class _UsersPageState extends State<UsersPage> {

   RefreshController _refreshController = RefreshController(initialRefresh: false);

  final users = [
    User(online: true, email: 'test1@test.com', name: 'test1', uid: '1'),
    User(online: true, email: 'test2@test.com', name: 'test2', uid: '2'),
    User(online: false, email: 'test3@test.com', name: 'test3', uid: '3'),

  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My name', style: TextStyle(color: Colors.black54),),
        elevation: 1,
        backgroundColor: Colors.white,
        leading: IconButton(
         onPressed: (){},
         icon: Icon(Icons.exit_to_app, color: Colors.black54)
         ),
         actions: [
          Container(
            margin: EdgeInsets.only( right: 10),
            child: Icon(Icons.check_circle, color: Colors.blue[400]),
            // child: Icon(Icons.offline_bolt, color: Colors.red),
          )
         ],
      ),
      body:  SmartRefresher(
        controller: _refreshController,
        enablePullDown: true,
        onRefresh: _loadUsers,
        // header: WaterDropHeader( //ESTILO
        //   complete: Icon(Icons.check, color: Colors.blue[400]),
        //   waterDropColor:  Colors.blue[400]!,
        // ),
        child: _listViewUsers(),
      ),
       
   );
  }

  ListView _listViewUsers() {
    return ListView.separated(
      physics: BouncingScrollPhysics(),
      itemBuilder:   (_, i ) => _userListTile( users[i] ) ,
      separatorBuilder: (_, i ) => Divider(),
      itemCount: users.length,

    );
  }

  ListTile _userListTile( User user) {
    return ListTile(
        title: Text(user.name),
        leading: CircleAvatar(
          child: Text(user.name.substring(0,2)),
          backgroundColor: Colors.blue[100],
        ),
        trailing: Container(
          width: 10,
          height: 10,
          decoration: BoxDecoration(
            color: user.online ? Colors.green[300] : Colors.red,
            borderRadius: BorderRadius.circular(100)
          )
        ),
      );
  }


  _loadUsers() async{

   await Future.delayed(Duration(milliseconds: 1000));
    // if failed,use refreshFailed()
    _refreshController.refreshCompleted();

    
  }

}

