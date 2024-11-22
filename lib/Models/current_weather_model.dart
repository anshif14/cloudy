import 'dart:convert';

CurrentWeatherModel currentWeatherModelFromJson(String str) => CurrentWeatherModel.fromJson(json.decode(str));

String currentWeatherModelToJson(CurrentWeatherModel data) => json.encode(data.toJson());

class CurrentWeatherModel {
  final Location location;
  final Current current;

  CurrentWeatherModel({
    required this.location,
    required this.current,
  });

  CurrentWeatherModel copyWith({
    Location? location,
    Current? current,
  }) =>
      CurrentWeatherModel(
        location: location ?? this.location,
        current: current ?? this.current,
      );

  factory CurrentWeatherModel.fromJson(Map<String, dynamic> json) => CurrentWeatherModel(
    location: Location.fromJson(json["location"]),
    current: Current.fromJson(json["current"]),
  );

  Map<String, dynamic> toJson() => {
    "location": location.toJson(),
    "current": current.toJson(),
  };
}

class Current {
  final double lastUpdatedEpoch;
  final String lastUpdated;
  final double tempC;
  final double tempF;
  final double isDay;
  final Condition condition;
  final double windMph;
  final double windKph;
  final int windDegree;
  final String windDir;
  final double pressureMb;
  final double pressureIn;
  final double precipMm;
  final double precipIn;
  final double humidity;
  final double cloud;
  final double feelslikeC;
  final double feelslikeF;
  final double windchillC;
  final double windchillF;
  final double heatindexC;
  final double heatindexF;
  final double dewpointC;
  final double dewpointF;
  final double visKm;
  final double visMiles;
  final double uv;
  final double gustMph;
  final double gustKph;

  Current({
    required this.lastUpdatedEpoch,
    required this.lastUpdated,
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
    required this.windchillC,
    required this.windchillF,
    required this.heatindexC,
    required this.heatindexF,
    required this.dewpointC,
    required this.dewpointF,
    required this.visKm,
    required this.visMiles,
    required this.uv,
    required this.gustMph,
    required this.gustKph,
  });

  Current copyWith({
    double? lastUpdatedEpoch,
    String? lastUpdated,
    double? tempC,
    double? tempF,
    double? isDay,
    Condition? condition,
    double? windMph,
    double? windKph,
    int? windDegree,
    String? windDir,
    double? pressureMb,
    double? pressureIn,
    double? precipMm,
    double? precipIn,
    double? humidity,
    double? cloud,
    double? feelslikeC,
    double? feelslikeF,
    double? windchillC,
    double? windchillF,
    double? heatindexC,
    double? heatindexF,
    double? dewpointC,
    double? dewpointF,
    double? visKm,
    double? visMiles,
    double? uv,
    double? gustMph,
    double? gustKph,
  }) =>
      Current(
        lastUpdatedEpoch: lastUpdatedEpoch ?? this.lastUpdatedEpoch,
        lastUpdated: lastUpdated ?? this.lastUpdated,
        tempC: tempC ?? this.tempC,
        tempF: tempF ?? this.tempF,
        isDay: isDay ?? this.isDay,
        condition: condition ?? this.condition,
        windMph: windMph ?? this.windMph,
        windKph: windKph ?? this.windKph,
        windDegree: windDegree ?? this.windDegree,
        windDir: windDir ?? this.windDir,
        pressureMb: pressureMb ?? this.pressureMb,
        pressureIn: pressureIn ?? this.pressureIn,
        precipMm: precipMm ?? this.precipMm,
        precipIn: precipIn ?? this.precipIn,
        humidity: humidity ?? this.humidity,
        cloud: cloud ?? this.cloud,
        feelslikeC: feelslikeC ?? this.feelslikeC,
        feelslikeF: feelslikeF ?? this.feelslikeF,
        windchillC: windchillC ?? this.windchillC,
        windchillF: windchillF ?? this.windchillF,
        heatindexC: heatindexC ?? this.heatindexC,
        heatindexF: heatindexF ?? this.heatindexF,
        dewpointC: dewpointC ?? this.dewpointC,
        dewpointF: dewpointF ?? this.dewpointF,
        visKm: visKm ?? this.visKm,
        visMiles: visMiles ?? this.visMiles,
        uv: uv ?? this.uv,
        gustMph: gustMph ?? this.gustMph,
        gustKph: gustKph ?? this.gustKph,
      );

  factory Current.fromJson(Map<String, dynamic> json) => Current(
    lastUpdatedEpoch: json["last_updated_epoch"]?.toDouble(),
    lastUpdated: json["last_updated"],
    tempC: json["temp_c"]?.toDouble(),
    tempF: json["temp_f"]?.toDouble(),
    isDay: json["is_day"]?.toDouble(),
    condition: Condition.fromJson(json["condition"]),
    windMph: json["wind_mph"]?.toDouble(),
    windKph: json["wind_kph"]?.toDouble(),
    windDegree: json["wind_degree"],
    windDir: json["wind_dir"],
    pressureMb: json["pressure_mb"]?.toDouble(),
    pressureIn: json["pressure_in"]?.toDouble(),
    precipMm: json["precip_mm"]?.toDouble(),
    precipIn: json["precip_in"]?.toDouble(),
    humidity: json["humidity"]?.toDouble(),
    cloud: json["cloud"]?.toDouble(),
    feelslikeC: json["feelslike_c"]?.toDouble(),
    feelslikeF: json["feelslike_f"]?.toDouble(),
    windchillC: json["windchill_c"]?.toDouble(),
    windchillF: json["windchill_f"]?.toDouble(),
    heatindexC: json["heatindex_c"]?.toDouble(),
    heatindexF: json["heatindex_f"]?.toDouble(),
    dewpointC: json["dewpoint_c"]?.toDouble(),
    dewpointF: json["dewpoint_f"]?.toDouble(),
    visKm: json["vis_km"]?.toDouble(),
    visMiles: json["vis_miles"]?.toDouble(),
    uv: json["uv"]?.toDouble(),
    gustMph: json["gust_mph"]?.toDouble(),
    gustKph: json["gust_kph"]?.toDouble(),
  );

  Map<String, dynamic> toJson() => {
    "last_updated_epoch": lastUpdatedEpoch,
    "last_updated": lastUpdated,
    "temp_c": tempC,
    "temp_f": tempF,
    "is_day": isDay,
    "condition": condition.toJson(),
    "wind_mph": windMph,
    "wind_kph": windKph,
    "wind_degree": windDegree,
    "wind_dir": windDir,
    "pressure_mb": pressureMb,
    "pressure_in": pressureIn,
    "precip_mm": precipMm,
    "precip_in": precipIn,
    "humidity": humidity,
    "cloud": cloud,
    "feelslike_c": feelslikeC,
    "feelslike_f": feelslikeF,
    "windchill_c": windchillC,
    "windchill_f": windchillF,
    "heatindex_c": heatindexC,
    "heatindex_f": heatindexF,
    "dewpoint_c": dewpointC,
    "dewpoint_f": dewpointF,
    "vis_km": visKm,
    "vis_miles": visMiles,
    "uv": uv,
    "gust_mph": gustMph,
    "gust_kph": gustKph,
  };
}

class Condition {
  final String text;
  final String icon;
  final double code;

  Condition({
    required this.text,
    required this.icon,
    required this.code,
  });

  Condition copyWith({
    String? text,
    String? icon,
    double? code,
  }) =>
      Condition(
        text: text ?? this.text,
        icon: icon ?? this.icon,
        code: code ?? this.code,
      );

  factory Condition.fromJson(Map<String, dynamic> json) => Condition(
    text: json["text"],
    icon: json["icon"],
    code: json["code"]?.toDouble(),
  );

  Map<String, dynamic> toJson() => {
    "text": text,
    "icon": icon,
    "code": code,
  };
}

class Location {
  final String name;
  final String region;
  final String country;
  final double lat;
  final double lon;
  final String tzId;
  final double localtimeEpoch;
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

  Location copyWith({
    String? name,
    String? region,
    String? country,
    double? lat,
    double? lon,
    String? tzId,
    double? localtimeEpoch,
    String? localtime,
  }) =>
      Location(
        name: name ?? this.name,
        region: region ?? this.region,
        country: country ?? this.country,
        lat: lat ?? this.lat,
        lon: lon ?? this.lon,
        tzId: tzId ?? this.tzId,
        localtimeEpoch: localtimeEpoch ?? this.localtimeEpoch,
        localtime: localtime ?? this.localtime,
      );

  factory Location.fromJson(Map<String, dynamic> json) => Location(
    name: json["name"],
    region: json["region"],
    country: json["country"],
    lat: json["lat"]?.toDouble(),
    lon: json["lon"]?.toDouble(),
    tzId: json["tz_id"],
    localtimeEpoch: json["localtime_epoch"]?.toDouble(),
    localtime: json["localtime"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "region": region,
    "country": country,
    "lat": lat,
    "lon": lon,
    "tz_id": tzId,
    "localtime_epoch": localtimeEpoch,
    "localtime": localtime,
  };
}
