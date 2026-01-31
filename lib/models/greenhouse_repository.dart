import 'package:flutter/material.dart';
import '../models/greenhouse.dart';

class GreenhouseRepository extends ChangeNotifier {

  final Map<String, Greenhouse> _greenhouses = {};

  GreenhouseRepository() {
    _greenhouses['gh_test_01'] = Greenhouse(
      id: 'gh_test_01',
      name: 'Invernadero Principal',
    );

    _greenhouses['gh_test_02'] = Greenhouse(
      id: 'gh_test_02',
      name: 'Invernadero Secundario',
    );
  }

  List<Greenhouse> getAll() => _greenhouses.values.toList();

  List<Greenhouse> get all => _greenhouses.values.toList();

  Greenhouse? getById(String id) => _greenhouses[id];

  bool contains(String id) => _greenhouses.containsKey(id);


  void ensureGreenhouse(String id) {
    _greenhouses.putIfAbsent(
      id,
          () => Greenhouse(id: id),
    );
  }

  void addIfAbsent(String id) {
    if (_greenhouses.containsKey(id)) return;

    _greenhouses[id] = Greenhouse(id: id);
    notifyListeners();
  }

  void updateTemperature(String id, double value) {
    final gh = _greenhouses[id];
    if (gh == null) return;

    gh.temperature = value;
    notifyListeners();
  }

  void updateHumidity(String id, double value) {
    final gh = _greenhouses[id];
    if (gh == null) return;

    gh.humidity = value;
    notifyListeners();
  }

  void updateLight(String id, bool on) {
    final gh = _greenhouses[id];
    if (gh == null) return;

    gh.lightOn = on;
    notifyListeners();
  }

  void updateCooler(String id, bool on) {
    final gh = _greenhouses[id];
    if (gh == null) return;

    gh.coolerOn = on;
    notifyListeners();
  }

  void updateConfig(String id, Map<String, dynamic> data) {
    final gh = _greenhouses[id];
    if (gh == null) return;

    if (data.containsKey('tempMin')) {
      gh.tempMin = (data['tempMin'] as num).toDouble();
    }

    if (data.containsKey('tempMax')) {
      gh.tempMax = (data['tempMax'] as num).toDouble();
    }

    if (data.containsKey('humidityMin')) {
      gh.humidityMin = (data['humidityMin'] as num).toDouble();
    }

    if (data.containsKey('humidityMax')) {
      gh.humidityMax = (data['humidityMax'] as num).toDouble();
    }

    if (data.containsKey('lightStartHour')) {
      gh.lightStartHour = data['lightStartHour'] as int;
    }

    if (data.containsKey('lightEndHour')) {
      gh.lightEndHour = data['lightEndHour'] as int;
    }

    notifyListeners();
  }



  Future<void> loadFromLocal() async {
    // SharedPreferences
  }

  Future<void> saveToLocal() async {
    // persistencia más adelante
  }
}
