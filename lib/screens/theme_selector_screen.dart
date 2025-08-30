import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/theme_service.dart';

class ThemeSelectorScreen extends StatelessWidget {
  const ThemeSelectorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final themeService = Provider.of<ThemeService>(context);
    final currentTheme = themeService.currentTheme;
    
    return Scaffold(
      appBar: AppBar(
        title: const Text('Select Theme'),
        backgroundColor: currentTheme.primaryColor,
        foregroundColor: currentTheme.appBarTheme.foregroundColor,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(15)),
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              currentTheme.primaryColor.withOpacity(0.1),
              currentTheme.scaffoldBackgroundColor,
            ],
          ),
        ),
        child: ListView.builder(
          itemCount: themeService.themeNames.length,
          itemBuilder: (context, index) {
            final themeName = themeService.themeNames[index];
            final themeData = themeService.currentTheme;
            final isSelected = themeService.currentThemeName == themeName;
            
            return Card(
              margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              color: isSelected 
                  ? themeData.primaryColor.withOpacity(0.2)
                  : themeData.cardColor,
              elevation: 2,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
                side: BorderSide(
                  color: isSelected 
                      ? themeData.primaryColor 
                      : Colors.transparent,
                  width: 2,
                ),
              ),
              child: ListTile(
                leading: Container(
                  width: 24,
                  height: 24,
                  decoration: BoxDecoration(
                    color: themeData.primaryColor,
                    shape: BoxShape.circle,
                  ),
                ),
                title: Text(
                  themeName,
                  style: TextStyle(
                    color: themeData.textTheme.bodyLarge?.color,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                trailing: isSelected 
                    ? Icon(Icons.check_circle, color: themeData.primaryColor)
                    : const Icon(Icons.circle_outlined),
                onTap: () {
                  themeService.setTheme(themeName);
                  Navigator.pop(context);
                },
                contentPadding: const EdgeInsets.symmetric(horizontal: 16),
              ),
            );
          },
        ),
      ),
    );
  }
}