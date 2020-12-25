import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    title: "Simple Interest Calculator",
    debugShowCheckedModeBanner: false,
    home: SIForm(),
    theme: ThemeData(
        primaryColor: Colors.indigo,
        accentColor: Colors.indigo,
        brightness: Brightness.dark),
  ));
}

class SIForm extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _SIFormState();
    throw UnimplementedError();
  }
}

class _SIFormState extends State<SIForm> {
  @override
  var _currencies = ['Rupees', 'Dollars', 'Pounds'];
  var _minPadding = 5.0;
  var _currentCurrency = 'Rupees';
  var displayResult = '';

  var _formKey = GlobalKey<FormState>();

  TextEditingController principalController = TextEditingController();
  TextEditingController roiController = TextEditingController();
  TextEditingController termController = TextEditingController();

  Widget build(BuildContext context) {
    // TODO: implement build
    TextStyle textStyle = Theme.of(context).textTheme.title;

    return Scaffold(
      appBar: AppBar(
        title: Text("Simple Interest Calculator"),
      ),
      resizeToAvoidBottomPadding: false,
      body: Form(
        key: _formKey,
          child: Padding(
        padding: EdgeInsets.all(_minPadding * 2),
        child: ListView(
          children: <Widget>[
            getAssetImage(),
            Padding(
                padding: EdgeInsets.only(top: _minPadding, bottom: _minPadding),
                child: TextFormField(
                  keyboardType: TextInputType.number,
                  style: textStyle,
                  validator: (String value){
                    if(value.isEmpty){
                      return 'Please enter the Principal amount';
                    }
                  },
                  controller: principalController,
                  decoration: InputDecoration(
                      labelText: "Principal",
                      labelStyle: textStyle,
                      errorStyle: TextStyle(
                        color: Colors.yellowAccent,
                        fontSize: 15.0
                      ),
                      hintText: "Enter Principal Amount",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0))),
                )),
            Padding(
                padding: EdgeInsets.only(top: _minPadding, bottom: _minPadding),
                child: TextFormField(
                  validator: (String value) {
                    if(value.isEmpty){
                      return 'Please enter the Rate of Interest';
                    }
                  },
                  keyboardType: TextInputType.number,
                  style: textStyle,
                  controller: roiController,
                  decoration: InputDecoration(
                      labelText: "Rate Of Interest",
                      hintText: "In percentage",
                      labelStyle: textStyle,
                      errorStyle: TextStyle(
                        color: Colors.yellowAccent,
                        fontSize: 15.0
                      ),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0))),
                )),
            Padding(
                padding: EdgeInsets.only(top: _minPadding, bottom: _minPadding),
                child: Row(
                  children: <Widget>[
                    Expanded(
                        child: TextFormField(
                      keyboardType: TextInputType.number,
                      style: textStyle,
                          validator: (String value) {
                            if(value.isEmpty){
                              return 'Please enter the Term';
                            }
                          },
                      controller: termController,
                      decoration: InputDecoration(
                          labelText: "Term",
                          labelStyle: textStyle,
                          hintText: "In years ",
                          errorStyle: TextStyle(
                              color: Colors.yellowAccent,
                              fontSize: 15.0
                          ),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5.0))),
                    )),
                    Container(
                      width: _minPadding * 5,
                    ),
                    Expanded(
                        child: DropdownButton<String>(
                      items: _currencies.map((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                      value: _currentCurrency,
                      onChanged: (String newValueSelected) {
                        _onDropDownItemSelected(newValueSelected);
                      },
                    )),
                  ],
                )),
            Padding(
                padding: EdgeInsets.only(top: _minPadding, bottom: _minPadding),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: RaisedButton(
                        color: Theme.of(context).accentColor,
                        textColor: Theme.of(context).primaryColorDark,
                        child: Text(
                          "Calculate",
                          textScaleFactor: 1.5,
                        ),
                        onPressed: () {

                          setState(() {
                            if(_formKey.currentState.validate()){
                              this.displayResult = _calculateReturns();

                            }
                          });
                        },
                      ),
                    ),
                    Expanded(
                      child: RaisedButton(
                        color: Theme.of(context).primaryColorDark,
                        textColor: Theme.of(context).primaryColorLight,
                        child: Text(
                          "Reset",
                          textScaleFactor: 1.5,
                        ),
                        onPressed: () {
                          setState(() {
                            _reset();
                          });
                        },
                      ),
                    ),
                  ],
                )),
            Padding(
              padding: EdgeInsets.all(_minPadding * 2),
              child: Text(
                this.displayResult,
                style: textStyle,
              ),
            )
          ],
        ),
      )),
    );
    throw UnimplementedError();
  }

  Widget getAssetImage() {
    AssetImage assetImage = AssetImage('images/money.png');
    Image image = Image(
      image: assetImage,
      width: 225.0,
      height: 225.0,
    );
    return Container(
      child: image,
      alignment: Alignment.center,
      padding: EdgeInsets.all(25.0),
    );
  }

  void _onDropDownItemSelected(String newValueSelected) {
    setState(() {
      this._currentCurrency = newValueSelected;
    });
  }

  String _calculateReturns() {
    double principal = double.parse(principalController.text);
    double roi = double.parse(roiController.text);
    double term = double.parse(termController.text);
    double totalAmt = principal + (principal * term * roi) / 100;
    String result =
        'After $term years, your investment will be worth $totalAmt $_currentCurrency';
    return result;
  }

  void _reset() {
    principalController.text = "";
    roiController.text = "";
    termController.text = "";
    displayResult = "";
    _currentCurrency = _currencies[0];
  }
}
