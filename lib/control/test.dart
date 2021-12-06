

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class New extends StatefulWidget {
  const New({Key? key}) : super(key: key);

  @override
  State<New> createState() => _NewState();
}

class _NewState extends State<New> {
  final _dbR = FirebaseDatabase.instance.reference();
  String? _Temp  ;

  @override
  void initState() {

    super.initState();
    _activeLisen();

  }

  void _activeLisen(){


      _dbR.child("ESP32_Device").once().then((DataSnapshot data){
        String Temp = data.value["Humidity"];
        String Hum = data.value["Temperature"];

      setState(() {
        _Temp = 'Temperature: ${Temp}  // Humidity:  ${Hum}' as String;
      });
    });

  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        title: const Text("Ahmed",),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.only(top: 15.0),
          child: Column(
            children: [
              Text(_Temp!),
            ],
          ),
        ),
      ),
    );
  }



}













