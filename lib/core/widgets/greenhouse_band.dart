import 'package:flutter/material.dart';
import 'package:hello_flutter/core/res/styles/app_styles.dart';
import 'package:hello_flutter/models/greenhouse_repository.dart';
import 'package:provider/provider.dart';
import '../../models/greenhouse.dart';

enum BandType {
  light,
  temperature,
  humidity,
}

class GreenhouseBand extends StatefulWidget {
  final BandType bandType;
  final String greenhouseId;

  final Function(double)? onMinChanged;
  final Function(double)? onMaxChanged;
  final Function(int)? onStartHourChanged;
  final Function(int)? onEndHourChanged;

  const GreenhouseBand({
    super.key,
    required this.greenhouseId,
    required this.bandType,
    this.onMinChanged,
    this.onMaxChanged,
    this.onStartHourChanged,
    this.onEndHourChanged,
  });

  @override
  State<GreenhouseBand> createState() => _GreenhouseBandState();
}

class _GreenhouseBandState extends State<GreenhouseBand> {
  late TextEditingController _maxController;
  late TextEditingController _minController;

  late TimeOfDay _startTime;
  late TimeOfDay _endTime;

  bool _initialized = false;

  TimeOfDay _hourToTime(int? hour) {
    return TimeOfDay(
      hour: hour ?? 0,
      minute: 0,
    );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    if (_initialized) return;

    final gh = context.read<GreenhouseRepository>()
        .getById(widget.greenhouseId);

    _maxController = TextEditingController();
    _minController = TextEditingController();

    if (gh != null) {
      switch (widget.bandType) {
        case BandType.temperature:
          _maxController.text = gh.tempMax.toString();
          _minController.text = gh.tempMin.toString();
          break;

        case BandType.humidity:
          _maxController.text = gh.humidityMax.toString();
          _minController.text = gh.humidityMin.toString();
          break;

        case BandType.light:
          _startTime = _hourToTime(gh.lightStartHour);
          _endTime = _hourToTime(gh.lightEndHour);
          break;
      }
    } else {
      _startTime = const TimeOfDay(hour: 0, minute: 0);
      _endTime = const TimeOfDay(hour: 0, minute: 0);
    }

    _initialized = true;
  }

  @override
  void dispose() {
    _maxController.dispose();
    _minController.dispose();
    super.dispose();
  }

  String get title {
    switch (widget.bandType) {
      case BandType.light:
        return 'Luces';
      case BandType.temperature:
        return 'Temperatura';
      case BandType.humidity:
        return 'Humedad';
    }
  }

  Color bgColor() {
    switch (widget.bandType) {
      case BandType.light:
        return Colors.amber;
      case BandType.temperature:
        return Colors.green;
      case BandType.humidity:
        return Colors.blue;
    }
  }

  Color insideColor() {
    switch (widget.bandType) {
      case BandType.light:
        return const Color(0xFFb59125);
      case BandType.humidity:
        return Colors.blue.shade900;
      case BandType.temperature:
        return Colors.green.shade900;
    }
  }

  Widget _divider() {
    return const VerticalDivider(
      color: Colors.white24,
      thickness: 1,
      width: 16,
    );
  }

  Widget _valueBox(String value) {
    return Text(value, style: AppStyles.textLineStyle1);
  }

  Widget _numberInput(
      TextEditingController controller,
      void Function(String)? onChanged,
      ) {
    return SizedBox(
      width: 60,
      child: TextFormField(
        controller: controller,
        keyboardType: TextInputType.number,
        textAlign: TextAlign.center,
        style: AppStyles.textLineStyle4,
        decoration: const InputDecoration(
          isDense: true,
          border: InputBorder.none,
        ),
        onChanged: onChanged,
      ),
    );
  }

  Widget _temperatureRow(Greenhouse gh) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _valueBox('${gh.temperature}°'),
        _divider(),
        Column(
          children: [
            Text('Max', style: AppStyles.textLineStyle3),
            _numberInput(_maxController, (value) {
              final v = double.tryParse(value);
              if (v != null) {
                widget.onMaxChanged?.call(v);
              }
            }),
          ],
        ),
        _divider(),
        Column(
          children: [
            Text('Min', style: AppStyles.textLineStyle3),
            _numberInput(_minController, (value) {
              final v = double.tryParse(value);
              if (v != null) {
                widget.onMinChanged?.call(v);
              }
            }),
          ],
        ),
      ],
    );
  }

  Widget _humidityRow(Greenhouse gh) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _valueBox('${gh.humidity}%'),
        _divider(),
        Column(
          children: [
            Text('Max', style: AppStyles.textLineStyle3),
            _numberInput(_maxController, (value) {
              final v = double.tryParse(value);
              if (v != null) {
                widget.onMaxChanged?.call(v);
              }
            }),
          ],
        ),
        _divider(),
        Column(
          children: [
            Text('Min', style: AppStyles.textLineStyle3),
            _numberInput(_minController, (value) {
              final v = double.tryParse(value);
              if (v != null) {
                widget.onMinChanged?.call(v);
              }
            }),
          ],
        ),
      ],
    );
  }

  Widget _lightRow(Greenhouse gh) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _timePicker(
          label: 'Inicio',
          value: _startTime,
          onChanged: (t) {
            setState(() => _startTime = t);
            widget.onStartHourChanged?.call(t.hour);
          },
        ),
        _divider(),
        _timePicker(
          label: 'Fin',
          value: _endTime,
          onChanged: (t) {
            setState(() => _endTime = t);
            widget.onEndHourChanged?.call(t.hour);
          },
        ),
      ],
    );
  }

  Widget _timePicker({
    required String label,
    required TimeOfDay value,
    required void Function(TimeOfDay) onChanged,
  }) {
    return Column(
      children: [
        Text(label, style: AppStyles.textLineStyle3),
        InkWell(
          onTap: () async {
            final picked = await showTimePicker(
              context: context,
              initialTime: value,
            );
            if (picked != null) {
              onChanged(picked);
            }
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 6),
            child: Text(
              value.format(context),
              style: AppStyles.textLineStyle4,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildContent(Greenhouse gh) {
    switch (widget.bandType) {
      case BandType.temperature:
        return _temperatureRow(gh);
      case BandType.humidity:
        return _humidityRow(gh);
      case BandType.light:
        return _lightRow(gh);
    }
  }

  @override
  Widget build(BuildContext context) {
    final gh = context.watch<GreenhouseRepository>()
        .getById(widget.greenhouseId);

    if (gh == null) return const SizedBox.shrink();

    return SizedBox(
      height: 100,
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25),
          color: bgColor(),
        ),
        child: Column(
          children: [
            Text(title, style: AppStyles.textLineStyle2),
            const SizedBox(height: 6),
            Container(
              height: 50,
              decoration: BoxDecoration(
                color: insideColor(),
                borderRadius: BorderRadius.circular(15),
              ),
              child: _buildContent(gh),
            ),
          ],
        ),
      ),
    );
  }
}

