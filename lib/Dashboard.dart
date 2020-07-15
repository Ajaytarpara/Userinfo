//import 'dart:math';

import 'package:flutter/material.dart';
import 'package:userinfo/main.dart';
import 'model.dart';
import 'result.dart';
import 'package:intl/intl.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:userinfo/database_helper.dart';


class UserForm extends StatefulWidget {
  @override
  _UserFormState createState() => _UserFormState();
}

class _UserFormState extends State<UserForm> {


  final _formKey = GlobalKey<FormState>();
  Model model = Model();



  Color pickerColor = Color(0xff443a49);
  Color currentColor = Color(0xff443a49);

  DateTime _date = DateTime.now();

  final dbHelper = DatabaseHelper.instance;

  Future<Null> selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: _date,
        firstDate: DateTime(1947),
        lastDate: _date);
    if (picked != null && picked != _date) {
      setState(() {
        _date = picked;

      });
    }
  }
  Future<Null> selectColor(BuildContext context) async {
    await showDialog(
      context: context,
      child: AlertDialog(
        title: const Text('Pick a color!'),
        content: SingleChildScrollView(
          child: BlockPicker(
            pickerColor: currentColor,
            onColorChanged: changeColor,
          ),

        ),
      ),
    );

  }
  void changeColor(Color color) {
    setState(() => pickerColor = color);
    Navigator.of(context).pop();
  }


  @override
  Widget build(BuildContext context) {

    final halfMediaWidth = MediaQuery.of(context).size.width / 2.0;
    String _newdate = new DateFormat.yMMMMd().format(_date);
    model.birthdate = _newdate.toString();
    model.color = pickerColor.toString();

    //String colorname=

    return  Scaffold(
      appBar: AppBar(
        title: Text('User Details'),
      ),
      body: Form(
          key: _formKey,
          child: Column(children: <Widget>[
            Container(
              alignment: Alignment.topCenter,
              child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      alignment: Alignment.topCenter,
                      width: halfMediaWidth,
                      child: InfoTextFormField(
                        hintText: 'First Name',
                        onSaved: (String value) {
                          model.firstName = value;
                        },
                      ),
                    ),
                    Container(
                        alignment: Alignment.topCenter,
                        width: halfMediaWidth,
                        child: InfoTextFormField(
                            hintText: 'Last Name',
                            onSaved: (String value) {
                              model.lastName = value;
                            })),
                  ]),
            ),
            Container(
              alignment: Alignment.topCenter,
              child: InfoTextFormField(
                  hintText: 'Address',
                  onSaved: (String value) {
                    model.address = value;
                  }),
            ),
            Container(
              alignment: Alignment.topCenter,
              child: InfoTextFormField(
                  hintText: 'Hobbies',
                  onSaved: (String value) {
                    model.hobbies = value;
                  }),
            ),
            SizedBox(height: 15.0,),
            Padding(
              padding: const EdgeInsets.fromLTRB(16.0, 0.0, 0.0, 0.0),
              child: Row(
                children: <Widget>[
                  Text("BirthDate:",
                      style: TextStyle(
                        fontSize: 22.0,

                      )
                  ),
                  SizedBox(
                    width: 5.0,
                  ),
                  Container(
                      alignment: Alignment.topCenter,
                      child: IconButton(
                        icon: Icon(Icons.calendar_today),
                        onPressed: () {
                          selectDate(context);
                          model.birthdate = _newdate.toString();
                        },
                      )),
                  Text("$_newdate",
                      style: TextStyle(
                        fontSize: 20.0,

                      )),

                ],
              ),
            ),
            SizedBox(height: 15.0,),
            Padding(
              padding: const EdgeInsets.fromLTRB(16.0, 0.0, 0.0, 0.0),
              child: Row(
                children: <Widget>[
                  Text("Favorite Color:",
                      style: TextStyle(
                        fontSize: 22.0,

                      )
                  ),
                  SizedBox(
                    width: 5.0,
                  ),
                  Container(
                      alignment: Alignment.topCenter,
                      child: IconButton(
                        icon: Icon(Icons.color_lens),
                        iconSize: 30.0,
                        color: pickerColor,
                        onPressed: () {
                          selectColor(context);
                          model.color = pickerColor.toString();
                        },
                      )),
                  // Text("$pickerColor"),

                ],
              ),
            ),
            SizedBox(height: 20.0,),
            RaisedButton(
              color: Colors.blueAccent,

              onPressed: () {
                _formKey.currentState.save();
                _insert();

                Navigator.pop(context, () {
                  setState(() {
                  });
                });
              },
              child: Text(
                'ADD',
                style: TextStyle(
                  fontSize: 20.0,
                  color: Colors.white,

                ),
              ),
            )
          ])),
    );
  }
  void _insert() async {
    // row to insert
    Map<String, dynamic> row = {
      DatabaseHelper.columnName : model.firstName + " " + model.lastName,
      DatabaseHelper.columnHobby  : model.hobbies,
      DatabaseHelper.columnAddress  : model.address,
      DatabaseHelper.columnBirthdate  : model.birthdate,
      DatabaseHelper.columnColor  : model.color,

    };
    final id = await dbHelper.insert(row);
    print('inserted row id: $id');
  }

}


class InfoTextFormField extends StatelessWidget {
  final String hintText;
  final Function onSaved;

  InfoTextFormField({
    this.hintText,
    this.onSaved,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(8.0),
      child: TextFormField(
        decoration: InputDecoration(
          hintText: hintText,
          contentPadding: EdgeInsets.all(15.0),
          border: InputBorder.none,
          filled: true,
          fillColor: Colors.grey[200],
        ),
        onSaved: onSaved,
      ),
    );
  }
}