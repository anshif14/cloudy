import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloudy/Models/current_weather_model.dart';
import 'package:cloudy/common/images/fetchIcon.dart';
import 'package:cloudy/common/images/imagesConstants.dart';
import 'package:cloudy/core/providers/providers.dart';
import 'package:cloudy/features/home/controller/home_controller.dart';
import 'package:cloudy/features/home/screens/forecast_screen.dart';
import 'package:cloudy/features/home/screens/search_screen.dart';
import 'package:cloudy/main.dart';
import 'package:cloudy/services/API_services.dart';
import 'package:cloudy/services/location_services.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart';
import 'package:glassmorphism/glassmorphism.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:page_transition/page_transition.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../common/loader/home_loading.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {

  ///internert check

  List<ConnectivityResult> _connectionStatus = [ConnectivityResult.none];
  final Connectivity _connectivity = Connectivity();
  late StreamSubscription<List<ConnectivityResult>> _connectivitySubscription;


  bool locationDenied = false;
  Map<String, double?> location = {};
  getCurrentLocation() async {
    LocationService locationService = LocationService();
    LocationPermission permission = await Geolocator.checkPermission();
    if(permission == LocationPermission.denied){
      locationDenied = true;
      setState(() {

      });
      // return;
    }

    location = await locationService.getCurrentLocation(context,ref);

    ref.read(locationProvider.notifier).state = location;

    if (location.isNotEmpty) {
      getCurrentData(
          "${ref.read(locationProvider)["latitude"]},${ref.read(locationProvider)["longitude"]}");
    }
  }

  CurrentWeatherModel? currentWeatherModel;

  getCurrentData(String location) async {
    currentWeatherModel =
        await ref.watch(homeController).getCurrentWeather(location);
    setState(() {});
  ;
  }
  Future<void> initConnectivity() async {
    late List<ConnectivityResult> result;

    try {
      result = await _connectivity.checkConnectivity();

    } on PlatformException catch (e) {

      return;
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) {
      return Future.value(null);
    }

    return _updateConnectionStatus(result);
  }

  Future<void> _updateConnectionStatus(List<ConnectivityResult> result) async {
    setState(() {
      _connectionStatus = result;
    });
    // ignore: avoid_print
    print('Connectivity changed: $_connectionStatus');
  }

  @override
  void initState() {
  initConnectivity();

  _connectivitySubscription =
      _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);

    // TODO: implement initState
    super.initState();
  }
  @override
  void didChangeDependencies() {
    getCurrentLocation();

    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    var location = ref.watch(locationProvider);
    return



      Scaffold(
      body:

      _connectionStatus.contains(ConnectivityResult.none)?
      Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF74ABE2), Color(0xFF5588EE)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child:                     Column(
          mainAxisAlignment: MainAxisAlignment.center,


          children: [

            Image.asset( ImageConstants.no_internet),

            GestureDetector(
              onTap: ()async {



                getCurrentLocation();
              },
              child: Padding(
                padding: const EdgeInsets.only(bottom: 20.0),
                child: GlassmorphicContainer(
                  width: 180,
                  height: 50,
                  borderRadius: 12,
                  blur: 10,
                  alignment: Alignment.center,
                  border: 2,
                  linearGradient: LinearGradient(
                    colors: [
                      Colors.white.withOpacity(0.2),
                      Colors.white.withOpacity(0.1),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderGradient: LinearGradient(
                    colors: [
                      Colors.white.withOpacity(0.5),
                      Colors.white.withOpacity(0.1),
                    ],
                  ),
                  child: const Center(
                    child: Text(
                      'Check Internet',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),

      ):

      currentWeatherModel == null
          ? homeShimmerEffect()
          :
      ref.watch(locationDeniedProvider)?

          Container(
            width: double.infinity,
            height: double.infinity,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFF74ABE2), Color(0xFF5588EE)],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
            child:                     Column(
mainAxisAlignment: MainAxisAlignment.center,


              children: [

                CachedNetworkImage(imageUrl: ImageConstants.locationRejected),

                GestureDetector(
                  onTap: ()async {

                   getCurrentLocation();

                    await openAppSettings();

                  },
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 20.0),
                    child: GlassmorphicContainer(
                      width: 180,
                      height: 50,
                      borderRadius: 12,
                      blur: 10,
                      alignment: Alignment.center,
                      border: 2,
                      linearGradient: LinearGradient(
                        colors: [
                          Colors.white.withOpacity(0.2),
                          Colors.white.withOpacity(0.1),
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderGradient: LinearGradient(
                        colors: [
                          Colors.white.withOpacity(0.5),
                          Colors.white.withOpacity(0.1),
                        ],
                      ),
                      child: const Center(
                        child: Text(
                          'Request Permission',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),

          ):


      Container(
              width: double.infinity,
              height: double.infinity,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xFF74ABE2), Color(0xFF5588EE)],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
              child: SafeArea(
                child: Column(
                  children: [
                    GestureDetector(
                      onTap: () async {
                        // getCurrentData('Kochi');
                        var data = await Navigator.push(
                            context,
                            PageTransition(
                                type: PageTransitionType.topToBottom,
                                child: SearchScreen(
                                  lat: double.tryParse(
                                          location['latitude'].toString()) ??
                                      0,
                                  lng: double.tryParse(
                                          location['longitude'].toString()) ??
                                      0,
                                )));

                        currentWeatherModel = null;
                        setState(() {});
                        ref.read(locationProvider.notifier).state = data;
                        currentWeatherModel = await ref
                            .watch(homeController)
                            .getCurrentWeather(data['latitude'].toString() +
                                ',' +
                                data['longitude'].toString());

                        setState(() {});
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20.0, vertical: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                const Icon(Icons.location_on, color: Colors.white),
                                const SizedBox(width: 5),
                                Text(
                                  currentWeatherModel!.location.name,
                                  style: const TextStyle(
                                    fontSize: 18,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const Icon(Icons.arrow_drop_down,
                                    color: Colors.white),
                              ],
                            ),
                            const SizedBox(),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    // Cloud Icon and Temperature
                    Column(
                      children: [
                        // const Icon(Icons.cloud, color: Colors.white, size: 80),

                        SizedBox(
                          height: height * 0.3,
                          child: CachedNetworkImage(
                            imageUrl: fetchWeatherIcon(
                                currentWeatherModel!.current.condition.text),
                          ),
                        ),

                        const SizedBox(height: 10),
                        const SizedBox(height: 10),
                        GlassmorphicContainer(
                          width: width * 0.7,
                          height: height * 0.35,
                          borderRadius: 20,
                          blur: 10,
                          alignment: Alignment.center,
                          border: 2,
                          linearGradient: LinearGradient(
                            colors: [
                              Colors.white.withOpacity(0.2),
                              Colors.white.withOpacity(0.1),
                            ],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                          borderGradient: LinearGradient(
                            colors: [
                              Colors.white.withOpacity(0.5),
                              Colors.white.withOpacity(0.1),
                            ],
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const SizedBox(height: 10),
                              Text(
                                'Today, ${DateFormat('dd MMMM').format(DateTime.now())}',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.white.withOpacity(0.8),
                                ),
                              ),
                              const SizedBox(height: 10),
                              Text(
                                '${currentWeatherModel!.current.tempC}°',
                                style: GoogleFonts.overpass(
                                  fontSize: 64,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                              const SizedBox(height: 10),
                              Text(
                                '${currentWeatherModel!.current.condition.text}',
                                style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.white.withOpacity(0.8),
                                ),
                              ),
                              const SizedBox(height: 20),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Column(
                                    children: [
                                      const Icon(Icons.air,
                                          color: Colors.white, size: 24),
                                      const SizedBox(height: 5),
                                      Text(
                                        '${currentWeatherModel!.current.windKph} km/h',
                                        style: TextStyle(
                                          color: Colors.white.withOpacity(0.8),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Column(
                                    children: [
                                      const Icon(Icons.water_drop,
                                          color: Colors.white, size: 24),
                                      const SizedBox(height: 5),
                                      Text(
                                        '${currentWeatherModel!.current.humidity} %',
                                        style: TextStyle(
                                          color: Colors.white.withOpacity(0.8),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const Spacer(),
                    // Forecast Button
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        GestureDetector(
                          onTap: () {
                 getCurrentLocation();
                          },
                          child: Padding(
                            padding: const EdgeInsets.only(bottom: 20.0),
                            child: GlassmorphicContainer(
                              width: 180,
                              height: 50,
                              borderRadius: 25,
                              blur: 10,
                              alignment: Alignment.center,
                              border: 2,
                              linearGradient: LinearGradient(
                                colors: [
                                  Colors.white.withOpacity(0.2),
                                  Colors.white.withOpacity(0.1),
                                ],
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                              ),
                              borderGradient: LinearGradient(
                                colors: [
                                  Colors.white.withOpacity(0.5),
                                  Colors.white.withOpacity(0.1),
                                ],
                              ),
                              child: const Center(
                                child: Text(
                                  'Refresh',
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),

                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                PageTransition(
                                    type: PageTransitionType.bottomToTop,
                                    child: ForecastScreen(
                                      lat: double.tryParse(
                                              location['latitude'].toString()) ??
                                          0,
                                      long: double.tryParse(
                                              location['longitude'].toString()) ??
                                          0,
                                    )));
                          },
                          child: Padding(
                            padding: const EdgeInsets.only(bottom: 20.0),
                            child: GlassmorphicContainer(
                              width: 180,
                              height: 50,
                              borderRadius: 25,
                              blur: 10,
                              alignment: Alignment.center,
                              border: 2,
                              linearGradient: LinearGradient(
                                colors: [
                                  Colors.white.withOpacity(0.2),
                                  Colors.white.withOpacity(0.1),
                                ],
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                              ),
                              borderGradient: LinearGradient(
                                colors: [
                                  Colors.white.withOpacity(0.5),
                                  Colors.white.withOpacity(0.1),
                                ],
                              ),
                              child: const Center(
                                child: Text(
                                  'Forecast Report',
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
