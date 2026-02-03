import 'dart:io';
import 'package:flutter/material.dart';
import 'package:hello_flutter/models/greenhouse_repository.dart';
import 'package:mqtt_client/mqtt_client.dart';
import 'package:mqtt_client/mqtt_server_client.dart';
import 'dart:convert';


class MqttService extends ChangeNotifier {
  // Cliente
  final  client =
  MqttServerClient('broker.hivemq.com', '');
  bool _connected = false;



  // Datos
  final GreenhouseRepository repo;


  MqttService(this.repo) {
    _connect();
  }

  // Conexión
  Future<void> _connect() async {
    client.logging(on: false);
    client.setProtocolV311();
    client.keepAlivePeriod = 20;
    client.connectTimeoutPeriod = 2000;
    client.port = 1883;

    final connMess = MqttConnectMessage()
        .withClientIdentifier('flutter_test_client')
        .withWillTopic('willtopic')
        .withWillMessage('My Will message')
        .startClean()
        .withWillQos(MqttQos.atLeastOnce);

    client.connectionMessage = connMess;

    try {
      await client.connect();
      _connected = true;
      print('MQTT conectado');
    } on SocketException {
      print('Error de conexión MQTT');
      client.disconnect();
      return;
    }

    final greenhouses = repo.getAll();


    for (final gh in greenhouses) {
      subscribeGreenhouse(gh.id);
    }


    client.updates!.listen(_onMessage);
  }

  // Topicos
  void subscribeGreenhouse(String greenhouseId) {
    if (!_connected) return;

    print("se esta suscribiendo ${greenhouseId}");

    client.subscribe(
      'greenhouse/$greenhouseId/temperature',
      MqttQos.atLeastOnce,
    );

    client.subscribe(
      'greenhouse/$greenhouseId/humidity',
      MqttQos.atLeastOnce,
    );

    client.subscribe(
      'greenhouse/$greenhouseId/light',
      MqttQos.atLeastOnce,
    );

    client.subscribe(
      'greenhouse/$greenhouseId/cooler',
      MqttQos.atLeastOnce);

    client.subscribe(
      'greenhouse/$greenhouseId/config',
      MqttQos.atLeastOnce);

  }

  // Mensajes
  void _onMessage(List<MqttReceivedMessage<MqttMessage>> messages) {
    final msg = messages[0].payload as MqttPublishMessage;
    final payload =
    MqttPublishPayload.bytesToStringAsString(msg.payload.message);

    final topic = messages[0].topic;
    final parts = topic.split('/');

    final greenhouseId = parts[1];
    final type = parts[2];

    repo.ensureGreenhouse(greenhouseId);
    
    switch(type){
      case 'temperature':
        repo.updateTemperature(greenhouseId, double.tryParse(payload) ?? 0);
        break;
      case 'humidity':
        repo.updateHumidity(greenhouseId, double.tryParse(payload) ?? 0);
        break;
      case 'light':
        repo.updateLight(greenhouseId, payload == '1');
        break;
      case 'cooler':
        repo.updateCooler(greenhouseId, payload == '1');
        break;
      case 'config':
        final Map<String, dynamic> data = jsonDecode(payload);
        repo.updateConfig(greenhouseId, data);
        break;

    }
    print(type);
  }

  //Publicaciones

  void publishLight(String greenhouseId, bool turnOn){
    if (!_connected) return;
    
    final builder = MqttClientPayloadBuilder();
    builder.addString(turnOn ? '1' : '0');
    
    client.publishMessage('greenhouse/$greenhouseId/cmd/light',
        MqttQos.atLeastOnce,
        builder.payload!);

    print('CMD light -> ${turnOn ? 'ON' : 'OFF'}');
  }

  void publishCooler(String greenhouseId, bool turnOn){
    if (!_connected) return;

    final builder = MqttClientPayloadBuilder();
    builder.addString(turnOn ? '1' : '0');

    client.publishMessage('greenhouse/$greenhouseId/cmd/cooler',
        MqttQos.atLeastOnce,
        builder.payload!);

    print('CMD cooler -> ${turnOn ? 'ON' : 'OFF'}');
  }


}

