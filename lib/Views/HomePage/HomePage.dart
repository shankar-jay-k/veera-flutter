import 'dart:developer';
import 'dart:io';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:veera_education_flutter/Controllers/Colors.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:veera_education_flutter/Views/HomePage/ClassRoom/index.dart';
import 'package:veera_education_flutter/Views/HomePage/Footer.dart';
import 'package:veera_education_flutter/Views/HomePage/OurJourney.dart';
import 'package:veera_education_flutter/Views/HomePage/PlanDetails.dart';
import 'package:veera_education_flutter/Models/Toasts.dart';
import 'package:veera_education_flutter/Models/appBarButtons.dart';
import 'package:veera_education_flutter/testFile.dart';
import 'DemoClassCards.dart';
import 'VeeraMethodWorks.dart';


class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  int _currentIndex= 0;
  late QRViewController controller;
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appColors.scaffold,
      appBar: AppBar(
        toolbarHeight: 80,
        backgroundColor: Colors.white,
        elevation: 6,
        leading: Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: Image.asset(
            'assets/images/newLogo.png',
            width: MediaQuery.of(context).size.width * 0.45,

            fit: BoxFit.contain,
          ),
        ),
        leadingWidth: MediaQuery.of(context).size.width * 0.5,

      actions: [
          appBarButton(
              title: 'Scan',
              icon: Icon(Icons.qr_code_scanner_outlined, color: Colors.black,),
              onTap: (){
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => QRViewExample(),
                ));
              }
          ),
          appBarButton(
              title: 'Notify',
              icon: Icon(Icons.notifications_outlined, color: Colors.black,),
              onTap: () {}
          ),
          appBarButton(
              title: 'Profile',
              icon: Icon(Icons.account_circle_outlined, color: Colors.black,),
              onTap: (){
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => testFile(),
                ));
              }
          ),
        ],
      ),

      body: SingleChildScrollView(
        child: Column(
          children: [

            SizedBox(height: 5,),
            CarouselSlider.builder(
              itemCount: 3,
              itemBuilder: (BuildContext context, int index, int realIndex) {
                return Container(
                  width: MediaQuery.of(context).size.width ,

                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.0),
                    image: DecorationImage(
                      image: AssetImage('assets/images/banner${index == 2 ? 1 : index+1}.png'),
                      fit: BoxFit.fill,
                    ),
                  ),
                );
              },
              options: CarouselOptions(
                height: screenUtils.getScreenWidth(context) > 500 ?  250 : 180.0,
                aspectRatio: MediaQuery.of(context).size.width,
                autoPlay: true,
                autoPlayCurve: Curves.fastOutSlowIn,
                enableInfiniteScroll: true,
                autoPlayAnimationDuration: Duration(milliseconds: 800),
                viewportFraction: 1,
                onPageChanged: (index, reason) {
                  setState(() {
                    _currentIndex = index;
                  });
                },
              ),
            ),
            SizedBox(height: 12,),
            DotIndicator(
              itemCount: 3,
              currentIndex: _currentIndex,
              color: Colors.grey, // Change dot color as needed
              dotSize: 8.0, // Change dot size as needed
              dotSpacing: 12.0, // Change dot spacing as needed
              dotIndicatorType: DotIndicatorType.circle, // Change dot shape as needed
            ),

            ///This is how Veera's  method works
            VeeraMethodWorks(),

            ///Demo class section
             Container(
               margin:EdgeInsets.only(bottom: 25,top:8),
               width: MediaQuery.of(context).size.width * 0.9,
               padding: EdgeInsets.all(5),
               decoration: BoxDecoration(
                 borderRadius: BorderRadius.circular(12),
                 // boxShadow: [
                 //   BoxShadow(
                 //     color: appColors.Shadow_Clr2,
                 //     offset: const Offset(
                 //       1.0,
                 //       3.0,
                 //     ),
                 //     blurRadius:10.0,
                 //   ),
                 // ],
                 color: Color(0xabebf2fc)
               ),
               child: Padding(
                 padding: const EdgeInsets.symmetric(vertical: 20.0),
                 child: Column(
                   children: [
                     Text('DEMO CLASS',style: TextStyle(fontSize: 17,color:Colors.black,fontFamily: 'poppins-bold',letterSpacing: 1.5),),
                     Divider(thickness: 4,color: appColors.lightGold,endIndent: 150,indent: 155,),
                     SizedBox(height: 15,),

                     InkWell(
                         onTap: (){
                           Navigator.of(context).push(
                               MaterialPageRoute(builder: (context)=> IndexForClassRoom())
                           );
                         },
                         child: DemoClassCard(image: 'assets/images/4.png',title: 'FORMULA')),
                     Container(
                       margin: EdgeInsets.symmetric(vertical: 15),
                       decoration: BoxDecoration(
                         boxShadow: [
                           BoxShadow(
                             color: appColors.white,
                             offset: const Offset(
                               1.0,
                               3.0,
                             ),
                             blurRadius:10.0,
                           ),         ],
                         borderRadius: BorderRadius.circular(100),
                         color: Colors.white
                       ),
                       child: Padding(
                         padding: EdgeInsets.all(5),
                         child: Icon(Icons.add,size: 30,),
                       ),
                      ),

                     DemoClassCard(image: 'assets/images/5.png',title: 'CLASSROOM'),
                     Container(
                       margin: EdgeInsets.only(top: 15),
                       decoration: BoxDecoration(
                           boxShadow: [
                             BoxShadow(
                               color: appColors.Shadow_Clr2,
                               offset: const Offset(
                                 1.0,
                                 3.0,
                               ),
                               blurRadius:10.0,
                             ),         ],
                           borderRadius: BorderRadius.circular(100),
                           color: Colors.white
                       ),
                       child: Padding(
                         padding: EdgeInsets.all(5),
                         child: Icon(Icons.add,size: 30,),
                       ),
                     ),


                     DemoClassCard(image: 'assets/images/6.png',title: 'SELF PRACTICE'),
                     Container(
                       margin: EdgeInsets.only(top: 15),
                       decoration: BoxDecoration(
                           boxShadow: [
                             BoxShadow(
                               color: appColors.Shadow_Clr2,
                               offset: const Offset(
                                 1.0,
                                 3.0,
                               ),
                               blurRadius:10.0,
                             ),         ],
                           borderRadius: BorderRadius.circular(100),
                           color: Colors.white
                       ),
                       child: Padding(
                         padding: EdgeInsets.all(5),
                         child: Icon(Icons.add,size: 30,),
                       ),
                     ),


                     DemoClassCard(image: 'assets/images/5.png',title: 'SPEAKING ROOM'),
                   ],
                 ),
               ),
             ),

            ///plan details
            PlanDetails(),

            ///our journey
            OurJourney(),


            ///footer
           Footer()
    ],
        ),
      ),
    );
  }
}


enum DotIndicatorType {
  circle,
  square,
}

class DotIndicator extends StatelessWidget {
  final int itemCount;
  final int currentIndex;
  final Color color;
  final double dotSize;
  final double dotSpacing;
  final DotIndicatorType dotIndicatorType;

  const DotIndicator({
    required this.itemCount,
    required this.currentIndex,
    required this.color,
    this.dotSize = 8.0,
    this.dotSpacing = 10.0,
    this.dotIndicatorType = DotIndicatorType.circle,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        itemCount,
            (index) => _buildDot(index),
      ),
    );
  }

  Widget _buildDot(int index) {
    return Container(
      width: dotSize,
      height: dotSize,
      margin: EdgeInsets.symmetric(horizontal: dotSpacing / 2),
      decoration: BoxDecoration(
        shape: dotIndicatorType == DotIndicatorType.circle
            ? BoxShape.circle
            : BoxShape.rectangle,
        color: index == currentIndex ? color : color.withOpacity(0.4),
      ),
    );
  }
}

class QRViewExample extends StatefulWidget {
  const QRViewExample({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _QRViewExampleState();
}

class _QRViewExampleState extends State<QRViewExample> {
  Barcode? result;
  QRViewController? controller;
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');

  // In order to get hot reload to work we need to pause the camera if the platform
  // is android, or resume the camera if the platform is iOS.
  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller!.pauseCamera();
    }
    controller!.resumeCamera();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appColors.scannerBg,
      body: Column(
        children: <Widget>[

          Expanded(flex: 4, child: _buildQrView(context)),

        ],
      ),
    );
  }

  Widget _buildQrView(BuildContext context) {
    // For this example we check how width or tall the device is and change the scanArea and overlay accordingly.
    var scanArea = (MediaQuery.of(context).size.width < 400 ||
        MediaQuery.of(context).size.height < 400)
        ? 150.0
        : 320.0;
    // To ensure the Scanner view is properly sizes after rotation
    // we need to listen for Flutter SizeChanged notification and update controller
    return QRView(
      key: qrKey,
      onQRViewCreated: _onQRViewCreated,
      overlay: QrScannerOverlayShape(
          borderColor: appColors.white,
          borderRadius: 10,
          overlayColor: appColors.scannerBg,
          borderLength: 60,
          borderWidth: 20,
          cutOutBottomOffset: 50,
          cutOutSize: scanArea),
      onPermissionSet: (ctrl, p) => _onPermissionSet(context, ctrl, p),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    setState(() {
      this.controller = controller;
    });
    controller.scannedDataStream.listen((scanData) {
      successtoast('Qr scanned data : ${scanData}');
    Navigator.of(context).push(
      MaterialPageRoute(builder: (context)=> HomePage())
    );
    });
  }

  void _onPermissionSet(BuildContext context, QRViewController ctrl, bool p) {
    log('${DateTime.now().toIso8601String()}_onPermissionSet $p');
    if (!p) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('no Permission')),
      );
    }
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}