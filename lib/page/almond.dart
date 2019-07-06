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
           size.length > 1 && type.length >  1  ?

          Container(
              //margin: EdgeInsets.only(top: 30.0, left: 20.0, right: ),
              padding: EdgeInsets.only(top: 30, bottom: 30, left: 30, right:30),

            child: Form(
              key: _key,
              autovalidate: _validate,
              child:
                  ListView(
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Expanded(
                            child: Text('Type', textAlign: TextAlign.center, style: TextStyle(fontSize: 20.0),),
                            flex: 1,
                          ),

                          Expanded(
                              flex: 2,
                              child:
                              Center(
                                child: new DropdownButtonFormField(
                                  validator: dropDownValidator,
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

                          Expanded(
                            flex: 1,
                            child: Text(''),
                          )
                        ],
                      ),

                      Row(
                        children: <Widget>[
                          Expanded(
                            child: Text('SIZE', textAlign: TextAlign.center,),
                            flex: 1,
                          ),

                          Expanded(
                              flex: 2,
                              child:
                              Center(
                                child: new DropdownButtonFormField(
                                  validator: dropDownValidator,
                                  items: size.map((sze) {
                                    return new DropdownMenuItem(
                                      child: new Text(sze),
                                      value: sze,
                                    );
                                  }).toList(),
                                  onChanged: (newVal) {
                                    setState(() {
                                      _mySize = newVal;
                                    });
                                  },
                                  hint: Text("SELECT ITEM"),
                                  value: _mySize,
                                ),

                              )
                          ),

                          Expanded(
                            flex: 1,
                            child: Text(''),
                          )
                        ],
                      ),

                      Row(
                        children: <Widget>[
                          Expanded(
                            flex: 1,
                            child: Text('PRICE', textAlign: TextAlign.center,),
                          ),
                          Expanded(
                            flex: 2,
                            child: TextFormField(
                              keyboardType: TextInputType.number,
                              validator: validatePrice,
                              controller: price,
                              style: TextStyle(fontSize: 20.0),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Text('lb in USD', textAlign: TextAlign.center,),
                          )
                        ],

                      ),
                      Row(
                        children: <Widget>[
                          Expanded(
                            flex: 1,
                            child: Text('QT', textAlign: TextAlign.center,),
                          ),
                          Expanded(
                            flex: 2,
                            child: TextFormField(
                              keyboardType: TextInputType.number,
                              validator: validateQuantity,
                              controller: quantity,
                              style: TextStyle(fontSize: 20.0),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Text('lb', textAlign: TextAlign.center,),
                          )
                        ],

                      ),
                      Row(
                        children: <Widget>[
                          Expanded(
                            flex: 1,
                            child: Text('SALES', textAlign: TextAlign.center,),
                          ),
                          Expanded(
                            flex: 2,
                            child: TextFormField(
                              keyboardType: TextInputType.number,
                              validator: validateSales,
                              controller: sales,
                              style: TextStyle(fontSize: 20.0),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Text('Tk/kg', textAlign: TextAlign.center,),
                          )
                        ],

                      ),

                      Divider(
                        height: 150.0,
                      ),

                      Row(
                        children: <Widget>[
                          Expanded(
                            child: Text('Margin', textAlign: TextAlign.center, style: TextStyle(fontSize: 25.0),),
                          ),
                          Expanded(
                            flex: 2,
                            child:
                            Text('$_margin', style: TextStyle(fontSize: 25.0), textAlign: TextAlign.center,),
                          ),
                          Expanded(
                            child: Text('TK', textAlign: TextAlign.left, style: TextStyle(fontSize: 25.0),),
                          ),
                        ],
                      ),
                      Row(
                        children: <Widget>[
                          Expanded(
                            child: Text('Value', textAlign: TextAlign.center, style: TextStyle(fontSize: 25.0),),
                          ),
                          Expanded(
                            flex: 2,
                            child:
                            Text('$_value', style: TextStyle(fontSize: 25.0), textAlign: TextAlign.center,),
                          ),
                          Expanded(
                            child: Text('TK', textAlign: TextAlign.left, style: TextStyle(fontSize: 25.0),),
                          ),
                        ],
                      ),
                      Row(
                        children: <Widget>[
                          Expanded(
                            child: Text('Cost', textAlign: TextAlign.center, style: TextStyle(fontSize: 25.0),),
                          ),
                          Expanded(
                            flex: 2,
                            child:
                            Text('$_cost', style: TextStyle(fontSize: 25.0), textAlign: TextAlign.center,),
                          ),
                          Expanded(
                            child: Text('TK', textAlign: TextAlign.left, style: TextStyle(fontSize: 25.0),),
                          ),
                        ],
                      ),

                      Divider(height: 80.0,),
                      Align(
                        alignment: Alignment.bottomCenter,
                        child:  Row(
                          children: <Widget>[
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

                                  ],
                                )
                            ),
                          ],
                        ),
                      ),

              ],

            ),
            ),)


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


  String dropDownValidator(value) {
    if(value == null)
      {
        return "Select an Item";
      }else{
      return null;
    }
  }
}
