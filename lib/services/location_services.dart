import 'package:cloudy/core/providers/providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart';

class LocationService {
  Future<Map<String, double?>> getCurrentLocation(BuildContext context,WidgetRef ref) async {
    // Check if location services are enabled
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      ref.read(locationDeniedProvider.notifier).state = true;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Location services are disabled. Please enable them to proceed.'),
        ),
      );

      return  {'latitude': null, 'longitude': null};
    }

    // Check for location permissions
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        ref.read(locationDeniedProvider.notifier).state = true;
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Location permission denied. Please grant it to proceed.'),
          ),
        );
        return {'latitude': null, 'longitude': null};
      }
    }

    if (permission == LocationPermission.deniedForever) {
      ref.read(locationDeniedProvider.notifier).state = true;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Location permissions are permanently denied. Please enable them in settings.'),
        ),
      );
      return {'latitude': null, 'longitude': null};
    }

    // Get current location
    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );
    ref.read(locationDeniedProvider.notifier).state = false;

    return {
      'latitude': position.latitude,
      'longitude': position.longitude,
    };
  }
}
