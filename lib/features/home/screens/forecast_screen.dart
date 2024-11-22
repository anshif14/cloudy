import 'dart:ui';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloudy/Models/weather_forecast_model.dart' as forecast;
import 'package:cloudy/common/images/fetchIcon.dart';
import 'package:cloudy/features/home/controller/home_controller.dart';
import 'package:cloudy/main.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:glassmorphism/glassmorphism.dart';
import 'package:intl/intl.dart';

import '../../../Models/weather_forecast_model.dart';
import '../../../common/loader/forecast_loader.dart';


class ForecastScreen extends ConsumerStatefulWidget {
  final double lat;
  final double long;
  const ForecastScreen({required this.lat,required this.long, super.key});

  @override
  ConsumerState<ForecastScreen> createState() => _ForecastScreenState();
}

class _ForecastScreenState extends ConsumerState<ForecastScreen> {
 List<forecast.Current> hourlyForecast =[];
 int selectedDay = 0;

  List <Forecastday> dailyForcastList  =[];
  forecast.WeatherForecastModel ? weatherForecastModel;
  getData()async{
    weatherForecastModel = await
    ref.watch(homeController).getWeatherForecastModel('${widget.lat},${widget.long}');
dailyForcastList = weatherForecastModel!.forecast.forecastday;
    hourlyForecast = weatherForecastModel!.forecast.forecastday[selectedDay].hour;

    for(var docs in hourlyForecast){

    }
    // print(weatherForecastModel!.forecast.forecastday);
    setState(() {
      
    });
  }
@override
  void didChangeDependencies() {
    getData();
  // TODO: implement didChangeDependencies
    super.didChangeDependencies();
  }
  @override
  Widget build(BuildContext context) {
    return  Scaffold(

      body:dailyForcastList.isEmpty?

      WeatherShimmerScreen():
      Container(
        height: height,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF74ABE2), Color(0xFF5588EE)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          )
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Top Navigation
                  Row(
                    // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: const Row(
                          children: [
              
                            Icon(CupertinoIcons.back, color: Colors.white),
                            SizedBox(width: 10,),
                            Text(
                              "Back",
                              style: TextStyle(fontSize: 22, color: Colors.white, ),
                            ),
                          ],
                        ),
                      ),
                      // Icon(Icons.settings, color: Colors.white),
                    ],
                  ),
                  const SizedBox(height: 16),
                  // Today's Forecast
                  const Text(
                    "Today",
                    style: TextStyle(fontSize: 24, color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    "${DateFormat('dd MMMM').format(DateTime.now())}",
                    style: const TextStyle(fontSize: 18, color: Colors.white70),
                  ),
                  const SizedBox(height: 16),
                  // Glassy Container for today's forecast
                  SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: List.generate(hourlyForecast.length, (index) {
                        String time = "${(00 + index).toString().padLeft(0)}:00";
                        List<String> parts = time.split(":");

                        String formattedTime = parts[0].padLeft(2, '0') + ":" + parts[1];
                        return Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Column(
                            children: [
                              Text(formattedTime,
                                  style: const TextStyle(color: Colors.white70)),
                           CachedNetworkImage( imageUrl: fetchWeatherIcon(hourlyForecast[index].condition.text),height: height*0.05,),
                              Text(
                                "${hourlyForecast[index].tempC}°C",
                                style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        );
                      }),
                    ),
                  ),
                  const SizedBox(height: 24),
                  // Next Forecast
                  const Text(
                    "Next Forecast",
                    style: TextStyle(fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  // Forecast List
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: dailyForcastList.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: GestureDetector(
                          onTap: () {
                            selectedDay = index;
                            hourlyForecast = weatherForecastModel!.forecast.forecastday[selectedDay].hour;
                            setState(() {

                            });
                          },
                          child: GlassmorphicContainer(
                            width: width*0.9,
                            height: height*0.1,
                            borderRadius: 16,
                            blur:selectedDay==index?200: 10,
                            alignment: Alignment.center,
                            border: 2,
                            linearGradient: LinearGradient(
                              colors:

                              selectedDay==index?

                              [
                                Colors.white.withOpacity(0.4),
                                Colors.white.withOpacity(0.3),
                              ]:
                              [
                                Colors.white.withOpacity(0.2),
                                Colors.white.withOpacity(0.1),
                              ],
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                            ),
                            borderGradient: LinearGradient(
                              colors:
                              selectedDay==index?

                              [
                              Colors.white.withOpacity(1),
                                Colors.white.withOpacity(0.8),
                                ]:
                              [
                                Colors.white.withOpacity(0.2),
                                Colors.white.withOpacity(0.1),
                              ],
                            ),
                            child: ListTile(
                              leading: Text(
                                "${DateFormat('MMM dd').format(dailyForcastList[index].date)}, ",
                                style: const TextStyle(color: Colors.white),
                              ),
                              title: Text(
                               dailyForcastList[index].hour[0].condition.text ,
                                style: const TextStyle(color: Colors.white70),
                              ),
                              trailing: Wrap(
                                crossAxisAlignment: WrapCrossAlignment.center,
                                children: [
                                 CachedNetworkImage(imageUrl: fetchWeatherIcon(hourlyForecast[index].condition.text),height: height*0.07,),

                                  Text(
                                    "${ dailyForcastList[index].hour[0].tempC }°C",
                                    style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
              
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class GlassContainer extends StatelessWidget {
  final Widget child;

  const GlassContainer({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white.withOpacity(0.3)),
        gradient: LinearGradient(
          colors: [
            Colors.white.withOpacity(0.1),
            Colors.white.withOpacity(0.2),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: Container(
            padding: const EdgeInsets.all(16),
            child: child,
          ),
        ),
      ),
    );
  }
}
