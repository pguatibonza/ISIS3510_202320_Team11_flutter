import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ConnectivityController extends GetxController{
  final Connectivity _connectivity=Connectivity();
  static bool hasInternet=true;

  @override
  void onInit(){
    super.onInit();
    _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);

  }
  void _updateConnectionStatus(ConnectivityResult connectivityResult){
    if(connectivityResult==ConnectivityResult.none){
      hasInternet=false;
      Get.rawSnackbar(
     messageText: const Text("POR FAVOR CONECTESE A INTERNET"),
    isDismissible: false,

        duration: const Duration(days: 1),
        backgroundColor: Colors.red,
        icon:const Icon(Icons.wifi_off,color:Colors.white),
        margin:EdgeInsets.zero,
        snackStyle: SnackStyle.GROUNDED,
      );

    }
    else{
      hasInternet=true;
      if(Get.isSnackbarOpen){
        Get.closeCurrentSnackbar();
      }
    }
  }
}