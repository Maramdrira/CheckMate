// lib/widgets/prayer_times.dart
import 'package:flutter/material.dart';
import '../models/prayer.dart';

class PrayerTimesWidget extends StatelessWidget {
  final List<PrayerTime> prayers;
  final Function(PrayerTime) onToggleCompletion;

  const PrayerTimesWidget({
    super.key,
    required this.prayers,
    required this.onToggleCompletion,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: prayers.length,
      itemBuilder: (context, index) {
        final prayer = prayers[index];
        return _buildPrayerCard(context, prayer);
      },
    );
  }

  Widget _buildPrayerCard(BuildContext context, PrayerTime prayer) {
    final theme = Theme.of(context);
    
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      elevation: 2,
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        leading: Container(
          width: 44,
          height: 44,
          decoration: BoxDecoration(
            color: prayer.isCompleted 
                ? Colors.green.withOpacity(0.2) 
                : theme.primaryColor.withOpacity(0.2),
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: prayer.isCompleted 
                  ? Colors.green 
                  : theme.primaryColor,
              width: 2,
            ),
          ),
          child: Icon(
            prayer.isCompleted ? Icons.check : Icons.access_time,
            color: prayer.isCompleted ? Colors.green : theme.primaryColor,
            size: 20,
          ),
        ),
        title: Text(
          prayer.name,
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 16,
            color: theme.textTheme.bodyLarge?.color,
            decoration: prayer.isCompleted 
                ? TextDecoration.lineThrough 
                : TextDecoration.none,
          ),
        ),
        trailing: Checkbox(
          value: prayer.isCompleted,
          onChanged: (value) => onToggleCompletion(prayer),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(4),
          ),
          activeColor: theme.primaryColor,
        ),
      ),
    );
  }
}