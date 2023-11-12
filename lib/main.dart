import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue
      ),
      home: SplashScreen(),
    );
  }
}

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  StreamSubscription? subscription;

 Future checkConnection() async {
  var connectivityResult = await (Connectivity().checkConnectivity());

  if (connectivityResult == ConnectivityResult.mobile){
    Fluttertoast.showToast(msg: "Connected with mobile",timeInSecForIosWeb: 3,);
  }
  else if (connectivityResult == ConnectivityResult.wifi){
    Fluttertoast.showToast(
      msg: "Connected with wifi",timeInSecForIosWeb: 3,textColor: Colors.black,
      webBgColor: "linear-gradient(to right, #00b09b, #96c93d)");
  }
  else {
    Fluttertoast.showToast(msg: "Not Connected",timeInSecForIosWeb: 3);
  }
 }

@override
  void initState() {
   subscription = Connectivity().onConnectivityChanged.listen((event) {checkConnection(); });
    super.initState();
  }

 @override
  void dispose() {
    subscription!.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Internet Connection/Connectivity"),
        centerTitle: true,
      ),
      body: Center(
        child: OutlinedButton(child: Text("Check Connection"),
        onPressed: checkConnection,),
      ),
    );
  }
}