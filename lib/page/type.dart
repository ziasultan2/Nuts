import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sohel_nuts/network/network.dart';


class TypeTest extends StatefulWidget {
  @override
  _TypeTestState createState() => _TypeTestState();
}

class _TypeTestState extends State<TypeTest> {

  String _mySelection;
  String _mySize;
  List type=[];
  List size=[];

  @override
  void initState() {
    super.initState();
    this.getSWData();
    this.getSize();
  }

  Future<String> getSWData() async {

    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token') ?? 0;
    var url =  Network.almond_type;
    var res = await http
        .get(url, headers: {"Accept": "application/json","Authorization": token});
    var resBody = json.decode(res.body);

    setState(() {
      type = resBody;
    });

    print(resBody);

    return "Sucess";
  }


  Future<String> getSize() async {

    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token') ?? 0;
    var url =  Network.almond_size;
    var res = await http
        .get(url, headers: {"Accept": "application/json","Authorization": token});
    var resBody = json.decode(res.body);
    print(resBody);
    setState(() {
      size = resBody;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Hospital Management"),
      ),
     body: type.length > 0 && size.length > 0 ?
     Center(
       child: Column(
         children: <Widget>[
           DropdownButton(
             items: type.map((item) {
               return new DropdownMenuItem(
                 child: new Text(item['type']),
                 value: item,
               );
             }).toList(),
             onChanged: (newVal) {
               setState(() {
                 _mySelection = newVal;
               });
             },
             value: _mySelection,


           ),

//           DropdownButtonFormField(
//             items: size.map((index) {
//               return new DropdownMenuItem(
//                 child: new Text(index),
//                 value: index,
//               );
//             }).toList(),
//             onChanged: (newVal) {
//               setState(() {
//                 _mySize = newVal;
//               });
//             },
//             hint: Text("SELECT ITEM"),
//             value: _mySize,
//           ),

         ],
       )
     ) : Container(),
    );
  }
}
