import 'package:cloudy/services/API_services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'api_services_test.mocks.dart';


@GenerateMocks([http.Client])
void main() {
  late ApiServices apiServices;
  late MockClient mockClient;

  setUp(() {
    mockClient = MockClient();
    apiServices = ApiServices(); // Assuming your service doesn't require passing the client
  });

  group('API Service Tests', () {
    test('getCurrentWeather returns weather data on success', () async {
      // Arrange: Mock the HTTP client to return a fake response
      final mockResponse = '''
      {
        "location": {"name": "New York"},
        "current": {"temp_c": 25.0, "condition": {"text": "Sunny"}}
      }
      ''';

      when(mockClient.get(any)).thenAnswer(
            (_) async => http.Response(mockResponse, 200),
      );

      // Act: Call the API service
      final weatherData = jsonDecode(mockResponse);

      print(weatherData);
      print("weatherData");

      // Assert: Verify the response
      expect(weatherData['location']['name'], 'New York');
      expect(weatherData['current']['temp_c'], 25.0);
      expect(weatherData['current']['condition']['text'], 'Sunny');
    });


    test('getCurrentWeather throws exception on error response', () async {
      // Arrange: Mock the HTTP client to return a 404 error
      when(mockClient.get(any)).thenAnswer(
            (_) async => http.Response('Not Found', 404),
      );

      // Act & Assert: Verify the function throws an exception
      expect(
            () async => await apiServices.getCurrentWeather('UnknownCity'),
        throwsException,
      );
    });
  });
  // Your test code will go here
}