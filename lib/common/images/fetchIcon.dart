import 'package:cloudy/common/images/imagesConstants.dart';

String fetchWeatherIcon(String weather){
  if(weather == 'Clear'){
    return ImageConstants.clear;
  } if(weather == 'Cloudy'|| weather == 'Partly cloudy'){
    return ImageConstants.cloudy;
  }if(weather == 'Moderate rain' || weather == 'Patchy rain nearby'){
    return ImageConstants.rainy;
  }if(weather == 'Sunny'){
    return ImageConstants.sunny;
  }
  return ImageConstants.clear;
}