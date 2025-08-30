import 'package:flutter/material.dart';

class ProductivityChart extends StatelessWidget {
  final List<Map<String, dynamic>> data;

  const ProductivityChart({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    final maxValue = data.isNotEmpty
        ? data.map<double>((e) => e['count'].toDouble()).reduce((a, b) => a > b ? a : b)
        : 1.0;

    return Container(
      height: 200,
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: data.asMap().entries.map((entry) {
                final dayData = entry.value;
                final height = maxValue > 0 ? (dayData['count'] / maxValue) * 150 : 0;
                
                return Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      width: 20,
                      height: height,
                      margin: const EdgeInsets.symmetric(horizontal: 4),
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.primary,
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      _getDayAbbreviation(dayData['date'].weekday),
                      style: TextStyle(
                        fontSize: 10,
                        color: Theme.of(context).colorScheme.onBackground,
                      ),
                    ),
                  ],
                );
              }).toList(),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Tasks Completed',
            style: TextStyle(
              color: Theme.of(context).colorScheme.onBackground,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  String _getDayAbbreviation(int weekday) {
    switch (weekday) {
      case 1: return 'Mon';
      case 2: return 'Tue';
      case 3: return 'Wed';
      case 4: return 'Thu';
      case 5: return 'Fri';
      case 6: return 'Sat';
      case 7: return 'Sun';
      default: return '';
    }
  }
}