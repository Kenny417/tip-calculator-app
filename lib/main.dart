import 'package:flutter/material.dart';

class TipCalculator extends StatelessWidget {
  double billAmount = 0.0;
  double tipPercentage = 20.0;


  String format(double n) {
    return n.toStringAsFixed(n.truncateToDouble() == n ? 0 : 2);
  }

  @override
  Widget build(BuildContext context) {
    // Create first input field
    TextField billAmountField = new TextField(
        decoration: new InputDecoration(
          labelText: "Bill amount(\$)"
        ),
        keyboardType: TextInputType.number,
        onChanged: (String value) {
          try {
            billAmount = double.parse(value.toString());
          } catch (exception) {
            billAmount = 0.0;
          }
        }
    );

    // Create another input field
    TextField tipPercentageField = new TextField(
        decoration: new InputDecoration(
          labelText: "Tip %",
          hintText: "20"
        ),
        keyboardType: TextInputType.number,
        onChanged: (String value) {
          try {
            tipPercentage = double.parse(value.toString());
          } catch (exception) {
            tipPercentage = 0.0;
          }
        }
    );

    // Create button
    RaisedButton calculateButton = new RaisedButton(
        child: new Text("Calculate"),
        onPressed: () {
          // Calculate tip and total
          double calculatedTip = billAmount * tipPercentage / 100.0;
          double total = billAmount + calculatedTip;
          String roundedTip = calculatedTip.toStringAsFixed(2);
          String roundedTotal = total.toStringAsFixed(2);
          String formattedTip = format(tipPercentage);
          String message = '';
          if (calculatedTip.truncateToDouble() != calculatedTip ) {
            message = "\n\nConsider rounding the tip up to the nearest whole dollar amount?";
          }

          // Generate dialog
          AlertDialog dialog = new AlertDialog(
              content: new Text("$formattedTip% tip: \$$roundedTip \n"
                  "Total: \$$roundedTotal "
                  "$message")
          );

          // Show dialog
          showDialog(context: context, child: dialog);
        }
    );

    Container container = new Container(
        padding: const EdgeInsets.all(16.0),
        child: new Column(
            children: [ billAmountField,
              tipPercentageField,
              calculateButton ]
        )
    );

    AppBar appBar = new AppBar(title: new Text("Tip Calculator"));

    Scaffold scaffold = new Scaffold(appBar: appBar,
        body: container);

    return scaffold;
  }
}

void main() {
  runApp(new MaterialApp(
    theme: ThemeData(
      primaryColor: Colors.red[400]
    ),
      title: 'Tip Calculator',
      home: new TipCalculator()
  ));
}



