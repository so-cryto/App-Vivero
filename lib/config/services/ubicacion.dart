import 'dart:async';
// ignore: depend_on_referenced_packages
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapaPage extends StatefulWidget {
  const MapaPage({Key? key}) : super(key: key);
  @override
  State<MapaPage> createState() => _MapaPageState();
}

class _MapaPageState extends State<MapaPage> {
  
  final Completer<GoogleMapController> _controller = Completer();
  
  @override
  Widget build(BuildContext context) {
    
    const CameraPosition puntoInicial = CameraPosition(
      target: LatLng(-25.2404278,-57.4630019),//-25.2404278,-57.4630019,17
      zoom: 16.5,
    );
    Set<Marker>markers = <Marker>{};
    markers.add(const Marker(markerId: MarkerId('geo-lacation'),
    position: LatLng(-25.24043089171703,-57.46041923677269)
    ));


    return  Scaffold(
      body: GoogleMap(
         mapType: MapType.normal,
        markers: markers,
         initialCameraPosition: puntoInicial,
         onMapCreated: (GoogleMapController controller){
          _controller.complete(controller);
         },
      ),
    );
  }
}