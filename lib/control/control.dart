import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'CircleProgress.dart';

class NewControl extends StatefulWidget {
  const NewControl({Key? key}) : super(key: key);

  @override
  State<NewControl> createState() => _NewControlState();
}

class _NewControlState extends State<NewControl> with TickerProviderStateMixin{

  bool value1 = false;
  bool value2 = false;
  bool value3 = false;
  bool value4 = false;
  bool value5 = false;
  bool value6 = false;
  bool isLoading = false;

  final dbR = FirebaseDatabase.instance.reference();
  late AnimationController _animationController;
  late Animation<double> _animation;
  late AnimationController progressController;
  late Animation<double> tempAnimation;
  late Animation<double> humidityAnimation;
  @override
  void dispose() {
    _animationController.dispose();


    super.dispose();
  }
  @override
  void initState() {

    _animationController = AnimationController(vsync: this, duration:const Duration(seconds: 40));
    _animation = CurvedAnimation(parent: _animationController, curve: Curves.linear)..addListener(() {
      setState(() {

      });
    })..addStatusListener((animationStatus) {
      if(animationStatus == AnimationStatus.completed){
        _animationController.reset();
        _animationController.forward();

      }
    });
    _animationController.forward();
    super.initState();
    super.initState();

    dbR
        .child('ESP32_Device')
        .once()
        .then((DataSnapshot snapshot) {
      double t  = 20; //snapshot.value['Temperature']['Data'];
      double h = 30;//snapshot.value['Humidity']['Data'];

      isLoading = true;
      _dashboardInit(t, h);
    });
  }
  _dashboardInit(double temp, double humid) {
    progressController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 5000)); //5s

    tempAnimation =
    Tween<double>(begin: -50, end: temp).animate(progressController)
      ..addListener(() {
        setState(() {});
      });

    humidityAnimation =
    Tween<double>(begin: 0, end: humid).animate(progressController)
      ..addListener(() {
        setState(() {});
      });

    progressController.forward();
  }
  //////////////////////////////////////////////////////////////////////////////
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,

    ]);
    return  Scaffold(
      body:
      Stack(
        children: [
          CachedNetworkImage(
            imageUrl: 'https://miro.medium.com/max/1838/1*09PYj2KQ8fDLHlV0BPE7_A.jpeg',
            placeholder: (context, url) =>
                Image.asset(
                  'assets/images/smart1.jpeg', fit: BoxFit.fill,),
            errorWidget: (context, url, error) => const Icon(Icons.error),
            width: double.infinity,
            height: double.infinity,
            fit: BoxFit.cover,
            alignment: FractionalOffset(_animation.value, 0),
          ),
          ListView(
            children: [
              Column(
                children: [
                  const SizedBox(height: 30,),
                  Padding(
                    padding: const EdgeInsets.all(18),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Text(
                          "Smart Home Control",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 50,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      FloatingActionButton.extended(
                        onPressed: () {
                          setState(() {
                            value1 = !value1;
                          });
                          dbR.child("Light 1").set({"Switch 1": value1});
                        },
                        icon: value1
                            ? const Icon(Icons.lightbulb,size: 40,)
                            : const Icon(Icons.lightbulb_outline,size: 40,),
                        label: value1 ? const Text('ON',style: TextStyle(fontSize: 10),) : const Text('OFF',style: TextStyle(fontSize: 10),),
                        elevation: 20,
                        backgroundColor: value1 ? Colors.green : Colors
                            .white24,
                      ),
                      const SizedBox(width: 5,),
                      FloatingActionButton.extended(
                        onPressed: () {
                          setState(() {
                            value2 = !value2;
                          });
                          dbR.child("Light 2").set({"Switch 2": value2});
                        },
                        icon: value2
                            ? const Icon(Icons.lightbulb,size: 40,)
                            : const Icon(Icons.lightbulb_outline,size: 40,),
                        label: value2 ? const Text('ON',style: TextStyle(fontSize: 10),) : const Text('OFF',style: TextStyle(fontSize:10),),
                        elevation: 20,
                        backgroundColor: value2 ? Colors.green : Colors
                            .white24,
                      ),
                      const SizedBox(width: 5,),
                      FloatingActionButton.extended(
                        onPressed: () {
                          setState(() {
                            value3 = !value3;
                          });
                          dbR.child("Light 3").set({"Switch 3": value3});
                        },
                        icon: value3
                            ? const Icon(Icons.lightbulb,size: 40,)
                            : const Icon(Icons.lightbulb_outline,size: 40,),
                        label: value3 ? const Text('ON',style: TextStyle(fontSize: 10),) : const Text('OFF',style: TextStyle(fontSize: 10),),
                        elevation: 20,
                        backgroundColor: value3 ? Colors.green : Colors
                            .white24,
                      ),
                    ],
                  ),
                  const SizedBox(height:60,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      FloatingActionButton.extended(
                        onPressed: () {
                          setState(() {
                            value4 = !value4;
                          });
                          dbR.child("Power 1").set({"PowerOut 1": value4});
                        },
                        icon: value4
                            ? const Icon(Icons.power,size: 40,)
                            : const Icon(Icons.power_outlined,size: 40,),
                        label: value4 ? const Text('ON',style: TextStyle(fontSize: 10),) : const Text('OFF',style: TextStyle(fontSize: 10),),
                        elevation: 20,
                        backgroundColor: value4 ? Colors.green : Colors
                            .white24,
                      ),
                      const SizedBox(width: 5,),
                      FloatingActionButton.extended(
                        onPressed: () {
                          setState(() {
                            value5 = !value5;
                          });
                          dbR.child("Power 2").set({"PowerOut 2": value5});
                        },
                        icon: value5
                            ? const Icon(Icons.power,size: 40,)
                            : const Icon(Icons.power_outlined,size: 40,),
                        label: value5 ? const Text('ON',style: TextStyle(fontSize: 10),) : const Text('OFF',style: TextStyle(fontSize: 10),),
                        elevation: 20,
                        backgroundColor: value5 ? Colors.green : Colors
                            .white24,
                      ),
                      const SizedBox(width: 5,),
                      FloatingActionButton.extended(
                        onPressed: () {
                          setState(() {
                            value6 = !value6;
                          });
                          dbR.child("Power 3").set({"PowerOut 3": value6});
                        },
                        icon: value6
                            ? const Icon(Icons.power,size: 40,)
                            : const Icon(Icons.power_outlined,size: 40),
                        label: value6 ? const Text('ON',style: TextStyle(fontSize: 10),) : const Text('OFF',style: TextStyle(fontSize: 10),),
                        elevation: 20,
                        backgroundColor: value6 ? Colors.green : Colors
                            .white24,
                      ),
                    ],
                  ),

                ],
              ),
              const SizedBox(height: 50,),
              Center(
                  child: isLoading
                      ? Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      CustomPaint(
                        foregroundPainter:
                        CircleProgress(tempAnimation.value, true),
                        child: SizedBox(
                          width: 200,
                          height: 200,
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                const  Text('Temperature',
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white
                                  ),
                                ),
                                Text(
                                  '${tempAnimation.value.toInt()}',
                                  style:const TextStyle(
                                      fontSize: 50, fontWeight: FontWeight.bold,color: Colors.white),
                                ),
                                const Text(
                                  '°C',
                                  style: TextStyle(
                                      fontSize: 20, fontWeight: FontWeight.bold,color: Colors.white),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 30,),
                      CustomPaint(
                        foregroundPainter:
                        CircleProgress(humidityAnimation.value, false),
                        child: SizedBox(
                          width: 200,
                          height: 200,
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                const Text('Humidity',
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                                Text(
                                  '${humidityAnimation.value.toInt()}',
                                  style:const TextStyle(
                                    fontSize: 50, fontWeight: FontWeight.bold,color: Colors.white,),
                                ),
                                const Text(
                                  '%',
                                  style: TextStyle(
                                      fontSize: 20, fontWeight: FontWeight.bold,color: Colors.white),
                                ),
                              ],
                            ),
                          ),
                        ),
                      )
                    ],
                  )
                      :const Text(
                    'Loading...',
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                  )),
            ],
          ),
        ],
      ),

    );
  }

}
