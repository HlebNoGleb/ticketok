
import 'package:connectivity_plus/connectivity_plus.dart';

Future<bool> checkInternetConnection() async{
  var result = await (Connectivity().checkConnectivity());
    
  return checkInternetByConnectivityResult(result) ;
}

bool checkInternetByConnectivityResult(ConnectivityResult result) {
  return result == ConnectivityResult.wifi || 
  result == ConnectivityResult.ethernet || 
  result == ConnectivityResult.mobile;
}