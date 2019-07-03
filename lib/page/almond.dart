import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:sohel_nuts/model/size.dart';
import 'package:sohel_nuts/model/type.dart';
import 'package:sohel_nuts/network/network.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class Almond extends StatefulWidget {
  @override
  _AlmondState createState() => _AlmondState();
}

class _AlmondState extends State<Almond> {

  String _selectType;
  List type=[];
  List size=[];

  @override
  void initState() {
    super.initState();
    _getToken();
    this._getId();
    this.getType();
    this.getSize();
  }

  var _token;
  var _id;

  Future<String> getType() async {

    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token') ?? 0;
    var url =  Network.almond_type;
    var res = await http
        .get(url, headers: {"Accept": "application/json","Authorization": token});
    var resBody = json.decode(res.body);
    print(resBody);
    setState(() {
      type = resBody;
    });
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

  GlobalKey<FormState> _key = new GlobalKey();

  final price = TextEditingController();
  final quantity = TextEditingController();
  final sales = TextEditingController();

  var _margin = "";
  var _value = "";
  var _cost = "";

  String _myType;
  String _mySize;

  bool _validate = false;

  var _currentType;


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: new ThemeData(
        primarySwatch: Colors.green,
        // Your app THEME-COLOR
        textTheme: new TextTheme(
          body1: new TextStyle(color: Colors.green, fontSize: 20.0),
        ),
      ),

      home:  Scaffold(
        resizeToAvoidBottomPadding: false,
        appBar: AppBar(
          centerTitle: true,
          title: Text('ALMOND'),
            leading: IconButton(icon:Icon(Icons.arrow_back),
              onPressed:() => Navigator.pop(context, false),
            )
        ),
        body:
        type.length & size.length >  0   ?
        Container(
          decoration: new BoxDecoration(
            image: new DecorationImage(
              image: new AssetImage("images/bg.jpg"), fit: BoxFit.cover,),),
          child: Container(
            margin: EdgeInsets.all(20.0),
            decoration: new BoxDecoration(color: Colors.white),
            child: Container(
                margin: EdgeInsets.only(top: 50.0, left: 10.0, right: 10.0),
                child: Form(
                  key: _key,
                  autovalidate: _validate,
                  child:  Column(
                    //crossAxisAlignment: CrossAxisAlignment.stretch,
                    //mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Column(
                        children: <Widget>[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: <Widget>[
                              Expanded(
                                flex: 2,
                                child: Text(
                                  'TYPE', style: TextStyle(fontSize: 30.0,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.green),
                                  textAlign: TextAlign.right,),
                              ),

                              Expanded(
                                  flex: 2,
                                  child:
                                  Center(
                                    child: new DropdownButton(
                                      items: type.map((item) {
                                        return new DropdownMenuItem(
                                          child: new Text(item),
                                          value: item,
                                        );
                                      }).toList(),
                                      onChanged: (newVal) {
                                        setState(() {
                                          _myType = newVal;
                                        });
                                      },
                                      value: _myType,
                                    ),
                                  )
                              ),

                              SizedBox(width: 10.0,),

                              Expanded(
                                child: Text('', style: TextStyle(
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.green,),),
                              ),

                            ],
                          ), //// Type

                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: <Widget>[
                              Expanded(
                                flex: 2,
                                child: Text(
                                  'SIZE', style: TextStyle(fontSize: 30.0,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.green),
                                  textAlign: TextAlign.right,),
                              ),

                              Expanded(
                                  flex: 2,
                                  child:
                                  Center(
                                    child: new DropdownButton(
                                      items: size.map((item) {
                                        return new DropdownMenuItem(
                                          child: new Text(item),
                                          value: item,
                                        );
                                      }).toList(),
                                      onChanged: (newVal) {
                                        setState(() {
                                          _mySize = newVal;
                                        });
                                      },
                                      value: _mySize,
                                    ),
                                  )
                              ),

                              SizedBox(width: 10.0,),

                              Expanded(
                                child: Text('', style: TextStyle(
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.green,),),
                              ),

                            ],
                          ), // SIZE


                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: <Widget>[
                              Expanded(
                                flex: 2,
                                child: Text(
                                  'PRICE', style: TextStyle(fontSize: 30.0,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.green),
                                  textAlign: TextAlign.right,),
                              ),
                              SizedBox(width: 10.0,),
                              Expanded(
                                flex: 2,
                                child: TextFormField(
                                  validator: validatePrice,
                                  maxLength: 8,
                                  controller: price,
                                  style: TextStyle(
                                      fontSize: 20.0, color: Colors.green),),
                              ),
                              SizedBox(width: 10.0,),
                              Expanded(
                                child: Text('lb in USD', style: TextStyle(
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.green,),),
                              ),
                            ],
                          ), // Price

                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: <Widget>[
                              Expanded(
                                flex: 2,
                                child: Text('QUANTITY', style: TextStyle(
                                    fontSize: 30.0,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.green),
                                  textAlign: TextAlign.right,),
                              ),
                              SizedBox(width: 10.0,),
                              Expanded(
                                flex: 2,
                                child: TextFormField(
                                  validator: validateQuantity,
                                  maxLength: 8,
                                  controller: quantity,
                                  style: TextStyle(
                                      fontSize: 20.0, color: Colors.green),),
                              ),
                              SizedBox(width: 10.0,),
                              Expanded(
                                child: Text('lb', style: TextStyle(fontSize: 20.0,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.green),),
                              ),
                            ],
                          ), // Quantity

                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: <Widget>[
                              Expanded(
                                flex: 2,
                                child: Text('SALES', style: TextStyle(fontSize: 30.0,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.green),
                                  textAlign: TextAlign.right,),
                              ),
                              SizedBox(width: 10.0,),
                              Expanded(
                                flex: 2,
                                child: TextFormField(
                                  validator: validateSales,
                                  maxLength: 8,
                                  controller: sales,
                                  style: TextStyle(
                                      fontSize: 20.0, color: Colors.green),),
                              ),
                              SizedBox(width: 10.0,),
                              Expanded(
                                child: Text('Tk/Kg', style: TextStyle(fontSize: 20.0,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.green),),
                              ),
                            ],
                          ), // sales

                        ],
                      ), // show input

                      SizedBox(height: 50.0,),

                      Expanded(
                        child: Column(
                          //crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: <Widget>[
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: <Widget>[
                                Expanded(
                                  flex: 2,
                                  child: Text('MARGIN', style: TextStyle(
                                      fontSize: 30.0,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.green),
                                    textAlign: TextAlign.right,),
                                ),
                                SizedBox(width: 10.0,),
                                Expanded(
                                  flex: 2,
                                  child: Text('$_margin',
                                    style: TextStyle(
                                        fontSize: 20.0, color: Colors.green),),
                                ),
                                SizedBox(width: 10.0,),
                                Expanded(
                                  child: Text('TK', style: TextStyle(fontSize: 20.0,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.green,),),
                                ),
                              ],
                            ),
                            Row(

                              mainAxisAlignment: MainAxisAlignment.end,
                              children: <Widget>[
                                Expanded(
                                  flex: 2,
                                  child: Text('VALUE', style: TextStyle(
                                      fontSize: 30.0,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.green),
                                    textAlign: TextAlign.right,),
                                ),
                                SizedBox(width: 10.0,),
                                Expanded(
                                  flex: 2,
                                  child: Text('$_value',
                                    style: TextStyle(
                                        fontSize: 20.0, color: Colors.green),),
                                ),
                                SizedBox(width: 10.0,),
                                Expanded(
                                  child: Text('TK', style: TextStyle(fontSize: 20.0,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.green),),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: <Widget>[
                                Expanded(
                                  flex: 2,
                                  child: Text('COST', style: TextStyle(fontSize: 30.0,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.green),
                                    textAlign: TextAlign.right,),
                                ),
                                SizedBox(width: 10.0,),
                                Expanded(
                                  flex: 2,
                                  child: Text('$_cost',
                                    style: TextStyle(
                                        fontSize: 20.0, color: Colors.green),),
                                ),
                                SizedBox(width: 10.0,),
                                Expanded(
                                  child: Text('Tk', style: TextStyle(fontSize: 20.0,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.green),),
                                ),
                              ],
                            ),

                          ],
                        ),
                      ), // show data


                      Center(
                        child: Row(
                          children: <Widget>[
                            Container(
                              decoration: BoxDecoration(
                                  color: Colors.green
                              ),
                              child: FlatButton(
                                padding: EdgeInsets.only(
                                    top: 20.0, bottom: 20.0, left: 45.0, right: 45.0),
                                child: Text('Clear', style: TextStyle(fontSize: 25.0,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),),
                                onPressed: () {
                                  setState(() {
                                    price.text = "";
                                    quantity.text = "";
                                    sales.text = "";
                                    _margin = '';
                                    _value = '';
                                    _cost = '';


                                  });
                                },
                              ),
                            ),

                            Container(
                              decoration: BoxDecoration(
                                  border: Border(
                                    left: BorderSide(color: Colors.grey, width: 5.0),
                                  )
                              ),
                            ),

                            Container(
                              decoration: BoxDecoration(
                                  color: Colors.green
                              ),
                              child: FlatButton(
                                padding: EdgeInsets.only(
                                    top: 20.0, bottom: 20.0, left: 45.0, right: 45.0),
                                child: Text('SHOW', style: TextStyle(fontSize: 25.0,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),),
                                onPressed: _result,
                              ),
                            ),

                            Container(
                              decoration: BoxDecoration(
                                  border: Border(
                                    left: BorderSide(color: Colors.grey, width: 5.0),
                                  )
                              ),
                            ),

                            Container(
                              decoration: BoxDecoration(
                                  color: Colors.green
                              ),
                              child: FlatButton(
                                padding: EdgeInsets.only(
                                    top: 20.0, bottom: 20.0, left: 45.0, right: 45.0),
                                child: Text('SAVE', style: TextStyle(fontSize: 25.0,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),),
                                onPressed: _save,
                              ),
                            ),

                          ],
                        ),
                      ),
                      // button

                    ],
                  ),
                )
            ),
          ),
        )
            : Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
      

  }




  String validatePrice(String value) {
    if(value.length == 0)
    {
      return "Name is Required";
    }else{
      return null;
    }
  }

  String validateQuantity(String value) {
    if(value.length == 0)
    {
      return "Quantity is Required";
    }else{
      return null;
    }
  }

  String validateSales(String value) {
    if(value.length == 0)
    {
      return "Sales is Required";
    }else{
      return null;
    }
  }

  void _result() {
    if( _key.currentState.validate())
    {

      var url = "${Network.alomnd_result}";
      http.post(
          url,
          headers: {"Accept": "application/json", "Authorization": _token},
          body: {
            'price': price.text,
            'quantity': quantity.text,
            'sales': sales.text,
          }).then((response) async {
        var margin = jsonDecode(response.body)['margin'];
        var value = jsonDecode(response.body)['value'];
        var cost = jsonDecode(response.body)['cost'];

        setState(() {
          _margin = margin.toStringAsFixed(2);
          _value = value.toStringAsFixed(2);
          _cost = cost.toStringAsFixed(2);
        });
      }).catchError((e) {
        print(e.toString());
      });

    }else{
      return null;
    }

  } // result

  _getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _token = prefs.getString('token');
    });
  }

  _getId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _token = (prefs.getString('token'));
    });
  }

  void changedType(String selectedType) {
    setState(() {
      _currentType = selectedType;
    });
  }

  void _save() {


  }

}
