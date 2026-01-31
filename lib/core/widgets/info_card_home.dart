import 'package:flutter/material.dart';

class InfoCard extends StatelessWidget {
  final String title;
  final String value;
  final String max;
  final String min;
  final Color color;

  const InfoCard({
    required this.title,
    required this.value,
    required this.max,
    required this.min,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 125,
      height: 100,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text("max: $max", style: const TextStyle(color: Colors.white)),
          Text(
            value,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          Text("min: $min", style: const TextStyle(color: Colors.white)),
          Text(
            title,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
