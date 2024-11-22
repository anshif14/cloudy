import 'package:cloudy/features/home/repository/home_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

Provider<HomeController> homeController = Provider<HomeController>((ref) => HomeController(homeRepository: ref.watch(homeRepositoryProvider)),);

class HomeController{
  HomeRepository _homeRepository;
  HomeController({required HomeRepository homeRepository}):
_homeRepository=homeRepository;

  getCurrentWeather(String location){
   return _homeRepository.getCurrentWeather(location);
  }
  getWeatherForecastModel(String location){
   return _homeRepository.getFutureForecast(location);
  }



}