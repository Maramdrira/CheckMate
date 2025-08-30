import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/LanguageService.dart';

import '../models/hydration.dart';

class HydrationTracker extends StatelessWidget {
  final HydrationSettings settings;
  final VoidCallback onAddGlass;
  final VoidCallback onRemoveGlass;

  const HydrationTracker({
    super.key,
    required this.settings,
    required this.onAddGlass,
    required this.onRemoveGlass,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
   
    final lang = Provider.of<LanguageService>(context);
    final remaining = settings.dailyGoal - settings.glassesConsumed;
    final percentage = settings.progressPercentage;


    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            // Header with goal
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
               Text(
  lang.tr('Today\'s Hydration', arabic: 'الماء لليوم'),
  style: TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.bold,
    color: theme.textTheme.bodyLarge?.color,
  ),
),
                Text(
                  '${settings.glassesConsumed}/${settings.dailyGoal} glasses',
                  style: TextStyle(
                    fontSize: 16,
                    color: theme.textTheme.bodyLarge?.color,
                  ),
                ),
              ],
            ),
            
            const SizedBox(height: 20),
            
            // Progress circle
            Stack(
              alignment: Alignment.center,
              children: [
                // Background circle
                Container(
                  width: 120,
                  height: 120,
                  decoration: BoxDecoration(
                    color: theme.colorScheme.surface,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 8,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                ),
                
                // Progress circle
                SizedBox(
                  width: 100,
                  height: 100,
                  child: CircularProgressIndicator(
                    value: percentage,
                    strokeWidth: 8,
                    backgroundColor: theme.colorScheme.surface.withOpacity(0.5),
                    valueColor: AlwaysStoppedAnimation<Color>(
                      settings.isGoalAchieved 
                          ? Colors.green 
                          : theme.primaryColor,
                    ),
                  ),
                ),
                
                // Percentage text
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      '${(percentage * 100).toStringAsFixed(0)}%',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: theme.textTheme.bodyLarge?.color,
                      ),
                    ),
                Text(
  lang.tr('completed', arabic: 'مكتمل'),
  style: TextStyle(
    fontSize: 12,
    color: theme.textTheme.bodyLarge?.color?.withOpacity(0.7),
  ),
),
                  ],
                ),
              ],
            ),
            
            const SizedBox(height: 20),
            
            // Remaining text
       Text(
  remaining <= 0
      ? lang.tr('🎉 Goal achieved!', arabic: '🎉 الهدف تم تحقيقه!')
      : lang.tr(
          '$remaining glass${remaining > 1 ? 'es' : ''} to go',
          arabic: 'تبقى $remaining كوب',
        ),
  style: TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w500,
    color: remaining <= 0 ? Colors.green : theme.textTheme.bodyLarge?.color,
  ),
),
            
            const SizedBox(height: 20),
            
            // Action buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
              // Buttons
ElevatedButton(
  onPressed: onRemoveGlass,
  style: ElevatedButton.styleFrom(
    backgroundColor: theme.colorScheme.error,
    foregroundColor: Colors.white,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(8),
    ),
    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
  ),
  child: Text(lang.tr('-1 Glass', arabic: '-1 كوب')),
),
                
      ElevatedButton(
  onPressed: onAddGlass,
  style: ElevatedButton.styleFrom(
    backgroundColor: theme.primaryColor,
    foregroundColor: theme.appBarTheme.foregroundColor,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(8),
    ),
    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
  ),
  child: Text(lang.tr('+1 Glass', arabic: '+1 كوب')),
),
              ],
            ),
          ],
        ),
      ),
    );
  }
}