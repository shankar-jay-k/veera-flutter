import 'package:flutter/material.dart';
import 'package:veera_education_flutter/Controllers/Colors.dart';

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
  @override
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
              Text('CHOOSE YOUR PLAN',style: TextStyle(fontSize: 18,fontFamily: 'poppins-bold',),),
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
                  Column(
                    children: [
                      Text('Popular',style: TextStyle(fontFamily: 'poppins-medium',fontSize: 15),),
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
                          width: MediaQuery.of(context).size.width * 0.43,
                          height:200,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: Colors.white,
                            border: Border.all(color: chosenPlan == '1' ?  appColors.lightGold : appColors.Shadow_Clr2 ,width: 2),
                           boxShadow: [
                              BoxShadow(
                                color: appColors.Shadow_Clr2,
                                offset: const Offset(
                                  1.0,
                                  3.0,
                                ),
                                blurRadius:10.0,
                              ),],
                            gradient: LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              colors: chosenPlan == '1' ?  [appColors.lightGold,appColors.lightGold,] : [Colors.white,Colors.white,] ,
                            ),
                          ),
                          child: Column(
                            children: [
                              SizedBox(height: 10,),
                              Padding(
                                padding: const EdgeInsets.all(0.0),
                                child: Text('1 Month plan',style: TextStyle(fontFamily: 'poppins-semibold'),),
                              ),
                              Divider(color:chosenPlan == '1' ? Colors.white : Colors.grey[300],thickness: 1),
                              SizedBox(height: 10,),
                              Text('₹ 830',style: TextStyle(fontSize:24,fontWeight: FontWeight.w700),),
                              SizedBox(height: 10,),
                              Text('INR / month',style: TextStyle(fontFamily: 'poppins-semibold'),),
                              SizedBox(height: 15,),

                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Container(
                          decoration: BoxDecoration(
                            color: Color(0xffd4ffd9),
                            border: Border.all(color: Color(0xff219b2d)),
                            borderRadius: BorderRadius.circular(5)
                          ),
                          child: Text('  Most popular  ',style: TextStyle(fontFamily: 'poppins-medium',color: Colors.black,fontSize: 15,),)),
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
                          margin: EdgeInsets.only(top: 10),
                          width: MediaQuery.of(context).size.width * 0.43,
                          height:200,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),

                            border: Border.all(color: chosenPlan == '5' ?  appColors.lightGold : appColors.Shadow_Clr2 ,width: 2),

                            boxShadow: [
                              BoxShadow(
                                color: appColors.Shadow_Clr2,
                                offset: const Offset(
                                  1.0,
                                  3.0,
                                ),
                                blurRadius:10.0,
                              ),],
                            gradient: LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              colors: chosenPlan == '5' ? [appColors.lightGold,appColors.lightGold] : [Colors.white,Colors.white],
                            ),
                          ),
                          child: Column(
                            children: [
                              SizedBox(height: 10,),
                              Padding(
                                padding: const EdgeInsets.all(0.0),
                                child: Text('5 Months plan',style: TextStyle(fontFamily: 'poppins-semibold'),),
                              ),
                              Divider(color:chosenPlan == '1' ? Colors.white : Colors.grey[300],thickness: 1),
                              SizedBox(height: 10,),
                              Text('₹ 830',style: TextStyle(fontSize:24,fontWeight: FontWeight.w700),),
                              SizedBox(height: 10,),
                              Text('INR / month',style: TextStyle(fontFamily: 'poppins-semibold'),),
                              Text('+',style: TextStyle(fontSize:24,fontFamily: 'poppins-medium'),),
                              Text('1 month extra',style: TextStyle(fontFamily: 'poppins-bold'),),
                              SizedBox(height: 15,),

                            ],
                          ),
                        ),
                      ),
                    ],
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
                      onPressed: (){},
                      child: Text('PAY NOW',style: TextStyle(fontSize: 17,fontFamily: 'poppins-semibold',letterSpacing: 2,color: Colors.black),)                      ,)
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
