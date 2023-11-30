import 'package:tucamion/controller/connectivityController.dart';
import 'package:get/get.dart';
class DependencyInjection{
  static void init(){
    Get.put<ConnectivityController>(ConnectivityController(),permanent:true);
  }
}