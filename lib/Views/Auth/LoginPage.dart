import 'dart:convert';
import 'dart:io';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mobile_number/mobile_number.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:veera_education_flutter/Controllers/Colors.dart';
import 'package:veera_education_flutter/Models/LoadingWidget.dart';
import 'package:veera_education_flutter/Models/Toasts.dart';
import 'package:veera_education_flutter/Views/Auth/OtpPage.dart';
import 'package:http/http.dart' as http;
import '../../Controllers/apiCalls.dart';


class LoginScreen extends StatefulWidget {
  final String resendPhoneNumber;
  const LoginScreen({super.key,required this.resendPhoneNumber});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  String country = '';
  double screenWidth = 0;
  String deviceModal = 'unknown';
  TextEditingController _phoneNumber = TextEditingController();
  List<String> _phoneNumbers = [];
  bool _isPermissionGranted = false;

  @override
  void initState() {
    if(widget.resendPhoneNumber != ''){
      _phoneNumber.text = widget.resendPhoneNumber;
    }
    functionToGetUserCountry();
    initDeviceInfo();
    super.initState();
  }

  Future<void> _requestPermissions() async {
    final phoneStatus = await Permission.phone.status;

    if (!phoneStatus.isGranted) {
      await Permission.phone.request();
    }

    if (await Permission.phone.isGranted) {
      setState(() {
        _isPermissionGranted = true;
      });
      _getPhoneNumbers();
    }
  }

  Future<void> _getPhoneNumbers() async {
    try {
      List<SimCard>? simCards = await MobileNumber.getSimCards;

      if (simCards != null && simCards.length != 0 ) {
        _phoneNumbers = simCards.map((sim) => sim.number ?? 'No number').toList();
         showDialog(
             barrierDismissible: false,
             context: context,
             builder: (context)=> Dialog(
               shape: RoundedRectangleBorder(
                 borderRadius: BorderRadius.circular(10),
               ),
               child: Container(
                 width: MediaQuery.of(context).size.width > 500 ? MediaQuery.of(context).size.width * 0.5 : MediaQuery.of(context).size.width * 0.7,
                 child: Column(
                   mainAxisSize: MainAxisSize.min,
                   children: [
                     Container(
                       width: double.infinity,
                       decoration: BoxDecoration(
                           borderRadius: BorderRadius.vertical(top: Radius.circular(10)),
                           color: appColors.ashGrey
                       ),
                       child: Center(
                         child: Column(
                           children: [
                             Container(
                                 margin:EdgeInsets.all(15),
                                 decoration: BoxDecoration(
                                     color: Colors.white70,
                                     borderRadius: BorderRadius.circular(500)
                                 ),
                                 child: Padding(
                                   padding: const EdgeInsets.all(12.0),
                                   child: Icon(
                                     Icons.phone_iphone_outlined,
                                     size: 40,
                                     color: appColors.lightGold,
                                   ),
                                 )),
                             Text("Please choose one of the numbers showing below to get otp ",style: TextStyle(fontFamily: 'Poppins-Medium',fontSize: 15, ),textAlign: TextAlign.center,),
                             SizedBox(height: 15,),
                           ],
                         ),
                       ),
                     ),
                     Container(
                       padding: EdgeInsets.symmetric(vertical: 10),
                       decoration: BoxDecoration(
                           borderRadius: BorderRadius.vertical(bottom: Radius.circular(10)),
                           color: Colors.white
                       ),
                       child: Column(
                         children: _phoneNumbers.map((sim) => InkWell(
                           onTap: (){
                             String number = sim.substring(2);
                             _phoneNumber.text  = number;
                             setState(() {});
                             Navigator.pop(context);
                           },
                           child: Container(
                             margin: EdgeInsets.symmetric(vertical: 5),
                             decoration: BoxDecoration(
                                 borderRadius: BorderRadius.circular(5),
                                 color: Colors.grey[200]
                             ),
                             child: Padding(
                               padding:  EdgeInsets.symmetric(vertical: 10.0,horizontal: 25),
                               child: Row(
                                 mainAxisSize: MainAxisSize.min,
                                 mainAxisAlignment: MainAxisAlignment.center,
                                 children: [
                                   Icon(Icons.call_outlined,color: Colors.grey,),
                                   SizedBox(width: 15,),
                                   Text('${sim}',style: TextStyle(fontFamily: 'Poppins-SemiBold',fontSize: 16),)
                                 ],
                               ),
                             ),
                           ),
                         )).toList()
                       ),
                     )
                   ],
                 ),
               ),
             ));
      } else {
       errorToast('You`ve no sim cards in your device');
      }
    } catch (e) {
      print('Failed to get phone numbers: $e');
    }
  }


  @override
  Widget build(BuildContext context) {
    // stopLoading(context);
    // Navigator.of(context).push(MaterialPageRoute(builder: (context)=>OtpPage(phoneNumber: _phoneNumber.text,)));

    print('screen width - ${MediaQuery.of(context).size.width}');
    return  Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        height: MediaQuery.of(context).size.height,
        child: country == '' ?
         Center(
           child: CircularProgressIndicator(),)
         : SingleChildScrollView(
           child: Container(
             height: MediaQuery.of(context).size.height,
             child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                SizedBox(height: 15,),

                // First part: Image
                Image.asset(
                  'assets/images/login.jpg', // Replace 'your_image.png' with your image path
                  width: MediaQuery.of(context).size.width,
                  height: 350,
                  fit: BoxFit.contain,
                ),


                // Second part: Title and paragraph
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom:18.0),
                      child: Column(
                        children: [
                          Text(
                            widget.resendPhoneNumber == '' ? 'Login to continue ' : 'Resend OTP',
                            style: TextStyle(fontSize: 24, fontFamily : 'poppins-bold'),
                          ),
                          SizedBox(height: 15),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 28.0),
                            child: Text(
                              widget.resendPhoneNumber == '' ? "We'll send you an OTP to the number which you are going to enter.Make sure that you`re providing a valid number" : "Do you want to get OTP again for the following number, +91${widget.resendPhoneNumber}.\nIf yes, please confirm the number and press the below button",
                              style: TextStyle(fontFamily: 'arial',letterSpacing: 2, ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          _phoneNumber.text.isEmpty
                           ?  Padding(
                             padding: const EdgeInsets.only(top: 40.0),
                             child: ElevatedButton(
                             onPressed: () {
                               _requestPermissions();
                               // setState(() {
                               //   _phoneNumber.text = '9344451201';
                               // });
                             },
                             child: Text('Choose your mobile number',style: TextStyle(fontFamily: 'poppins-bold',color:Colors.black,letterSpacing: 2,),),
                             style: ElevatedButton.styleFrom(
                               backgroundColor: appColors.lightGold,
                               shape: RoundedRectangleBorder(
                                 borderRadius: BorderRadius.circular(3),
                               ),
                               padding: EdgeInsets.symmetric(horizontal: 40, vertical: 8),
                             ),
                         ),
                           )
                           : Container(
                            margin: EdgeInsets.only(top: 45),
                            width:  screenUtils.getScreenWidth(context) > 500 ? screenUtils.getScreenWidth(context) * 0.6 : screenUtils.getScreenWidth(context) * 0.85,
                            decoration: BoxDecoration(
                              border: Border.all(color: appColors.ashGrey,width: 2),
                              borderRadius: BorderRadius.circular(5)
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Container(
                                  height:screenUtils.getScreenWidth(context) > 500 ? 45 : 30,
                                  width :screenUtils.getScreenWidth(context) > 500 ? 45 : 30,
                                  margin: EdgeInsets.only(left: 8),
                                  child: Image.asset('assets/images/flags/${country}.png',),
                                ),
                                Container(
                                  height:25,
                                  width :2,
                                  margin: EdgeInsets.only(left: 8),
                                  decoration: BoxDecoration(
                                      border: Border.all(color: appColors.lightGold),
                                      borderRadius: BorderRadius.circular(5)
                                  ),),
                                Container(
                                  margin: EdgeInsets.only(left: 5),
                                    width:  screenUtils.getScreenWidth(context) > 500 ?  screenUtils.getScreenWidth(context)  * 0.40 : screenUtils.getScreenWidth(context)  * 0.60,
                                    child: TextFormField(
                                      readOnly: true,
                                      controller: _phoneNumber,
                                      style: TextStyle(fontSize:screenUtils.getScreenWidth(context) > 500 ? 18 : 16,fontWeight: FontWeight.w700,color: Colors.black,letterSpacing: 2.5),
                                      inputFormatters: [
                                        LengthLimitingTextInputFormatter(10)
                                      ],
                                      keyboardType: TextInputType.number,
                                      decoration: InputDecoration(
                                        border: InputBorder.none,
                                        prefixText: '+91 ',
                                        prefixStyle: TextStyle(fontSize:screenUtils.getScreenWidth(context) > 500 ? 18.5 : 16,fontWeight: FontWeight.w700,color: Colors.black),
                                        hintText: 'Enter mobile number',
                                        hintStyle : TextStyle(fontSize:screenUtils.getScreenWidth(context) > 500 ? 16 : 14,color: Colors.black, ),
                                      ),
                                    ))
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                      // Third part: Button
                    if(_phoneNumber.text.isNotEmpty)
                    ElevatedButton(
                      onPressed: () {
                       if(_phoneNumber.text.length != 0 && !_phoneNumber.text.startsWith('0') && _phoneNumber.text.length == 10){
                                startLoading(context);
                             functionToSendOtp();
                       }
                       else{
                            errorToast('Please enter valid mobile number');
                         print('invalid');
                       }
                      },
                      child: Text(widget.resendPhoneNumber == '' ? 'Get OTP' : 'Resend OTP',style: TextStyle(fontFamily: 'poppins-bold',fontSize: 20,color:Colors.black,letterSpacing: 2,),),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: appColors.lightGold,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        padding: EdgeInsets.symmetric(horizontal: 40, vertical: 8),
                      ),
                    ),
                  ],
                ),
                SizedBox()

              ],
        ),
           ),
         ),
      ),
    );
  }

  Future<void> initDeviceInfo() async {
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    if (Platform.isAndroid) {
      AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
      setState(() {
        deviceModal = '${androidInfo.model ?? 'Unknown'} - Android';
        // osVersion = 'Android ${androidInfo.version.release}';
      });
    } else if (Platform.isIOS) {
      IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
      setState(() {
        deviceModal = '${iosInfo.utsname.machine ?? 'Unknown'} - iOS';
        // osVersion = '${iosInfo.systemName} ${iosInfo.systemVersion}';
      });
    }
  }

  functionToGetUserCountry() async{
    try {
      Map<String, dynamic> response = await GetMethod('http://ip-api.com/json/');
      print('response for calling location api : ${response}');

      if(response['status']  == 'success'){
        country = response['country'];
        setState(() {});
      }
    } catch (e) {
      // Exception handling
      print('Exception: $e');
      showDialog(
          context: context,
          builder: (context)=>AlertDialog(
            title: Text("Error"),
            content: Text('Please check your internet or try again later'),
            actions: [
              MaterialButton(onPressed: (){
                Navigator.of(context).pop();
                functionToGetUserCountry();
              },child: Text('ok'),)
            ],
          ));
      }
    }

  functionToSendOtp() async{
    try {
      Map<String, dynamic> body = {
        'phoneCode' : '+91',
        'phoneNo' : '${_phoneNumber.text}'
      };

      var responseData = await http.post(Uri.parse('https://veeras-edu-api.onrender.com/auth/signin'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'deviceId' : deviceModal,
        },
        body: jsonEncode(body), // Encode the body as JSON string
      );

      Map<String, dynamic> response = json.decode(responseData.body);

      print('response for getting otp api : ${response}');

      if(response['meta']['code']  == 200){
        stopLoading(context);
        functionToShowOtpSentPopup();

        setState(() {});
      }
      else{
        stopLoading(context);
        errorToast('Phone number is invalid');
      }
    } catch (e) {
      // Exception handling
      print('Exception getting otp: $e');
      stopLoading(context);

      showDialog(
          context: context,
          builder: (context)=>AlertDialog(
            title: Text("Error"),
            content: Text('Please check your internet or try again later'),
            actions: [
              MaterialButton(onPressed: (){
                Navigator.of(context).pop();

                functionToSendOtp();
              },child: Text('ok'),)
            ],
          ));
    }
  }
  functionToShowOtpSentPopup(){
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context)=>  Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          child: Container(
            width: MediaQuery.of(context).size.width > 500 ? MediaQuery.of(context).size.width * 0.5 : MediaQuery.of(context).size.width * 0.7,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.vertical(top: Radius.circular(10)),
                      color: appColors.ashGrey
                  ),
                  child: Center(
                    child: Column(
                      children: [
                        Container(
                            margin:EdgeInsets.all(15),
                            decoration: BoxDecoration(
                                color: Colors.white70,
                                borderRadius: BorderRadius.circular(500)
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: Image.network('https://static.vecteezy.com/system/resources/previews/018/251/138/non_2x/check-mark-symbol-on-transparent-background-free-png.png',height: 40,color: appColors.lightGold,),
                            )),
                        Text("OTP has been successfully \nsent to your number",style: TextStyle(fontFamily: 'Poppins-Medium',fontSize: 15, ),textAlign: TextAlign.center,),
                        SizedBox(height: 15,),
                      ],
                    ),
                  ),
                ),
                Container(

                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.vertical(bottom: Radius.circular(10)),
                      color: Colors.white
                  ),
                  child: Align(
                    alignment: Alignment.bottomRight,
                    child: InkWell(
                      onTap: (){
                        Navigator.of(context).pop();
                          Navigator.of(context).push(MaterialPageRoute(builder: (context)=>OtpPage(phoneNumber: _phoneNumber.text,)));
                      },
                      child: Container(
                        margin: EdgeInsets.all(20),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: appColors.lightGold
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0,horizontal: 18),
                          child: Text('Continue',style: TextStyle(fontFamily: 'Poppins-SemiBold'),),
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ));
  }
}
