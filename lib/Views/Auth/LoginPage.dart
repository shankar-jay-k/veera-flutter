import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:veera_education_flutter/Controllers/Colors.dart';
import 'package:veera_education_flutter/Views/Auth/OtpPage.dart';
import 'package:http/http.dart' as http;


class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  String country = '';
  double screenWidth = 0;
  @override
  void initState() {

    functionToGetUserCountry();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    print('screen width - ${MediaQuery.of(context).size.width}');
    return  Scaffold(
      backgroundColor: appColors.scaffold,
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          child: country == '' ?
           Center(
             child: CircularProgressIndicator(),)
           : Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              // First part: Image
              Image.asset(
                'assets/images/login.jpg', // Replace 'your_image.png' with your image path
                width: MediaQuery.of(context).size.width,
                height: 350,
                fit: BoxFit.contain,
              ),

              // Second part: Title and paragraph
              Padding(
                padding: const EdgeInsets.only(bottom: 88.0),
                child: Column(
                  children: [
                    Text(
                      'Login to continue',
                      style: TextStyle(fontSize: 24, fontFamily : 'poppins-bold'),
                    ),
                    SizedBox(height: 15),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 28.0),
                      child: Text(
                        "We'll send you an OTP to the number which you are going to enter.Make sure that you`re providing a valid number",
                        style: TextStyle(fontFamily: 'arial',letterSpacing: 2,fontSize: 18),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 45),
                      width:  screenUtils.getScreenWidth(context) > 500 ? screenUtils.getScreenWidth(context) * 0.6 : screenUtils.getScreenWidth(context) * 0.8,
                      decoration: BoxDecoration(
                        border: Border.all(color: appColors.ashGrey,width: 2),
                        borderRadius: BorderRadius.circular(5)
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            height:45,
                            width :45,
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
                            margin: EdgeInsets.only(left: 15),
                              width:  screenUtils.getScreenWidth(context) > 500 ?  screenUtils.getScreenWidth(context)  * 0.40 : screenUtils.getScreenWidth(context)  * 0.60,
                              child: TextFormField(
                                style: TextStyle(fontSize: 18,color: Colors.black,letterSpacing: 1.2),
                                inputFormatters: [
                                  LengthLimitingTextInputFormatter(10)
                                ],
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  prefixText: '+91 ',
                                  prefixStyle: TextStyle(fontSize: 18.5,color: Colors.black),
                                  hintText: 'Enter mobile number',
                                  hintStyle : TextStyle(fontSize: 16,color: Colors.black, ),
                                ),
                              ))
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              // Third part: Button
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => OtpPage(),
                  ));
                },
                child: Text('Get OTP',style: TextStyle(fontFamily: 'poppins-bold',fontSize: 20,color:Colors.black,letterSpacing: 2,),),
                style: ElevatedButton.styleFrom(
                  backgroundColor: appColors.lightGold,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 40, vertical: 16),
                ),
              ),
              SizedBox()
            ],
          ),
        ),
      ),
    );
  }
  functionToGetUserCountry() async{
    try {
      final response = await http.get(Uri.parse('http://ip-api.com/json/'));

      if (response.statusCode == 200) {

        print('Response body: ${response.body}');
        Map<String, dynamic> jsonResponse = jsonDecode(response.body);
        setState(() {
          // Extract and store the "country" field's value
          country = jsonResponse['country'];
        });
      } else {
        // Error handling
        print('Error: ${response.statusCode}');
      }
    } catch (e) {
      // Exception handling
      print('Exception: $e');
    }
    }
}
