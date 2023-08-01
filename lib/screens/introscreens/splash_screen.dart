// ignore: depend_on_referenced_packages
import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import 'package:flutter/cupertino.dart';
// ignore: depend_on_referenced_packages
import 'package:flutter/foundation.dart';
//import 'package:productos_app/config/router/app_router.dart';
import 'package:go_router/go_router.dart';


class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 3), (){
      context.push('/loginscreen');
    }
   );
  }

  @override
  Widget build(BuildContext context) {
    // ignore: prefer_const_constructors
    //Falta ajustar el Circularprogress se sale en pantallas grandes 
    return Scaffold(
      
      body: Center(
        child: SingleChildScrollView(
          child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          
          children: [
            Image.asset('assets/logohd.png',scale:5,),

            const SizedBox(height: 30,),
            if(defaultTargetPlatform == TargetPlatform.iOS)
            const CupertinoActivityIndicator(
              //color: Colors.white,
              radius: 20,
            )
            else
            const CircularProgressIndicator(
            
             
            ),
            //const Text('Version 2.0.1'),
          ],
          
        ),
        ),
      ),
    );
  }
}

