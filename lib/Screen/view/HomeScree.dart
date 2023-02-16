import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:provider/provider.dart';
import 'package:weatherapp_12/Screen/Model/HomeModel.dart';
import 'package:weatherapp_12/Screen/Provider/HomeProvider.dart';
import 'package:weatherapp_12/utils/http_app.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  HomeProvider? providert;
  HomeProvider? providerf;

  @override
  Widget build(BuildContext context) {
    providert = Provider.of<HomeProvider>(context, listen: true);
    providerf = Provider.of<HomeProvider>(context, listen: false);
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Padding(
            padding:  EdgeInsets.all(5),
            child: Container(
              height: 6.h,
              width: 160.w,
              child: TextField(
                onSubmitted: (value) {
                  Apihttp().getWeatherData("${providert!.txtScerch.text.isEmpty?"Surat":providert!.txtScerch.text}");
                },
                controller: providert!.txtScerch,
                decoration: InputDecoration(
                  hintText: "Ex.Surat",
                  hintStyle: TextStyle(color: Colors.white),
                  border:
                      OutlineInputBorder(borderRadius: BorderRadius.circular(50)),
                ),
                cursorColor: Colors.white,
              ),
            ),
          ),
          backgroundColor: Color(0xFF373FDB),
          elevation: 0,
        ),
        body: Container(
          height: double.infinity,
          width: double.infinity,
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                Color(0xFF373FDB),
                Color(0xFF3C84AB),
                Color(0xFF85CDFD),
                Color(0xFFDEFCF9),
              ])),
          alignment: Alignment.center,
          child: FutureBuilder<WeatherModel?>(
            future: Apihttp().getWeatherData("${providert!.txtScerch.text.isEmpty?"Surat":providert!.txtScerch.text}"),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Center(
                  child: Text("${snapshot.error}"),
                );
              } else if (snapshot.hasData) {
                WeatherModel? data = snapshot.data;
                return SingleChildScrollView(
                  child: Column(
                    children: [
                      Padding(
                        padding:  EdgeInsets.only(top: 15, left: 35.w),
                        child: Container(
                          height: 6.h,
                          child: Row(
                            children: [
                              SizedBox(
                                width: 3.w,
                              ),
                              Icon(
                                Icons.location_on_outlined,
                                color: Colors.white,
                                size: 26.sp,
                              ),
                              SizedBox(
                                width: 1.w,
                              ),
                              Text(
                                "${data!.name}",
                                style:
                                    TextStyle(color: Colors.white, fontSize: 21.sp),
                              )
                            ],
                          ),
                        ),
                      ),
                      Container(
                        height: 40.h,
                        width: double.infinity,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              height: 1.5.h,
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: 2),
                              child: Center(
                                child: Text(
                                  "${((data.wind!.deg! - 32) * 5 / 9).toStringAsFixed(0)}",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 90.sp,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 1.5.h,
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: 2),
                              child: Center(
                                child: Text(
                                  "${data.weather![0].main}",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 15.sp,
                                      fontWeight: FontWeight.w400),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        height: 20.h,
                        width: 160.w,
                        child: Padding(
                          padding:  EdgeInsets.only(top: 14.h,left: 75.w),
                          child: Text("More details >"),
                        ),
                      ),
                      SizedBox(height: 8,),
                      Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Padding(
                                padding:  EdgeInsets.only(right: 50.w),
                                child: Text("Today-Haze",style: TextStyle(fontSize: 20),),
                              ),
                              Text("37/18",style: TextStyle(fontSize: 20),),
                            ],
                          ),
                          SizedBox(height: 10,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Padding(
                                padding:  EdgeInsets.only(right: 40.w),
                                child: Text("Tomorrow-Clear",style: TextStyle(fontSize: 20),),
                              ),
                              Text("36/18",style: TextStyle(fontSize: 20),),
                            ],
                          ),
                          SizedBox(height: 10,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Padding(
                                padding:  EdgeInsets.only(right: 54.w),
                                child: Text("Sat-Haze",style: TextStyle(fontSize: 20),),
                              ),
                              Text("37/19",style: TextStyle(fontSize: 20),),
                            ],
                          ),
                        ],
                      )
                    ],
                  ),
                );
              }
              return Center(
                child: CircularProgressIndicator(),
              );
            },
          ),
        ),
      ),
    );
  }
}
