import 'package:cloudy/Models/current_weather_model.dart';
import 'package:cloudy/Models/weather_forecast_model.dart';
import 'package:cloudy/services/API_services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

Provider<HomeRepository> homeRepositoryProvider = Provider<HomeRepository>((ref) => HomeRepository(),);

class HomeRepository{

Future<CurrentWeatherModel> getCurrentWeather(String location) async {

  var data = await ApiServices().getCurrentWeather(location);
  CurrentWeatherModel currentWeatherModel =await CurrentWeatherModel.fromJson(data);
return currentWeatherModel;
}
Future<WeatherForecastModel> getFutureForecast(String location) async {

  var data = await ApiServices().getDailyForecast(location,5);
  WeatherForecastModel weatherForecastModel =await WeatherForecastModel.fromJson(data);
return weatherForecastModel;
}

}