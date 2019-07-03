import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sohel_nuts/network/network.dart';


class Cashew extends StatefulWidget {
  @override
  _CashewState createState() => _CashewState();
}

class _CashewState extends State<Cashew> {

  var _token;
  var _id;

  List item=[];

  String item1;
  String item2;
  String item3;
  String item4;

  final quantity1 = TextEditingController();
  final quantity2 = TextEditingController();
  final quantity3 = TextEditingController();
  final quantity4 = TextEditingController();


  var qty1;
  var qty2;
  var qty3;
  var qty4;

  final salesPrice = TextEditingController();
  var sales;

  final price1 = TextEditingController();
  final price2 = TextEditingController();
  final price3 = TextEditingController();
  final price4 = TextEditingController();

  var pr1;
  var pr2;
  var pr3;
  var pr4;

  var _amount1 = 0.0;
  var _amount2 = 0.0;
  var _amount3 = 0.0;
  var _amount4 = 0.0;

  var _totalQuantity = 0;
  var _totalPrice = 0.0;
  var _totalAmount = 0.0;

  var margin = '0.0';
  var value = '0.0';
  var cost = '0.0';



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
    });
  }



  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getToken();
    _getId();
    getSize();
  }

  @override
  Widget build(BuildContext context) {
    return

    MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: new ThemeData(
        primarySwatch: Colors.green,
        // Your app THEME-COLOR
        textTheme: new TextTheme(
          body1: new TextStyle(color: Colors.green, fontSize: 30.0),
        ),
      ),
      home: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: true,
          centerTitle: true,
          title: Text('CASHEW NUTS'),
            leading: IconButton(icon:Icon(Icons.arrow_back),
              onPressed:() => Navigator.pop(context, false),
            )
        ),
        body:
        item.length  > 0 ?
        Container(
          padding: EdgeInsets.only(top: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Text('Item',),
                  Text('Quantity'),
                  Text('Price'),
                  Text('Amount'),
                ],
              ),

              Divider(height: 20.0,),


              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Container(
                    child: new DropdownButton(
                      items: item.map((item) {
                        return new DropdownMenuItem(
                          child: new Text(item),
                          value: item,
                        );
                      }).toList(),
                      onChanged: (newVal) {
                        setState(() {
                          item1 = newVal;
                        });
                      },
                      value: item1,
                    ),
                  ),

                  Container(
                    width: 70.0,
                    child: TextFormField(
                      controller: quantity1,
                    ),
                  ),
                  Container(
                    width: 70.0,
                    child: TextFormField(
                      controller: price1,
                    ),
                  ),

                  Text('$_amount1'),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Container(
                    child: new DropdownButton(
                      items: item.map((item) {
                        return new DropdownMenuItem(
                          child: new Text(item),
                          value: item,
                        );
                      }).toList(),
                      onChanged: (newVal) {
                        setState(() {
                          item2 = newVal;
                        });
                      },
                      value: item2,
                    ),
                  ),
                  Container(
                    width: 70.0,
                    child: TextFormField(
                      controller: quantity2,
                    ),
                  ),
                  Container(
                    width: 70.0,
                    child: TextFormField(
                      controller: price2,
                    ),
                  ),

                  Text('$_amount2'),
                ],
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Container(
                    child: new DropdownButton(
                      items: item.map((item) {
                        return new DropdownMenuItem(
                          child: new Text(item),
                          value: item,
                        );
                      }).toList(),
                      onChanged: (newVal) {
                        setState(() {
                          item3 = newVal;
                        });
                      },
                      value: item3,
                    ),
                  ),
                  Container(
                    width: 70.0,
                    child: TextFormField(
                      controller: quantity3,
                    ),
                  ),
                  Container(
                    width: 70.0,
                    child: TextFormField(
                      controller: price3,
                    ),
                  ),

                  Text('$_amount3'),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Container(
                    child: new DropdownButton(
                      items: item.map((item) {
                        return new DropdownMenuItem(
                          child: new Text(item),
                          value: item,
                        );
                      }).toList(),
                      onChanged: (newVal) {
                        setState(() {
                          item4 = newVal;
                        });
                      },
                      value: item4,
                    ),
                  ),
                  Container(
                    width: 70.0,
                    child: TextField(
                      controller: quantity4,
                    ),
                  ),
                  Container(
                    width: 70.0,
                    child: TextField(
                      controller: price4,
                    ),
                  ),

                  Text('$_amount4'),
                ],
              ),

              Divider(height: 50.0,),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Text('TOTAL', style: TextStyle(fontWeight: FontWeight.bold),),
                  Text('$_totalQuantity'),
                  Text('$_totalPrice'),
                  Text('$_totalAmount'),
                ],
              ), // Total

              Divider(height: 60,),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Text('Sales Price'),
                  Container(
                    width: 100.0,
                    child: TextFormField(
                      controller: salesPrice,
                    ),
                  )
                ],
              ),// Sales price

              Container(
                margin: EdgeInsets.only(top: 50.0, left: 50.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Text('Margin'),
                        Text('$margin'),
                        Text('TK'),
                      ],
                    ),
                    Divider(height: 40.0,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Text('Value'),
                        Text('$value'),
                        Text('TK'),
                      ],
                    ),
                    Divider(height: 40.0,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Text('Cost'),
                        Text('$cost'),
                        Text('TK'),
                      ],
                    ),
                    Divider(height: 40.0,),
                  ],
                ),
              ),

              Container(
                height: 80.0,
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  FlatButton( onPressed: _clear ,child: new Text('CLEAR', style: TextStyle(color: Colors.white, fontSize: 25.0),), color: Colors.green,),
                  FlatButton( onPressed: _show ,child: new Text('SHOW', style: TextStyle(color: Colors.white, fontSize: 25.0),), color: Colors.green,),
                  FlatButton( onPressed: _save ,child: new Text('SAVE', style: TextStyle(color: Colors.white, fontSize: 25.0),), color: Colors.green,),
                ],

              ),


            ],
          ),

        ) :
            Container(
              child: Center(
                child: CircularProgressIndicator(),
              ),
            )
      ),
    );

  }



  void _clear() {
    setState(() {
      quantity1.text = '';
      quantity2.text = '';
      quantity3.text = '';
      quantity4.text = '';

      price1.text = '';
      price2.text = '';
      price3.text = '';
      price4.text = '';

      salesPrice.text = '';

      _amount1 = 0.0;
      _amount2 = 0.0;
      _amount3 = 0.0;
      _amount4 = 0.0;

      _totalQuantity = 0;
      _totalPrice = 0.0;
      _totalAmount = 0.0;

      margin = '';
      value = '';
      cost = '';

    });

  }


  void _show() {

    setState(() {

      qty1 =   int.tryParse(quantity1.text);
      qty2 =   int.tryParse(quantity2.text);
      qty3 =   int.tryParse(quantity3.text);
      qty4 =   int.tryParse(quantity4.text);

      pr1 = double.tryParse(price1.text);
      pr2 = double.tryParse(price2.text);
      pr3 = double.tryParse(price3.text);
      pr4 = double.tryParse(price4.text);

      salesPrice.text;
      sales = double.tryParse(salesPrice.text);

      _amount1 = qty1 * pr1;
      _amount2 = qty2 * pr2;
      _amount3 = qty3 * pr3;
      _amount4 = qty4 * pr4;

      _totalQuantity = qty1 + qty2 + qty3 + qty4;
      _totalPrice = (pr1+pr2+pr3+pr4)/4;
      _totalAmount = _amount1 + _amount2 + _amount3 + _amount4;

      print('hello');
      print(item1 + item2 + item3 + item4);

      http.post(
          Network.cassia_result,
          headers: {"Accept": "application/json", "Authorization": _token},
          body: {
            "price" : "$_totalAmount",
            "sales" : salesPrice.text
          }
      ).then((response) async{
        var _margin = jsonDecode(response.body)['margin'];
        var _value = jsonDecode(response.body)['value'];
        var _cost = jsonDecode(response.body)['cost'];

        setState(() {
          margin = _margin.toStringAsFixed(2);
          value = _value.toStringAsFixed(2);
          cost = _cost.toStringAsFixed(2);
        });
      }).catchError((e) {
        print(e.toString());
      });




    });

    // http request

  }



  void _save() {

    http.post(
      Network.save_cashew,
      headers: {"Accept": "application/json", "Authorization": _token},
      body: {
        "user_id" : '1',
        "item1" : "12ds",
        "quantity1" : qty1.toString(),
        "price1" : pr1.toString(),
        "item2" : "12ds",
        "quantity2" : qty2.toString(),
        "price2" : pr2.toString(),
        "item3" : "12ds",
        "quantity3" : qty3.toString(),
        "price3" : pr3.toString(),
        "item4" : "12ds",
        "quantity4" : qty4.toString(),
        "price4" : pr4.toString(),
        "sales" : sales.toString()
      }
    ).then((response) async{
      print(response);
//      final snackBar = SnackBar(
//        content: Text('Yay! A SnackBar!'),
//      );
//      Scaffold.of(context).showSnackBar(snackBar);
    }).catchError((e) {
      print(e.toString());
    });
  }


  _getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _token = (prefs.getString('token'));
    });
  }

  _getId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _id = (prefs.getInt('id'));
    });
  }



}
