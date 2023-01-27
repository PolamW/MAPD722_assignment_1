import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // RegExp numberValidator = RegExp("[0-9]+");
  // bool isANumber = true;

  //use controller to get inputed text
  final _hourController = TextEditingController();
  final _rateController = TextEditingController();

  //store user text input into a variable
  var hours = "0.0";
  var rate = "0.0";
  var regularPay = "0.0";
  var overtimePay = "0.0";
  var totalPay = "0.0";
  var tax = "0.0";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Pay Calculator')),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 8),
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
              decoration: const InputDecoration(
                hintText: 'Number of hours',
                border: OutlineInputBorder(),
                // errorText: isANumber ? null : "Please enter a valid number"
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _rateController,
              keyboardType: TextInputType.number,
              // onChanged: (rate) {
              //   if (rate.isEmpty || numberValidator.hasMatch(rate)) {
              //     setValidator(true);
              //   } else {
              //     setValidator(false);
              //   }
              // },
              decoration: const InputDecoration(
                hintText: 'Hourly rate',
                border: OutlineInputBorder(),
                // errorText: isANumber ? null : "Please enter a valid rate"),
              ),
            ),
            const SizedBox(height: 16),
            MaterialButton(
              onPressed: () {
                //get user new input
                var numberOfHours = _hourController.text.toString();
                var numberOfRate = _rateController.text.toString();
                //validate user input
                if (numberOfHours == "" && numberOfRate == "") {
                  showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                            title: const Text("Error!"),
                            content:
                                const Text("Please fill in with valid number!"),
                            actions: [
                              TextButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: const Text("Back"))
                            ],
                          ));
                } else {
                  calculation(
                      double.parse(numberOfHours), double.parse(numberOfRate));
                  debugPrint(regularPay);
                  debugPrint(totalPay);
                  setState(() {
                    regularPay = "\$$regularPay";
                    overtimePay = "\$$overtimePay";
                    totalPay = "\$$totalPay";
                    tax = "\$$tax";
                  });
                }
              },
              color: Colors.amber,
              child: const Text('Calculate',
                  style: TextStyle(color: Colors.white)),
            ),
            const SizedBox(height: 20),
            const Text(
              "Report",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const Divider(
              color: Colors.black,
            ),
            // const SizedBox(height: 4),
            Container(
              width: 350,
              alignment: Alignment.center,
              child: Column(children: [
                Text(
                  "Regular Pay: $regularPay",
                  style: const TextStyle(fontSize: 14),
                ),
                const SizedBox(height: 4),
                Text(
                  "Overtime Pay: $overtimePay",
                  style: const TextStyle(fontSize: 14),
                ),
                const SizedBox(height: 4),
                Text(
                  "Total Pay: $totalPay",
                  style: const TextStyle(fontSize: 14),
                ),
                const SizedBox(height: 4),
                Text(
                  "Tax: $tax",
                  style: const TextStyle(fontSize: 14),
                ),
              ]),
            ),
            Container(
                margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    color: const Color.fromRGBO(255, 193, 7, 1),
                    borderRadius: BorderRadius.circular(20)),
                width: 350,
                child: Column(children: const [
                  Text("Student Name: Po Lam Wong"),
                  Text("Student ID: 301258847"),
                ]))
          ],
        ),
      ),
    );
  }

  void calculation(double numOfHours, double hourlyRate) {
    if (numOfHours <= 40) {
      totalPay = (numOfHours * hourlyRate).toString();
      overtimePay = "0.0";
      regularPay = totalPay;
      tax = (double.parse(regularPay) * 0.18).toString();
    } else if (numOfHours > 40) {
      overtimePay = ((numOfHours - 40) * hourlyRate * 1.5).toString();
      regularPay = (40 * hourlyRate).toString();
      totalPay =
          (double.parse(overtimePay) + double.parse(regularPay)).toString();
      tax = (double.parse(totalPay) * 0.18).toString();
    }
    _hourController.text = "";
    _rateController.text = "";
  }
}
