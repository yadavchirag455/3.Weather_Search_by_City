import 'package:flutter/material.dart';

class AskCity extends StatefulWidget {
  const AskCity({super.key});

  @override
  State<AskCity> createState() => _AskCityState();
}

class _AskCityState extends State<AskCity> {
  String? RequiredCityName;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xffFD7E77), Colors.white], // Gradient colors
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 14),
              child: TextField(
                onChanged: (value) {
                  print(value);
                  RequiredCityName = value;
                },
                decoration: InputDecoration(
                    icon: Icon(
                      Icons.account_balance,
                    ),
                    hintText: 'Enter The City Name',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10))),
              ),
            ),
            Container(
              padding: EdgeInsets.only(top: 30),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pop(context, RequiredCityName);
                },
                child: Text(
                  "Get Weather",
                  style: TextStyle(color: Colors.black),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
