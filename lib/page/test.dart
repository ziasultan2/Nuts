import 'dart:async';
import 'package:flutter/material.dart';
//import 'package:geolocator/geolocator.dart';

class Test extends StatefulWidget {
  @override
  _TestState createState() => _TestState();
}

class _TestState extends State<Test> {

  String dropdownValue = 'One';

  final List<Template> _widgets =[];


  void _retriveDate(){
    _widgets.forEach((x){
      var temp = (x.key as GlobalKey<_TemplateState>);
      var text = temp.currentState._editingController.text;
      var ddValue = temp.currentState.dropdownValue;

      print("$ddValue --------- $text");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        padding: EdgeInsets.all(20.0),
      child:  Center(
          child:
              Column(
                children: <Widget>[
              FlatButton(
              color: Colors.blue,
                textColor: Colors.white,
                disabledColor: Colors.grey,
                disabledTextColor: Colors.black,
                padding: EdgeInsets.all(8.0),
                splashColor: Colors.blueAccent,
                onPressed: () {
                  setState(() {
                    GlobalKey<_TemplateState> _key = GlobalKey();
                    _widgets.add(Template(key: _key,));
                  });
                },
                child: Text(
                  "Flat Button",
                  style: TextStyle(fontSize: 20.0),
                ),
              ),

              Column(
                children: _widgets,
              ),
                  FlatButton(
                    color: Colors.blue,
                    textColor: Colors.white,
                    disabledColor: Colors.grey,
                    disabledTextColor: Colors.black,
                    padding: EdgeInsets.all(8.0),
                    splashColor: Colors.blueAccent,
                    onPressed: () {
                        _retriveDate();
                    },
                    child: Text(
                      "Submit Button",
                      style: TextStyle(fontSize: 20.0),
                    ),
                  ),// Submit button

                ],
              )
        ),
      ),
    );
  }
}


class Template extends StatefulWidget {

  Template({Key key,}) : super(key: key);

  @override
  _TemplateState createState() => _TemplateState();
}

class _TemplateState extends State<Template> {
  String dropdownValue = "One";
  final TextEditingController _editingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        DropdownButton<String>(
          value: dropdownValue,
          onChanged: (String newValue) {
            setState(() {
              dropdownValue = newValue;
            });
          },
          items: <String>['One', 'Two', 'Free', 'Four'].map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
        ),
        Expanded(
          child: TextField(
            controller: _editingController,
            decoration: InputDecoration(
                border: InputBorder.none,
                hintText: 'Enter a search term'
            ),
          ),
        ),
        Text(''),

      ],
    );
  }
}
