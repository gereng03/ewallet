// lib/screen/main_screen.dart

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../service/navigation_service.dart';
import 'home_screen.dart';
import 'history_screen.dart';
import 'scan_screen.dart';
import 'notification_screen.dart';
import 'profile_screen.dart';
import '../widget/Bottom_navigation.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<NavigationService>(
      builder: (context, navigationService, child) {
        return Scaffold(
          body: IndexedStack(
            index: navigationService.selectedIndex,
            children: const [
              HomeScreen(),
              HistoryScreen(),
              QRScannerScreen(),
              NotificationsScreen(),
              ProfileScreen(),
            ],
          ),
          bottomNavigationBar: const BottomNavigation(),
        );
      },
    );
  }
}