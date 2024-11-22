import 'package:cloudy/APIKeys/API%20Keys.dart';
import 'package:cloudy/core/providers/providers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:map_location_picker/map_location_picker.dart';

class SearchScreen extends ConsumerStatefulWidget {
  final double lat;
  final double lng;
  const SearchScreen( {super.key ,required this.lat,required this.lng,});

  @override
  ConsumerState<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends ConsumerState<SearchScreen> {
  GeocodingResult? result;
  @override
  void initState() {
    print(widget.lng);
    print(widget.lat);
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(),
      body: MapLocationPicker
        (
        backButton: IconButton(onPressed: (){
          if(result!=null){
            Navigator.pop(context,{
              'latitude':result!.geometry.location.lat,
              'longitude':result!.geometry.location.lng
            });
          }else{
            Navigator.pop(context,{
              'latitude':widget.lat,
              'longitude':widget.lng
            });
          }

        }, icon: Icon(CupertinoIcons.back)) ,
currentLatLng: LatLng(widget.lat , widget.lng),

        apiKey: APIKeys.GoogleMapApiKey,
        onNext: (GeocodingResult? result) {
          print(result!.geometry.location.lat);{
ref.read(locationProvider.notifier).state = {
  'latitude':result!.geometry.location.lat,
  'longitude':result!.geometry.location.lng
};

// print(ref.read(locationProvider));
// return ref.read(locationProvider);
Navigator.pop(context, {
  'latitude':result!.geometry.location.lat,
  'longitude':result!.geometry.location.lng
});

          }
        },
        hideMapTypeButton: true,
      ),
    );
  }
}
