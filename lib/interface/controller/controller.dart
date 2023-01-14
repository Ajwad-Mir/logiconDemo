import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapPageController extends GetxController {
  late GoogleMapController googleMapController;
  Set<Marker> markers = {};
  CameraPosition initialCameraPosition = const CameraPosition(target: LatLng(37.42796133580664, -122.085749655962), zoom: 15);
  
  late Position myLocation; //User Current Location
  late LatLng location; //custom Location


  String pinAddress = ""; // Pin Address
  String pinLatitude = ""; // Pin Address
  String pinLongtitude = ""; // Pin Address

  late bool locationServiceAvailability; 
  late LocationPermission allowLocationAccess; 

  Future<bool> getUserLocationPermission() async {
    locationServiceAvailability = await Geolocator.isLocationServiceEnabled();
    
    if (locationServiceAvailability == false) {
      Get.snackbar("Error", "Location Service is disabled. Please enable it.");
      return false;
    }

    allowLocationAccess = await Geolocator.checkPermission();
  
    if(allowLocationAccess == LocationPermission.denied){
      allowLocationAccess = await Geolocator.requestPermission();
      if(allowLocationAccess == LocationPermission.denied){
        Get.snackbar("Error", "Location Permission are denied by user");
        Get.defaultDialog(
          title: "Error",
          content: Text("Location permission is permenantly denied by user"),
        );
        return false;
      }
    }

    return true;
  }

  Future<Position> getCurrentUserPosition() async{
    await getUserLocationPermission();
    myLocation = await Geolocator.getCurrentPosition();
    return myLocation;
  }

  Future<void> goToUserLocation() async{
    var userLocation = await getCurrentUserPosition();
    googleMapController.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(target: LatLng(userLocation.latitude,userLocation.longitude),zoom: 15)));
    markers.clear();
    markers.add(Marker(markerId: const MarkerId('currentLocation'),position: LatLng(userLocation.latitude,userLocation.longitude),icon: BitmapDescriptor.defaultMarker));
    getPinLatitude();
    getPinLongtitude();
    getPinAddress();
    update();
  }

  Future<void> updatePin(LatLng newPositon) async{
    var customLocation = LatLng(newPositon.latitude, newPositon.longitude);
    googleMapController.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(target: LatLng(customLocation.latitude,customLocation.longitude),zoom: 15)));
    markers.clear();
    markers.add(Marker(markerId: const MarkerId('currentLocation'),position: LatLng(customLocation.latitude,customLocation.longitude),icon: BitmapDescriptor.defaultMarker));
    getPinLatitude();
    getPinLongtitude();
    getPinAddress();
    update();
  }


  getPinLatitude() {
    if(myLocation.latitude == markers.first.position.latitude){
      pinLatitude = myLocation.latitude.toString();
    }
    else{pinLatitude =  markers.first.position.latitude.toString();}
  }

  getPinLongtitude() {
    if(myLocation.longitude == markers.first.position.longitude){
      pinLongtitude = myLocation.longitude.toString();
    }
    else{pinLongtitude = markers.first.position.longitude.toString();}
    
  }

  getPinAddress() async{
    if(myLocation.latitude == markers.first.position.latitude && myLocation.longitude == markers.first.position.longitude) {
      await placemarkFromCoordinates(myLocation.latitude, myLocation.longitude).then((List<Placemark> placemarks) {
        Placemark place = placemarks[0];
        pinAddress = "${place.street}, ${place.subLocality}, ${place.subAdministrativeArea}, ${place.postalCode}";
      });
    }
    else {
      await placemarkFromCoordinates(markers.first.position.latitude, markers.first.position.longitude).then((List<Placemark> placemarks) {
          Placemark place = placemarks[0];
          pinAddress = "${place.street}, ${place.subLocality}, ${place.subAdministrativeArea}, ${place.postalCode}";
      });
    }
  }
}
