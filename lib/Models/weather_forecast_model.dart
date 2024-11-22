class WeatherForecastModel {
  final Location location;
  final Current current;
  final Forecast forecast;

  WeatherForecastModel({
    required this.location,
    required this.current,
    required this.forecast,
  });

  factory WeatherForecastModel.fromJson(Map<String, dynamic> json) {
    return WeatherForecastModel(
      location: Location.fromJson(json['location']),
      current: Current.fromJson(json['current']),
      forecast: Forecast.fromJson(json['forecast']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'location': location.toJson(),
      'current': current.toJson(),
      'forecast': forecast.toJson(),
    };
  }
}

class Location {
  final String name;
  final String region;
  final String country;
  final double lat;
  final double lon;
  final String tzId;
  final int localtimeEpoch;
  final String localtime;

  Location({
    required this.name,
    required this.region,
    required this.country,
    required this.lat,
    required this.lon,
    required this.tzId,
    required this.localtimeEpoch,
    required this.localtime,
  });

  factory Location.fromJson(Map<String, dynamic> json) {
    return Location(
      name: json['name'],
      region: json['region'],
      country: json['country'],
      lat: json['lat'].toDouble(),
      lon: json['lon'].toDouble(),
      tzId: json['tz_id'],
      localtimeEpoch: json['localtime_epoch'],
      localtime: json['localtime'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'region': region,
      'country': country,
      'lat': lat,
      'lon': lon,
      'tz_id': tzId,
      'localtime_epoch': localtimeEpoch,
      'localtime': localtime,
    };
  }
}

class Current {
  final double tempC;
  final double tempF;
  final int isDay;
  final Condition condition;
  final double windMph;
  final double windKph;
  final int windDegree;
  final String windDir;
  final double pressureMb;
  final double pressureIn;
  final double precipMm;
  final double precipIn;
  final int humidity;
  final int cloud;
  final double feelslikeC;
  final double feelslikeF;
  final double visKm;
  final double visMiles;

  Current({
    required this.tempC,
    required this.tempF,
    required this.isDay,
    required this.condition,
    required this.windMph,
    required this.windKph,
    required this.windDegree,
    required this.windDir,
    required this.pressureMb,
    required this.pressureIn,
    required this.precipMm,
    required this.precipIn,
    required this.humidity,
    required this.cloud,
    required this.feelslikeC,
    required this.feelslikeF,
    required this.visKm,
    required this.visMiles,
  });

  factory Current.fromJson(Map<String, dynamic> json) {
    return Current(
      tempC: json['temp_c'].toDouble(),
      tempF: json['temp_f'].toDouble(),
      isDay: json['is_day'],
      condition: Condition.fromJson(json['condition']),
      windMph: json['wind_mph'].toDouble(),
      windKph: json['wind_kph'].toDouble(),
      windDegree: json['wind_degree'],
      windDir: json['wind_dir'],
      pressureMb: json['pressure_mb'].toDouble(),
      pressureIn: json['pressure_in'].toDouble(),
      precipMm: json['precip_mm'].toDouble(),
      precipIn: json['precip_in'].toDouble(),
      humidity: json['humidity'],
      cloud: json['cloud'],
      feelslikeC: json['feelslike_c'].toDouble(),
      feelslikeF: json['feelslike_f'].toDouble(),
      visKm: json['vis_km'].toDouble(),
      visMiles: json['vis_miles'].toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'temp_c': tempC,
      'temp_f': tempF,
      'is_day': isDay,
      'condition': condition.toJson(),
      'wind_mph': windMph,
      'wind_kph': windKph,
      'wind_degree': windDegree,
      'wind_dir': windDir,
      'pressure_mb': pressureMb,
      'pressure_in': pressureIn,
      'precip_mm': precipMm,
      'precip_in': precipIn,
      'humidity': humidity,
      'cloud': cloud,
      'feelslike_c': feelslikeC,
      'feelslike_f': feelslikeF,
      'vis_km': visKm,
      'vis_miles': visMiles,
    };
  }
}

class Condition {
  final String text;
  final String icon;
  final int code;

  Condition({
    required this.text,
    required this.icon,
    required this.code,
  });

  factory Condition.fromJson(Map<String, dynamic> json) {
    return Condition(
      text: json['text'],
      icon: json['icon'],
      code: json['code'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'text': text,
      'icon': icon,
      'code': code,
    };
  }
}

// Add `Forecast` and `Day` classes similarly based on your JSON structure.

class Forecast {
  final List<Forecastday> forecastday;

  Forecast({
    required this.forecastday,
  });

  Forecast copyWith({
    List<Forecastday>? forecastday,
  }) =>
      Forecast(
        forecastday: forecastday ?? this.forecastday,
      );

  factory Forecast.fromJson(Map<String, dynamic> json) => Forecast(
    forecastday: List<Forecastday>.from(json["forecastday"].map((x) => Forecastday.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "forecastday": List<dynamic>.from(forecastday.map((x) => x.toJson())),
  };
}

class Forecastday {
  final DateTime date;
  final int dateEpoch;
  final Day day;
  final Astro astro;
  final List<Current> hour;

  Forecastday({
    required this.date,
    required this.dateEpoch,
    required this.day,
    required this.astro,
    required this.hour,
  });

  Forecastday copyWith({
    DateTime? date,
    int? dateEpoch,
    Day? day,
    Astro? astro,
    List<Current>? hour,
  }) =>
      Forecastday(
        date: date ?? this.date,
        dateEpoch: dateEpoch ?? this.dateEpoch,
        day: day ?? this.day,
        astro: astro ?? this.astro,
        hour: hour ?? this.hour,
      );

  factory Forecastday.fromJson(Map<String, dynamic> json) => Forecastday(
    date: DateTime.parse(json["date"]),
    dateEpoch: json["date_epoch"],
    day: Day.fromJson(json["day"]),
    astro: Astro.fromJson(json["astro"]),
    hour: List<Current>.from(json["hour"].map((x) => Current.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "date": "${date.year.toString().padLeft(4, '0')}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}",
    "date_epoch": dateEpoch,
    "day": day.toJson(),
    "astro": astro.toJson(),
    "hour": List<dynamic>.from(hour.map((x) => x.toJson())),
  };
}



//
// class Location {
//   final String name;
//   final String region;
//   final String country;
//   final double lat;
//   final double lon;
//   final String timezone;
//   final int localtimeEpoch;
//   final String localtime;
//
//   Location({
//     required this.name,
//     required this.region,
//     required this.country,
//     required this.lat,
//     required this.lon,
//     required this.timezone,
//     required this.localtimeEpoch,
//     required this.localtime,
//   });
//
//   factory Location.fromJson(Map<String, dynamic> json) => Location(
//     name: json["name"],
//     region: json["region"],
//     country: json["country"],
//     lat: json["lat"].toDouble(),
//     lon: json["lon"].toDouble(),
//     timezone: json["tz_id"],
//     localtimeEpoch: json["localtime_epoch"],
//     localtime: json["localtime"],
//   );
//
//   Map<String, dynamic> toJson() => {
//     "name": name,
//     "region": region,
//     "country": country,
//     "lat": lat,
//     "lon": lon,
//     "tz_id": timezone,
//     "localtime_epoch": localtimeEpoch,
//     "localtime": localtime,
//   };
// }

class Day {
  final double maxTempC;
  final double maxTempF;
  final double minTempC;
  final double minTempF;
  final double avgTempC;
  final double avgTempF;
  final double maxWindMph;
  final double maxWindKph;
  final double totalPrecipMm;
  final double totalPrecipIn;

  Day({
    required this.maxTempC,
    required this.maxTempF,
    required this.minTempC,
    required this.minTempF,
    required this.avgTempC,
    required this.avgTempF,
    required this.maxWindMph,
    required this.maxWindKph,
    required this.totalPrecipMm,
    required this.totalPrecipIn,
  });

  factory Day.fromJson(Map<String, dynamic> json) => Day(
    maxTempC: json["maxtemp_c"].toDouble(),
    maxTempF: json["maxtemp_f"].toDouble(),
    minTempC: json["mintemp_c"].toDouble(),
    minTempF: json["mintemp_f"].toDouble(),
    avgTempC: json["avgtemp_c"].toDouble(),
    avgTempF: json["avgtemp_f"].toDouble(),
    maxWindMph: json["maxwind_mph"].toDouble(),
    maxWindKph: json["maxwind_kph"].toDouble(),
    totalPrecipMm: json["totalprecip_mm"]??0,
    totalPrecipIn: json["totalprecip_in"]??0,
  );

  Map<String, dynamic> toJson() => {
    "maxtemp_c": maxTempC,
    "maxtemp_f": maxTempF,
    "mintemp_c": minTempC,
    "mintemp_f": minTempF,
    "avgtemp_c": avgTempC,
    "avgtemp_f": avgTempF,
    "maxwind_mph": maxWindMph,
    "maxwind_kph": maxWindKph,
    "totalprecip_mm": totalPrecipMm,
    "totalprecip_in": totalPrecipIn,
  };
}

class Astro {
  final String sunrise;
  final String sunset;
  final String moonrise;
  final String moonset;

  Astro({
    required this.sunrise,
    required this.sunset,
    required this.moonrise,
    required this.moonset,
  });

  factory Astro.fromJson(Map<String, dynamic> json) => Astro(
    sunrise: json["sunrise"],
    sunset: json["sunset"],
    moonrise: json["moonrise"],
    moonset: json["moonset"],
  );

  Map<String, dynamic> toJson() => {
    "sunrise": sunrise,
    "sunset": sunset,
    "moonrise": moonrise,
    "moonset": moonset,
  };
}

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
