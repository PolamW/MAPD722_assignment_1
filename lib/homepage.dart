import 'dart:html';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  RegExp numberValidator = RegExp("[0-9]+");
  bool isANumber = true;

  //use controller to get inputed text
  final _hourController = TextEditingController();
  final _rateController = TextEditingController();

  //store user text input into a variable
  String hours = '';
  String rate = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Pay Calculator')),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 8),
            TextField(
              controller: _hourController,
              keyboardType: TextInputType.number,
              // onChanged: (hours) {
              //   if (hours.isEmpty || numberValidator.hasMatch(hours)) {
              //     setValidator(true);
              //   } else {
              //     setValidator(false);
              //   }
              // },
              decoration: InputDecoration(
                hintText: 'Number of hours',
                border: OutlineInputBorder(),
                // errorText: isANumber ? null : "Please enter a valid number"
              ),
            ),
            SizedBox(height: 16),
            TextField(
              controller: _rateController,
              keyboardType: TextInputType.number,
              onChanged: (rate) {
                if (rate.isEmpty || numberValidator.hasMatch(rate)) {
                  setValidator(true);
                } else {
                  setValidator(false);
                }
              },
              decoration: InputDecoration(
                  hintText: 'Hourly rate',
                  border: OutlineInputBorder(),
                  errorText: isANumber ? null : "Please enter a valid rate"),
            ),
            SizedBox(height: 16),
            MaterialButton(
              onPressed: () {
                //get user new input and update
                setState(() {
                  hours = _hourController.text;
                  rate = _rateController.text;
                });
              },
              color: Colors.amber,
              child: Text('Calculate', style: TextStyle(color: Colors.white)),
            ),
            Expanded(
              child: Container(
                child: Center(
                  child: Text(hours + rate, style: TextStyle(fontSize: 30)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void setValidator(valid) {
    setState(() {
      isANumber = valid;
    });
  }
}
