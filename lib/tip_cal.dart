import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyAppp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text("Tip Calculator"),
          centerTitle: true,
          backgroundColor: Color(0xff11a6a6),
        ),
        body: TipCalculator(),
      ),
    );
  }
}

class TipCalculator extends StatefulWidget {
  @override
  _TipCalculatorState createState() => _TipCalculatorState();
}

class _TipCalculatorState extends State<TipCalculator> {
  double billAmount = 0.0;
  double tipPercentage = 0.1; // Default tip: 10%
  int splitCount = 1;
  TextEditingController billController = TextEditingController();
  TextEditingController customTipController = TextEditingController();

  // Function to calculate total per person
  double getTotalPerPerson() {
    double totalTip = billAmount * tipPercentage;
    double totalBill = billAmount + totalTip;
    return splitCount > 0 ? totalBill / splitCount : 0;
  }

  // Function to update the bill amount from input
  void updateBillAmount(String value) {
    setState(() {
      billAmount = double.tryParse(value) ?? 0.0;
    });
  }

  // Function to update the tip percentage
  void updateTipPercentage(double value) {
    setState(() {
      tipPercentage = value;
    });
  }

  // Function to update the custom tip percentage from input
  void updateCustomTip(String value) {
    setState(() {
      double? customTip = double.tryParse(value);
      if (customTip != null && customTip >= 0) {
        tipPercentage = customTip / 100; // Convert percentage to decimal
      }
    });
  }

  // Function to update the split count
  void updateSplitCount(int increment) {
    setState(() {
      splitCount = (splitCount + increment).clamp(1, 100); // Limit split to 1-100
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(height: 30),
          // Logo and Title Row
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: 80,
                child: Image.asset("assets/images/hat.png"),
              ),
              SizedBox(width: 10),
              Column(
                children: [
                  Text(
                    "Mr TIP",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 35),
                  ),
                  Text(
                    "Calculator",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: 25),
          // Total Per Person Display
          Container(
            width: 380,
            height: 200,
            margin: EdgeInsets.all(20),
            decoration: BoxDecoration(
              boxShadow: [BoxShadow(blurRadius: 5, color: Color(0xffcecece), spreadRadius: 1)],
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(18)),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Total p/person", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("\$", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22)),
                    Text(
                      getTotalPerPerson().toStringAsFixed(2),
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 48),
                    ),
                  ],
                ),
                Divider(color: Colors.black, thickness: 1, indent: 20, endIndent: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Column(
                      children: [
                        Text("Total bill", style: TextStyle(fontSize: 20)),
                        Text("\$${billAmount.toStringAsFixed(2)}",
                            style: TextStyle(fontSize: 20, color: Color(0xff11a6a6), fontWeight: FontWeight.bold)),
                      ],
                    ),
                    Column(
                      children: [
                        Text("Total tip", style: TextStyle(fontSize: 20)),
                        Text(
                          "\$${(billAmount * tipPercentage).toStringAsFixed(2)}",
                          style: TextStyle(fontSize: 20, color: Color(0xff11a6a6), fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(height: 30),
          // Bill Input Field
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Row(
              children: [
                Text("Enter your bill", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                SizedBox(width: 20),
                Expanded(
                  child: TextField(
                    controller: billController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      prefixIcon: Icon(CupertinoIcons.money_dollar, size: 28),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5), borderSide: BorderSide(color: Colors.blue)),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Color(0xffcbcbcb)),
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                    onChanged: updateBillAmount,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 30),
          // Tip Percentage Selection
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Choose your tip    ", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
              SizedBox(width: 1),
              Row(
                children: [0.1, 0.15, 0.2].map((percent) {
                  return GestureDetector(
                    onTap: () => updateTipPercentage(percent),
                    child: Container(
                      height: 50,
                      width: 60,
                      margin: EdgeInsets.symmetric(horizontal: 5),
                      decoration: BoxDecoration(
                        color: percent == tipPercentage ? Color(0xff11a6a6) : Colors.grey,
                        borderRadius: BorderRadius.all(Radius.circular(6)),
                      ),
                      child: Center(
                        child: Text(
                          "${(percent * 100).toInt()}%",
                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: Colors.white),
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ],
          ),
          SizedBox(height: 20),
          // Custom Tip Input Field
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Row(
              children: [
                Text("Custom Tip (%)", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                SizedBox(width: 20),
                Expanded(
                  child: TextField(
                    controller: customTipController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      hintText: "Enter tip percentage",
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5), borderSide: BorderSide(color: Colors.blue)),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Color(0xffcbcbcb)),
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                    onChanged: updateCustomTip,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 30),
          // Split the Bill
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(width: 25,),
              Text("Split the total", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
              SizedBox(width: 50),
              Row(
                children: [
                  IconButton(
                    onPressed: () => updateSplitCount(-1),
                    icon: Icon(Icons.remove, color: Colors.black),
                    color: Color(0xff11a6a6),
                  ),
                  Container(
                    width: 75,
                    height: 50,
                    alignment: Alignment.center,
                    child: Text("$splitCount", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(6),
                      border: Border.all(color: Colors.black12),
                    ),
                  ),
                  IconButton(
                    onPressed: () => updateSplitCount(1),
                    icon: Icon(Icons.add, color: Colors.black),
                    color: Color(0xff11a6a6),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
