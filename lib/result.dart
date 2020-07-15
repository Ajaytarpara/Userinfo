import 'package:flutter/material.dart';
import 'package:userinfo/main.dart';
import 'model.dart';

class Result extends StatelessWidget {

  final List showlist;
  Result({Key key, @required this.showlist}) : super(key: key);



  @override
  Widget build(BuildContext context) {
    final List Udata= Set.from(showlist).toList();
    print(Udata[0]);
    var name=Udata[1];
    var address=Udata[3];
    var hobbies=Udata[2];
    var birthdate=Udata[4];
    var color=Udata[5];
    return (Scaffold(
      appBar: new AppBar(
        title: new Text(
          "User Data",
          style: new TextStyle(color: Colors.white),
        ),
        leading: new IconButton(
          icon: new Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context, () {

            });
          },
        ),
      ),
      body: Container(
        margin: EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text("Name: $name",style: TextStyle(fontSize: 22)),
            Text("Address: $address",style: TextStyle(fontSize: 22)),
            Text("Hobbies: $hobbies",style: TextStyle(fontSize: 22)),
            Text("Birthdate: $birthdate",style: TextStyle(fontSize: 22)),
            Text("Favorite Color:: $color",style: TextStyle(fontSize: 22)),


          ],
        ),
      ),
    ));
  }
}
