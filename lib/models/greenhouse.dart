class Greenhouse {
  final String id;

  String name;

  double temperature;
  double humidity;

  bool lightOn;
  bool coolerOn;

  double tempMin;
  double tempMax;
  double humidityMin;
  double humidityMax;

  int lightStartHour;
  int lightEndHour;

  Greenhouse({
    required this.id,
    this.name = "Invernadero 0",
    this.temperature = 0,
    this.humidity = 0,
    this.lightOn = false,
    this.coolerOn = false,
    this.tempMin = 0,
    this.tempMax = 0,
    this.humidityMin = 0,
    this.humidityMax = 0,
    this.lightStartHour = 0,
    this.lightEndHour = 0,
  });
}
