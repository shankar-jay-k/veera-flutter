import 'package:flutter/material.dart';
import 'package:veera_education_flutter/Controllers/Colors.dart';


class LinkDevice extends StatefulWidget {
  const LinkDevice({super.key});

  @override
  State<LinkDevice> createState() => _LinkDeviceState();
}

class _LinkDeviceState extends State<LinkDevice> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text('Connected device',style: TextStyle(color: Colors.black,fontFamily: 'Poppins-Medium',),),
        leading: IconButton(
          onPressed: (){
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back_ios_outlined,color: Colors.black),
        ),
      ),
      body: Container(
        width: screenUtils.getScreenWidth(context),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Column(
              children: [

                Image.asset(
                  'assets/images/last_active_session.jpg',
                  width: MediaQuery.of(context).size.width > 500
                      ? MediaQuery.of(context).size.width * 0.7
                      : MediaQuery.of(context).size.width * 0.7,
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 25),
                    child: Text("Connect Veera's Hindi with your computer",style: TextStyle(fontFamily: 'Poppins-SemiBold',fontSize: 18),textAlign: TextAlign.center,)),
                SizedBox(height: 15,)
              ],
            ),
            MaterialButton(
              height: 50,
              minWidth: screenUtils.getScreenWidth(context) > 500 ? screenUtils.getScreenWidth(context) * 0.6 : screenUtils.getScreenWidth(context) * 0.8,
              color: appColors.lightGold,
              onPressed: (){},
              child: Text('Link Device',style: TextStyle(fontFamily: 'Poppins-Bold',fontSize: 18,color: Colors.black87,letterSpacing: 2),),
            ),
            Divider(indent: 50,endIndent: 50,height: 50,),
            Container(
              padding: EdgeInsets.all(10),
              width: screenUtils.getScreenWidth(context) > 500 ? screenUtils.getScreenWidth(context) * 0.75 : screenUtils.getScreenWidth(context) * 0.95,
              decoration: BoxDecoration(
                color: Color(0xffe8e8e8),
                borderRadius: BorderRadius.circular(10)
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('DEVICE STATUS',style: TextStyle(fontFamily: 'Poppins-Light',color: Colors.black),),
                  Text('Tap to logout from the web device',style: TextStyle(color: Colors.black87,fontFamily: 'Poppins-Medium'),),
                  SizedBox(height: 10,),
                  ListTile(
                    leading: Image.network('https://i.pinimg.com/originals/fb/fd/14/fbfd14bfb8b0b757cf6928bb0fd3d7d3.png',height: 35,width: 35,fit: BoxFit.fill),
                    title: Text('Chrome browser (Windows)',style: TextStyle(fontFamily: 'Poppins-SemiBold'),),
                    subtitle: Text('Last active today at 04:40 pm',style: TextStyle(fontFamily: 'Poppins-SemiBold'),),
                  ),
                  Divider(indent: 20,endIndent: 40,height: 5,),
                  ListTile(
                    leading: Image.network('https://cdn3.iconfinder.com/data/icons/3d-applications/512/app_icons_web_development___safari_logo_browser_application_app_apple.png',height: 40,width: 40,fit: BoxFit.fill,),
                    title: Text('Finder (Windows)',style: TextStyle(fontFamily: 'Poppins-SemiBold'),),
                    subtitle: Text('Last active today at 04:40 pm',style: TextStyle(fontFamily: 'Poppins-SemiBold'),),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
