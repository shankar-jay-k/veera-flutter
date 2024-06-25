import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:veera_education_flutter/Controllers/Colors.dart';
import 'package:http/http.dart' as http;
import 'package:veera_education_flutter/Models/LoadingWidget.dart';
import 'package:veera_education_flutter/Models/Toasts.dart';
import 'package:veera_education_flutter/Views/HomePage/HomePage.dart';

final userStorage = GetStorage();
class PlanDetails extends StatefulWidget {
  const PlanDetails({super.key});

  @override
  State<PlanDetails> createState() => _PlanDetailsState();
}

class _PlanDetailsState extends State<PlanDetails> {

  String chosenPlan = '';
  int chosenPlanTotal = 0;
  double chosenPlanGst = 0;
  double total = 0;
  String keyId = "rzp_test_gKANZdsNdLqaQs";
  String keySecret = "3UFrNGkdLR9apMa3dOUE1jvh";
  bool _whatsappNumber = true;
  bool _companyDetails = false;

  final _razorpay = Razorpay();

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
      _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
      _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
    });
    super.initState();
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    // Show loading with custom title
    startCustomTitleLoading('Redirecting to dashboard', context);

    // Print the response for debugging purposes
    print(response);

    // Wait for 3 seconds and then execute the following code
    Future.delayed(Duration(seconds: 3), () {
        userStorage.write('paidUser',true);
          setState(() {
                  });
          stopLoading(context);
          Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=>HomePage()));
          successToast('You`re in DashBoard');
      // Optionally verify the payment signature
      verifySignature(
        signature: response.signature,
        paymentId: response.paymentId,
        orderId: response.orderId,
      );
    });
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    print(response);
    // Do something when payment fails
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(response.message ?? ''),
      ),
    );
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    print(response);
    // Do something when an external wallet is selected
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(response.walletName ?? ''),
      ),
    );
  }

// create order
  void createOrder() async {
    String username = keyId;
    String password = keySecret;
    String basicAuth =
        'Basic ${base64Encode(utf8.encode('$username:$password'))}';

    Map<String, dynamic> body = {
      "amount": total * 100,
      "currency": "INR",
      "receipt": "rcptid_11"
    };
    var res = await http.post(
      Uri.https(
          "api.razorpay.com", "v1/orders"), //https://api.razorpay.com/v1/orders
      headers: <String, String>{
        "Content-Type": "application/json",
        'authorization': basicAuth,
      },
      body: jsonEncode(body),
    );

    if (res.statusCode == 200) {
      openGateway(jsonDecode(res.body)['id']);
    }
    print(res.body);
    stopLoading(context);
  }

  openGateway(String orderId) {
    var options = {
      'key': keyId,
      'amount': 100, //in the smallest currency sub-unit.
      'name': 'Veera`s Education',
      'order_id': orderId, // Generate order_id using Orders API
      'description': 'Payment for ${chosenPlan} month',
      'timeout': 60 * 5, // in seconds // 5 minutes
      'prefill': {
        'contact': '9123456789',
        'email': 'ary@example.com',
      }
    };
    _razorpay.open(options);
  }

  verifySignature({
    String? signature,
    String? paymentId,
    String? orderId,
  }) async {
    Map<String, dynamic> body = {
      'razorpay_signature': signature,
      'razorpay_payment_id': paymentId,
      'razorpay_order_id': orderId,
    };

    var parts = [];
    body.forEach((key, value) {
      parts.add('${Uri.encodeQueryComponent(key)}='
          '${Uri.encodeQueryComponent(value)}');
    });
    var formData = parts.join('&');
    var res = await http.post(
      Uri.https(
        "10.0.2.2", // my ip address , localhost
        "razorpay_signature_verify.php",
      ),
      headers: {
        "Content-Type": "application/x-www-form-urlencoded", // urlencoded
      },
      body: formData,
    );

    print(res.body);
    if (res.statusCode == 200) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(res.body),
        ),
      );
    }
  }

  @override
  void dispose() {
    _razorpay.clear(); // Removes all listeners
    super.dispose();
  }
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          margin:EdgeInsets.only( top:8),
          width: MediaQuery.of(context).size.width,
          padding: EdgeInsets.symmetric(vertical: 25),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: Colors.white
          ),
          child: Column(
            children: [
              Text('CHOOSE YOUR PLAN',style: TextStyle(fontFamily: 'apple-chancery',fontWeight: FontWeight.w800,fontSize: 19,),),
              SizedBox(height: 10,),
              Container(
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(5)
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10,vertical: 3),
                  child:Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Image.asset('assets/images/flags/India.png',height: 28,),
                      Text('  INDIA',style: TextStyle(fontFamily: 'poppins-medium',fontSize: 15,letterSpacing: 2),),
                    ],
                  ),

                ),
              ),
              SizedBox(height: 15,),
              Container(
                decoration: BoxDecoration(
                    color: Color(0xffeae5de),
                    border: Border.all(color: Colors.black26),
                    borderRadius: BorderRadius.circular(5)
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10,vertical: 3),
                  child: Text('Complete platform',style: TextStyle(fontFamily: 'poppins-medium',fontSize: 15,letterSpacing: 2),),
                ),
              ),
              SizedBox(height: 25,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  InkWell(
                    onTap: (){
                      chosenPlanTotal = 0;
                      chosenPlan = '1';
                      int price = int.parse(chosenPlan);
                      chosenPlanTotal = 830 * price;
                      chosenPlanGst = (chosenPlanTotal * 18) / 100;
                      total = chosenPlanGst + chosenPlanTotal;
                      setState(() {
                      });
                    },
                    child: Container(
                      margin: EdgeInsets.only(top: 5),
                      width: MediaQuery.of(context).size.width * 0.32,

                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        border: Border.all(color: chosenPlan == '1' ?  appColors.lightGold : appColors.Shadow_Clr2 ,width: 2),
                       boxShadow: [
                        BoxShadow(
                            color:chosenPlan == '1' ?  Colors.brown : Colors.black54,
                            offset: const Offset(
                              0.0,
                              12.0,
                            ),
                            blurRadius:0.0,
                            spreadRadius: 0
                          )
                        ],
                        color: chosenPlan == '1' ? appColors.lightGold : Color(0xffededed),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Text('Monthly Fee Plan',style: TextStyle(fontFamily: 'poppins-semibold'),textAlign: TextAlign.center),
                          ),
                          // Divider(color:chosenPlan == '1' ? Colors.white : Colors.grey[300],thickness: 1),
                          Container(
                            width: double.infinity,
                            height:160,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.vertical(bottom: Radius.circular(15))
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [

                                Padding(
                                  padding:   EdgeInsets.only(top: 15.0,left: screenUtils.getScreenWidth(context) > 500 ? 15 : 8),
                                  child:
                                  Text('₹ 830 / month',style: TextStyle(fontSize: screenUtils.getScreenWidth(context) > 500 ? 20 : 16,fontFamily: 'Poppins-SemiBold'),),

                                ),

                                SizedBox(),
                                Container(
                                  margin: EdgeInsets.symmetric(horizontal: 10),
                                  decoration: BoxDecoration(
                                      border: Border.all(color: Colors.brown),
                                      borderRadius: BorderRadius.circular(25)
                                  ),
                                  child: Padding(
                                    padding: EdgeInsets.all( screenUtils.getScreenWidth(context) > 500 ? 8.0 : 3),
                                    child: Center(
                                      child: Text('SUBSCRIBE',style:TextStyle(fontSize: screenUtils.getScreenWidth(context) > 500 ? 14 : 12)),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),

                        ],
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: (){
                      chosenPlanTotal = 0;
                      chosenPlan = '5';
                      int price = int.parse(chosenPlan);
                      chosenPlanTotal = 830 * price;
                      chosenPlanGst = (chosenPlanTotal * 18) / 100;
                      total = chosenPlanGst + chosenPlanTotal;
                      setState(() {

                      });
                    },
                    child: Container(
                      margin: EdgeInsets.only(top: 5),
                      width: MediaQuery.of(context).size.width * 0.32,

                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        border: Border.all(color: chosenPlan == '5' ?  appColors.lightGold : appColors.Shadow_Clr2 ,width: 2),
                        boxShadow: [

                          BoxShadow(
                              color:chosenPlan == '5' ?  Colors.brown : Colors.black54,
                              offset: const Offset(
                                0.0,
                                12.0,
                              ),
                              blurRadius:0.0,
                              spreadRadius: 0
                          )
                        ],
                        color: chosenPlan == '5' ? appColors.lightGold : Color(0xffededed),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Text('Extendable Plan 1',style: TextStyle(fontFamily: 'poppins-semibold'),textAlign: TextAlign.center),
                          ),
                          // Divider(color:chosenPlan == '1' ? Colors.white : Colors.grey[300],thickness: 1),
                          Container(
                            width: double.infinity,
                            height:160,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.vertical(bottom: Radius.circular(15))
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [

                                Padding(
                                  padding:   EdgeInsets.only(top: 15.0,left: screenUtils.getScreenWidth(context) > 500 ? 15 : 8),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text('₹ 830 / month',style: TextStyle(fontSize: screenUtils.getScreenWidth(context) > 500 ? 20 : 16,fontFamily: 'Poppins-SemiBold'),),
                                      SizedBox(height: 5,),
                                      Text('Pay 5 months & Get 1 month period free',style: TextStyle(fontSize:13,),),
                                    ],
                                  ),
                                ),

                                Container(
                                  margin: EdgeInsets.symmetric(horizontal: 10),
                                  decoration: BoxDecoration(
                                      border: Border.all(color: Colors.brown),
                                      borderRadius: BorderRadius.circular(25)
                                  ),
                                  child: Padding(
                                    padding: EdgeInsets.all( screenUtils.getScreenWidth(context) > 500 ? 8.0 : 3),
                                    child: Center(
                                      child: Text('SUBSCRIBE',style:TextStyle(fontSize: screenUtils.getScreenWidth(context) > 500 ? 14 : 12)),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),

                        ],
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: (){
                      chosenPlanTotal = 0;
                      chosenPlan = '10';
                      int price = int.parse(chosenPlan);
                      chosenPlanTotal = 830 * price;
                      chosenPlanGst = (chosenPlanTotal * 18) / 100;
                      total = chosenPlanGst + chosenPlanTotal;
                      setState(() {

                      });
                    },
                    child: Container(
                      margin: EdgeInsets.only(top: 5),
                      width: MediaQuery.of(context).size.width * 0.32,

                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        border: Border.all(color: chosenPlan == '10' ?  appColors.lightGold : appColors.Shadow_Clr2 ,width: 2),
                        boxShadow: [

                          BoxShadow(
                              color:chosenPlan == '10' ?  Colors.brown : Colors.black54,
                              offset: const Offset(
                                0.0,
                                12.0,
                              ),
                              blurRadius:0.0,
                              spreadRadius: 0
                          )
                        ],
                        color: chosenPlan == '10' ? appColors.lightGold : Color(0xffededed),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Text('Extendable Plan 2',style: TextStyle(fontFamily: 'poppins-semibold'),textAlign: TextAlign.center,),
                          ),
                          // Divider(color:chosenPlan == '1' ? Colors.white : Colors.grey[300],thickness: 1),
                          Container(
                            width: double.infinity,
                            height:160,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.vertical(bottom: Radius.circular(15))
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [

                                Padding(
                                  padding:   EdgeInsets.only(top: 15.0,left: screenUtils.getScreenWidth(context) > 500 ? 15 : 8),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text('₹ 830 / month',style: TextStyle(fontSize: screenUtils.getScreenWidth(context) > 500 ? 20 : 16,fontFamily: 'Poppins-SemiBold'),),
                                      SizedBox(height: 5,),
                                      Text('Pay 10 months & Get 5 month period free',style: TextStyle(fontSize:13,),),
                                    ],
                                  ),
                                ),

                                Container(
                                  margin: EdgeInsets.symmetric(horizontal: 10),
                                  decoration: BoxDecoration(
                                      border: Border.all(color: Colors.brown),
                                      borderRadius: BorderRadius.circular(25)
                                  ),
                                  child: Padding(
                                    padding: EdgeInsets.all( screenUtils.getScreenWidth(context) > 500 ? 8.0 : 3),
                                    child: Center(
                                      child: Text('SUBSCRIBE',style:TextStyle(fontSize: screenUtils.getScreenWidth(context) > 500 ? 14 : 12)),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),

                        ],
                      ),
                    ),

                  ),
                ],
              )
            ],
          ),
        ),
        if(chosenPlan != '')
        Container(
          margin:EdgeInsets.only(bottom: 15,top:8),
          width: MediaQuery.of(context).size.width,
          padding: EdgeInsets.symmetric(vertical: 25),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: appColors.scaffold
          ),
          alignment: Alignment.center,
          child: Container(
            width: MediaQuery.of(context).size.width * 0.75,
            margin:EdgeInsets.only( top:8,right: 25,left: 25),
            padding: EdgeInsets.symmetric(vertical: 25),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: appColors.Shadow_Clr2,
                  offset: const Offset(
                    1.0,
                    3.0,
                  ),
                  blurRadius:10.0,
                ),         ],
            ),
            child: Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text('ORDER SUMMARY',style: TextStyle(fontSize: 17,fontFamily: 'poppins-bold',letterSpacing: 2),),
                  SizedBox(height: 25,),
                  Center(
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.45,

                      child: Center(
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('${chosenPlan} Month  X 830',style: TextStyle(fontFamily: 'poppins-semibold'),),
                                Text('₹${chosenPlanTotal}',style: TextStyle(fontWeight: FontWeight.w800,fontSize: 16),),
                              ],
                            ),
                            SizedBox(height: 15,),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('GST  18%',style: TextStyle(fontFamily: 'poppins-semibold'),),
                                Text('₹${chosenPlanGst}',style: TextStyle(fontWeight: FontWeight.w800,fontSize: 16),),

                              ],
                            ),
                            SizedBox(height: 15,),
                            Divider(color: appColors.lightGold,thickness: 1,),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('TOTAL',style: TextStyle(fontFamily: 'poppins-semibold',fontSize: 17),),
                                Text('₹${total}',style: TextStyle(fontWeight: FontWeight.w800,fontSize: 16),),
                              ],
                            ),
                            Divider(color: appColors.lightGold,thickness: 1,),

                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 25,),
                  MaterialButton(
                      color: appColors.lightGold,
                      onPressed: (){

                          functionToRegisterUserDetails();
                        // startLoading(context);
                        // createOrder();
                      },
                      child: Text('PAY NOW',style: TextStyle(fontSize: 17,fontFamily: 'poppins-semibold',letterSpacing: 2,color: Colors.black),)                      ,)
                ],
              ),
            ),
          ),
        ),

      ],
    );
  }

   functionToRegisterUserDetails() {
      showDialog(
          context: context,
          barrierDismissible: false,
          builder: (context)=>
              StatefulBuilder(
                builder: (BuildContext context, StateSetter setState) {
                return Dialog(
                    alignment: Alignment.center,
                    backgroundColor: Colors.transparent,
                    insetPadding: EdgeInsets.symmetric(horizontal:screenUtils.getScreenWidth(context) > 500 ? 20 : 5) ,
                    child: Container(
                        width: screenUtils.getScreenWidth(context) > 500 ? screenUtils.getScreenWidth(context) * 0.85  : screenUtils.getScreenWidth(context),
                        height: screenUtils.getScreenHeight(context),
                        decoration: BoxDecoration(
                        ),
                      child: Center(
                        child: SingleChildScrollView(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                padding: EdgeInsets.only(left: 15,right: 8,top: 10,bottom: 10),
                                decoration: BoxDecoration(
                                  color: Color(0xffe4e4e4),
                                  borderRadius: BorderRadius.vertical(top: Radius.circular(20), bottom: Radius.circular(0)),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text('SignIn To Pay',style: TextStyle(fontFamily: 'poppins-semibold',fontSize: 18),),
                                    IconButton(
                                        onPressed: (){
                                          Navigator.pop(context);
                                        },
                                        icon: Icon(Icons.close,color: Colors.red)
                                    )
                                  ],
                                ),),
                              Container(
                                padding: EdgeInsets.all(8),
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  color : Colors.white,
                                  borderRadius: BorderRadius.vertical(bottom: Radius.circular(5))
                                ),
                                child: Column(
                                  children: [
                                    SizedBox(height: 15,),
                                    textInputWidget(screenUtils.getScreenWidth(context) > 500 ? screenUtils.getScreenWidth(context) * 0.6  : screenUtils.getScreenWidth(context) * 0.85, 'Full name'),
                                    textInputWidget(screenUtils.getScreenWidth(context) > 500 ? screenUtils.getScreenWidth(context) * 0.6  : screenUtils.getScreenWidth(context) * 0.85, 'Phone number'),
                                    if(!_whatsappNumber)
                                      textInputWidget(screenUtils.getScreenWidth(context) > 500 ? screenUtils.getScreenWidth(context) * 0.6  : screenUtils.getScreenWidth(context) * 0.85, 'Whatsapp number'),
                                    InkWell(
                                      onTap: (){
                                        setState((){
                                          _whatsappNumber = !_whatsappNumber;
                                        });
                                      },
                                      child: Padding(
                                        padding:  EdgeInsets.only(left: 8.0),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            Checkbox(
                                              activeColor: Color(0xffbe9f5d),
                                              value: _whatsappNumber,
                                              onChanged: (value) => {
                                                setState((){
                                                  _whatsappNumber = !_whatsappNumber;
                                                })
                                              },
                                            ),
                                            Text('Same for whatsapp number',style: TextStyle(color: Colors.black54,fontFamily: 'Poppins-Medium'),)
                                          ],
                                        ),
                                      ),
                                    ),
                                    textInputWidget(screenUtils.getScreenWidth(context) > 500 ? screenUtils.getScreenWidth(context) * 0.6  : screenUtils.getScreenWidth(context) * 0.85, 'E-mail address'),
                                    textInputWidget(screenUtils.getScreenWidth(context) > 500 ? screenUtils.getScreenWidth(context) * 0.6  : screenUtils.getScreenWidth(context) * 0.85, 'Country of residence'),
                                    Container(
                                      width: screenUtils.getScreenWidth(context) > 500 ? screenUtils.getScreenWidth(context) * 0.6  : screenUtils.getScreenWidth(context) * 0.85,
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          textInputWidget(screenUtils.getScreenWidth(context) > 500 ? screenUtils.getScreenWidth(context) * 0.28  : screenUtils.getScreenWidth(context) * 0.40, 'State'),
                                          textInputWidget(screenUtils.getScreenWidth(context) > 500 ? screenUtils.getScreenWidth(context) * 0.28  : screenUtils.getScreenWidth(context) * 0.40,  'City'),

                                        ],
                                      ),
                                    ),
                                    Container(
                                      width: screenUtils.getScreenWidth(context) > 500 ? screenUtils.getScreenWidth(context) * 0.6  : screenUtils.getScreenWidth(context) * 0.85,
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          textInputWidget(screenUtils.getScreenWidth(context) > 500 ? screenUtils.getScreenWidth(context) * 0.28  : screenUtils.getScreenWidth(context) * 0.40, 'Address'),
                                          textInputWidget(screenUtils.getScreenWidth(context) > 500 ? screenUtils.getScreenWidth(context) * 0.28  : screenUtils.getScreenWidth(context) * 0.40,  'Pincode'),

                                        ],
                                      ),
                                    ),
                                    InkWell(
                                      onTap: (){
                                        setState((){
                                          _companyDetails = !_companyDetails;
                                        });
                                      },
                                      child: Padding(
                                        padding:  EdgeInsets.only(left: 15.0),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            Checkbox(
                                              activeColor: Color(0xffbe9f5d),
                                              value: _companyDetails,
                                              onChanged: (value) => {
                                                setState((){
                                                  _companyDetails = !_companyDetails;
                                                })
                                              },
                                            ),
                                            Text('Add company details',style: TextStyle(color: Colors.black54,fontFamily: 'Poppins-Medium'),)
                                          ],
                                        ),
                                      ),
                                    ),
                                    if(_companyDetails)
                                    Column(
                                        children: [
                                          textInputWidget(screenUtils.getScreenWidth(context) > 500 ? screenUtils.getScreenWidth(context) * 0.6  : screenUtils.getScreenWidth(context) * 0.85, 'Company name'),
                                          textInputWidget(screenUtils.getScreenWidth(context) > 500 ? screenUtils.getScreenWidth(context) * 0.6  : screenUtils.getScreenWidth(context) * 0.85, 'GST number'),
                                        ],
                                      ),
                                    SizedBox(height: 50,),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        MaterialButton(
                                          height: 45,
                                          minWidth: screenUtils.getScreenWidth(context) > 500 ? 200 : screenUtils.getScreenWidth(context) * 0.40,
                                          color: appColors.ashGrey,
                                          child: Center(
                                              child: Text('CANCEL',style: TextStyle(fontFamily: 'Poppins-SemiBold'),)),
                                          onPressed: (){
                                            Navigator.of(context).pop();
                                            },
                                        ),
                                        SizedBox(width: screenUtils.getScreenWidth(context) * 0.04,),
                                        MaterialButton(
                                          height: 45,
                                          minWidth: screenUtils.getScreenWidth(context) > 500 ? 200 : screenUtils.getScreenWidth(context) * 0.40,
                                          color: appColors.lightGold,
                                          child: Center(
                                              child: Text('SAVE',style: TextStyle(fontFamily: 'Poppins-SemiBold'),)),
                                          onPressed: (){
                                            Navigator.of(context).pop();
                                            startLoading(context);
                                            createOrder();
                                          },
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 20,)
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                }
              ));
   }

   textInputWidget(double width,String label,){
    return  Container(
      margin: EdgeInsets.symmetric(vertical: 5),
      height:screenUtils.getScreenWidth(context) > 500 ? 50 : 45,
      width: width,
      child: TextFormField(
        decoration: InputDecoration(
          labelText: label,
          floatingLabelStyle: TextStyle(color: Color(0xffbe9f5d),fontSize: 16),
          labelStyle: TextStyle(fontFamily: "Poppins-Medium",color: Colors.black54,fontSize: 13),
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(width: 1,color: Colors.black54)
          ),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(width: 0.5,color: Color(0xffbe9f5d))
          ),
        ),

      ),
    );
   }
}
