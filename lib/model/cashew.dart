import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sohel_nuts/network/network.dart';
import 'package:http/http.dart' as http;

class Template extends StatefulWidget {

  Template({Key key,}) : super(key: key);

  @override
  _TemplateState createState() => _TemplateState();
}

class _TemplateState extends State<Template> {

  List item=[];
  String dropdownValue;

  Future<String> getSize() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token') ?? 0;
    var url =  Network.cashew_item;
    var res = await http
        .get(url, headers: {"Accept": "application/json","Authorization": token});
    var resBody = json.decode(res.body);

    print(resBody);
    setState(() {
      item = resBody;
      dropdownValue = item[0];
    });
  }

  final TextEditingController _editingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        Flexible(
          flex: 3,
          child: new DropdownButtonFormField(
            //validator: _dropdownValidate,
            items: item.map((item) {
              return new DropdownMenuItem(
                child: new Text(item),
                value: item,
              );
            }).toList(),
            onChanged: (newVal) {
              setState(() {
//                                item1 = newVal;
              });
            },
//                            value: ,
            hint: Text("SELECT", style: TextStyle(fontSize: 14.0),),
          ),
        ),

        Spacer(),

        Expanded(
          flex: 3,
          child: TextFormField(
            keyboardType: TextInputType.number,
           // validator: validateQuantity,
//                            controller: ,
            style: TextStyle(color: Colors.green, fontSize: 20.0),
          ),
        ),

        Spacer(),

        Expanded(
          flex: 3,
          child: TextFormField(
            keyboardType: TextInputType.number,
            //validator: validatePrice,
//                            controller: price1,
            style: TextStyle(
              color: Colors.green,
              fontSize: 20.0,
            ),
          ),
        ),
        Spacer(),

        Expanded(
          flex: 2,
          child: Text('', style: TextStyle(fontSize: 20.0), textAlign: TextAlign.left,),
        ),
        Expanded(
            flex: 1,
            child: IconButton(icon: Icon(Icons.delete), onPressed: null)
        )

      ],
    );
  }
}
