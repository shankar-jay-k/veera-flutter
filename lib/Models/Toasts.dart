


import 'package:fluttertoast/fluttertoast.dart';
import 'package:veera_education_flutter/Controllers/Colors.dart';

errortoast(text){

  return Fluttertoast.showToast(
      msg:text,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.CENTER,
      timeInSecForIosWeb: 1,
      backgroundColor: appColors.error,
      textColor: appColors.white,
      fontSize: 16.0
  );
}
successtoast(text){

  return Fluttertoast.showToast(
      msg:text,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.CENTER,
      timeInSecForIosWeb: 1,
      backgroundColor: appColors.success,
      textColor: appColors.white,
      fontSize: 16.0
  );
}