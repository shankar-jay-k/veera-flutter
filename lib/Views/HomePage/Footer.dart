import 'package:flutter/material.dart';
import 'package:veera_education_flutter/Controllers/Colors.dart';


class Footer extends StatelessWidget {
  const Footer({super.key});

  @override
  Widget build(BuildContext context) {
    return  Container(
      height: screenUtils.getScreenWidth(context) > 500 ? 250 : 200,
      width: double.infinity,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/footer-bg.png'),
          fit: BoxFit.cover,
        ),

      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "(c) Copyrights by",
                style: TextStyle(color: Colors.white,fontFamily: 'poppins-medium',fontSize: 16),
              ),
              SizedBox(height: 8,),
              Text(
                "NJ VEERA’S MISSION EDUCATION PVT LTD",
                style: TextStyle(color: appColors.lightGold,fontFamily: 'poppins-semibold',fontSize: 17),
              ),
              SizedBox(height: 8,),
              Text(
                "TAMILNADU, INDIA",
                style: TextStyle(color: Colors.white,),
              ),
            ],
          ),
          Padding(
            padding:  EdgeInsets.only(bottom: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Mail Us To: ",
                  style: TextStyle(color: Colors.white,fontFamily: 'poppins-medium',fontSize: 16),
                ),
                GestureDetector(
                  onTap: () {
                    // Handle mail action
                  },
                  child: Text(
                    "Support@veershindi.com",
                    style: TextStyle(
                      color: Colors.white,fontFamily: 'poppins-medium',fontSize: 16.5,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
