import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logicon_demo/export.dart';

class FirstScreen extends GetView<MapPageController> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<MapPageController>(
      builder: (_) => Scaffold(
        appBar: customAppBar(
          appBarText: textRes.firstScreen,
        ),
        body: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          color: colorRes.colorBlack,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "User Location",
                style: TextStyle(
                  color: colorRes.colorWhite,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 15,),
              Text(
                (controller.pinLatitude.isEmpty) ? "Latitude: " : "Latitude: ${controller.pinLatitude}",
                style: TextStyle(
                  color: colorRes.colorWhite,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 15,),
              Text(
                (controller.pinLongtitude.isEmpty) ? "Longtitude: " : "Longtitude: ${controller.pinLongtitude}",
                style: TextStyle(
                  color: colorRes.colorWhite,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 15,),
              Text(
                (controller.pinAddress.isEmpty) ? "Address: " : "Address: ${controller.pinAddress}",
                style: TextStyle(
                  color: colorRes.colorWhite,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
              
              const SizedBox(height: 30,),
              OutlinedButton(
                onPressed: () {
                  Get.to(() => SecondScreen());
                },
                style: OutlinedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(24)
                  ),
                  foregroundColor: colorRes.colorWhite,
                  side: BorderSide(
                    color: colorRes.colorWhite,
                    width: 1.0
                  )
                ),
                child: Text(
                  textRes.getUserLocation,
                  style: TextStyle(
                    color: colorRes.colorWhite,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
