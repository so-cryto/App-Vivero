// ignore: depend_on_referenced_packages
import 'package:flutter/material.dart';
import 'package:productos_app/shared/shared.dart';

class GpsScreen extends StatefulWidget {
   
  const GpsScreen({Key? key}) : super(key: key);

  @override
  State<GpsScreen> createState() => _GpsScreenState();
}

class _GpsScreenState extends State<GpsScreen> {
  @override
  Widget build(BuildContext context) {
    return  const Scaffold(
      body: Column(
          children:[
            Expanded(
              child: MapaPage()
            ),
          ],
        ),
        bottomNavigationBar: NavigationAppbar(),
    );
  }
} 
