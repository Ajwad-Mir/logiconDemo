import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:logicon_demo/export.dart';

class SecondScreen extends GetView<MapPageController> {
  const SecondScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MapPageController>(
      builder: (_) => Scaffold(
        appBar: customAppBar(
          appBarText: textRes.secondScreen,
        ),
        body: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          color: colorRes.colorBlack,
          child: GoogleMap(
            initialCameraPosition: controller.initialCameraPosition,
            markers: controller.markers,
            zoomControlsEnabled: false,
            mapType: MapType.normal,
            onMapCreated: (GoogleMapController mapController){
              controller.googleMapController = mapController;
              controller.goToUserLocation();
            },
            onLongPress: (LatLng newPosition) {
              controller.updatePin(newPosition);
            },
          ),
        ),
      ),
    );
  }
}