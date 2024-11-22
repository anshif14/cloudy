import 'package:flutter_riverpod/flutter_riverpod.dart';

StateProvider locationProvider = StateProvider<Map <String,dynamic>>((ref) => {},);
StateProvider<bool> locationDeniedProvider  =  StateProvider<bool>((ref) => false,);