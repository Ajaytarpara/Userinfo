import 'package:flutter/material.dart';
import 'package:userinfo/database_helper.dart';
import 'package:userinfo/Dashboard.dart';
import 'package:userinfo/result.dart';
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'List of Users',
      home: MyHomePage(title: 'List of Users'),
      routes: {
        '/addinfo': (context) => UserForm(),
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final dbHelper = DatabaseHelper.instance;

  List<String> UName = [];
  List<int> Uid = [];
  List<String> UHobbie = [];
  List<String> UAddress = [];
  List<String> UBirthdate = [];
  List<String> UColor = [];
  List Answer=[];



  @override
  Widget build(BuildContext context) {

    _query();
    return Scaffold(
      appBar: AppBar(
        title: Text("List of User"),
      ),
      body: new ListView.builder(
          itemCount: Uid.length,
          itemBuilder: (BuildContext ctxt, int index) {
            return new Container(
              padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
              height: 100,
              width: double.maxFinite,
              child: Card(
                elevation: 5,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.fromLTRB(10.0,0,10.0,0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Container(
                            child: Text(UName[index],
                            style: TextStyle(
                              fontSize: 26.0,

                            ),),
                          ),
                          Container(

                            alignment: Alignment.center,
                            padding: EdgeInsets.symmetric(horizontal: 5.0, vertical: 5.0),
                            child: FlatButton(
                              onPressed: (){
                                Answer.add(Uid[index]);
                                Answer.add(UName[index]);
                                Answer.add(UHobbie[index]);
                                Answer.add(UAddress[index]);
                                Answer.add(UBirthdate[index]);
                                Answer.add(UColor[index]);
                                   Navigator.push(context,
                                     MaterialPageRoute(
                                       builder: (context) => Result(showlist: Answer,),
                                     )
                                   );
                              },
                              color: Colors.redAccent,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20.0)
                              ),
                              child: Text('Show'),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          }),

      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, '/addinfo');
        },
        child: Icon(Icons.add),
      ),
    );
  }

  _query() async {
    final allRows = await dbHelper.queryAllRows();
    allRows.forEach((row) {
      print(row);
    });
    for (var row in allRows) {
      String temp = row['name'];
      UName.add(temp);
      int temp1 = row['_id'];
      Uid.add(temp1);
      String temp2 = row['hobbies'];
      UHobbie.add(temp2);
      String temp3 = row['Address'];
      UAddress.add(temp3);
      String temp4 = row['Birthdate'];
      UBirthdate.add(temp4);
      String temp5 = row['color'];
      UColor.add(temp5);
    }
  }
}
