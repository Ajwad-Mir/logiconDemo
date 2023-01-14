import 'package:get/get.dart';
import 'package:logicon_demo/export.dart';

class initalBindings extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(() => MapPageController());
  }

}