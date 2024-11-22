import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiServices {
  final String _baseUrl = "https://api.weatherapi.com/v1";
  final String _apiKey = "59ff56b1a2834f19a8291934242211";

  /// current weather
  Future<Map<String, dynamic>> getCurrentWeather(String location) async {
    final String endpoint = "$_baseUrl/current.json";
    final String url = "$endpoint?key=$_apiKey&q=$location&aqi=no";

    try {
      final response = await http.get(Uri.parse(url));


      if (response.statusCode == 200) {
        return jsonDecode(response.body) as Map<String, dynamic>;
      } else {
        throw Exception("Failed to load weather data: ${response.reasonPhrase}");
      }
    } catch (error) {
      throw Exception("Error fetching weather data: $error");
    }
  }

  ///  hourly forecast
  Future<Map<String, dynamic>> getHourlyForecast(String location, String date) async {
    final String endpoint = "$_baseUrl/future.json";
    final String url = "$endpoint?key=$_apiKey&q=$location&dt=$date";

    try {
      final response = await http.get(Uri.parse(url));


      if (response.statusCode == 200) {
        return jsonDecode(response.body) as Map<String, dynamic>;
      } else {
        throw Exception("Failed to load hourly forecast: ${response.reasonPhrase}");
      }
    } catch (error) {
      throw Exception("Error fetching hourly forecast: $error");
    }
  }

  /// daily forecast
  Future<Map<String, dynamic>> getDailyForecast(String location, int days) async {
    final String endpoint = "$_baseUrl/forecast.json";
    final String url = "$endpoint?key=$_apiKey&q=$location&days=$days&aqi=no&alerts=no";

    try {
      final response = await http.get(Uri.parse(url));


      if (response.statusCode == 200) {
        print(response.body);
        return jsonDecode(response.body) as Map<String, dynamic>;
      } else {
        throw Exception("Failed to load daily forecast: ${response.reasonPhrase}");
      }
    } catch (error) {
      throw Exception("Error fetching daily forecast: $error");
    }
  }
}
