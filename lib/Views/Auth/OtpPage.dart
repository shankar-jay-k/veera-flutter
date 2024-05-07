import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';
import 'package:veera_education_flutter/Controllers/Colors.dart';
import 'package:veera_education_flutter/Views/HomePage/HomePage.dart';


class OtpPage extends StatefulWidget {
  const OtpPage({Key? key}) : super(key: key);

  @override
  State<OtpPage> createState() => _OtpPageState();
}

class _OtpPageState extends State<OtpPage> {
  final pinController = TextEditingController();
  final focusNode = FocusNode();
  final formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    pinController.dispose();
    focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const focusedBorderColor = appColors.lightGold;
    const fillColor = Colors.white;

    final defaultPinTheme = PinTheme(
      width: 46,
      height: 59,
      textStyle: const TextStyle(
        fontSize: 22,
        color: Color.fromRGBO(30, 60, 87, 1),
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: appColors.Shadow_Clr2,
            offset: const Offset(
              1.0,
              5.0,
            ),
            blurRadius:10.0,
          ),         ],
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: appColors.ashGrey,),
      ),
    );

    /// Optionally you can use form to validate the Pinput
    return Scaffold(
      body: Form(
        key: formKey,
        child: Column(

          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [

            // First part: Image
            Image.asset(
              'assets/images/login.jpg', // Replace 'your_image.png' with your image path
              width: MediaQuery.of(context).size.width,
              height: 250,
              fit: BoxFit.contain,
            ),

            Padding(
              padding: const EdgeInsets.only(bottom: 88.0),
              child: Column(
                children: [
                  Text(
                    'OTP verification',
                    style: TextStyle(fontSize: 24, fontFamily : 'poppins-bold'),
                  ),
                  SizedBox(height: 15),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 28.0),
                    child: Text(
                      "We've sent you an otp to your number +91${9344451200}.Enter the otp to continue",
                      style: TextStyle(fontFamily: 'arial',letterSpacing: 1.8,fontSize: 16,height: 1.5
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  SizedBox(height: 35,),
                  Pinput(
                    length: 6,
                    controller: pinController,
                    focusNode: focusNode,
                    // androidSmsAutofillMethod:
                    // AndroidSmsAutofillMethod.smsUserConsentApi,
                    // listenForMultipleSmsOnAndroid: true,
                    defaultPinTheme: defaultPinTheme,
                    separatorBuilder: (index) => const SizedBox(width: 8),
                    // validator: (value) {
                    //   return value == '2222' ? null : 'Pin is incorrect';
                    // },
                    // onClipboardFound: (value) {
                    //   debugPrint('onClipboardFound: $value');
                    //   pinController.setText(value);
                    // },
                    hapticFeedbackType: HapticFeedbackType.lightImpact,
                    onCompleted: (pin) {
                      debugPrint('onCompleted: $pin');
                    },
                    onChanged: (value) {
                      debugPrint('onChanged: $value');
                    },
                    cursor: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Container(
                          margin: const EdgeInsets.only(bottom: 9),
                          width: 22,
                          height: 1,
                          color: focusedBorderColor,
                        ),
                      ],
                    ),
                    focusedPinTheme: defaultPinTheme.copyWith(
                      decoration: defaultPinTheme.decoration!.copyWith(
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: focusedBorderColor),
                      ),
                    ),
                    submittedPinTheme: defaultPinTheme.copyWith(
                      decoration: defaultPinTheme.decoration!.copyWith(
                        color: fillColor,
                        borderRadius: BorderRadius.circular(19),
                        border: Border.all(color: focusedBorderColor),
                      ),
                    ),
                    errorPinTheme: defaultPinTheme.copyBorderWith(
                      border: Border.all(color: Colors.redAccent),
                    ),
                  ),
                ],
              ),
            ),

            ElevatedButton(
              onPressed: () {
                // focusNode.unfocus();
                // formKey.currentState!.validate();
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => HomePage(),
                ));
              },
              child: Text('Validate',style: TextStyle(fontFamily: 'poppins-bold',fontSize: 18,color:Colors.black,letterSpacing: 2,),),
              style: ElevatedButton.styleFrom(
                backgroundColor: appColors.lightGold,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                padding: EdgeInsets.symmetric(horizontal: 40, vertical: 16),
              ),
            ),
            SizedBox(height: 25,),

          ],
        ),
      ),
    );
  }
}
