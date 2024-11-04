// lib/widget/Bottom_navigation.dart

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../service/notification_service.dart';
import '../service/navigation_service.dart';

class BottomNavigation extends StatelessWidget {
  const BottomNavigation({super.key});

  String _formatNotificationCount(int count) {
    if (count > 99) return '99+';
    return count.toString();
  }

  // Widget _buildNotificationBadge(int count) {
  //   if (count == 0) return const SizedBox.shrink();
  //
  //   return Positioned(
  //     right: 0,
  //     top: 0,
  //     child: Container(
  //       padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
  //       decoration: BoxDecoration(
  //         color: Colors.deepOrange,
  //         borderRadius: BorderRadius.circular(10),
  //       ),
  //       constraints: const BoxConstraints(
  //         minWidth: 16,
  //         minHeight: 16,
  //       ),
  //       child: Text(
  //         _formatNotificationCount(count),
  //         style: const TextStyle(
  //           color: Colors.white,
  //           fontSize: 8,
  //           fontWeight: FontWeight.bold,
  //         ),
  //         textAlign: TextAlign.center,
  //       ),
  //     ),
  //   );
  // }

  Widget _buildNavItem({
    required IconData icon,
    required String label,
    required bool isSelected,
    Widget? badge,
    bool isSpecial = false,
    required VoidCallback onTap,
  }) {
    if (isSpecial) {
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                color: Colors.green,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.green.withOpacity(0.3),
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: IconButton(
                icon: const Icon(Icons.qr_code_scanner),
                color: Colors.white,
                iconSize: 30,
                onPressed: onTap,
              ),
            ),
          ),
        ],
      );
    }

    return IconButton(
      icon: Stack(
        children: [
          Icon(
            icon,
            color: isSelected ? Colors.green : const Color(0xFF9299A1),
            size: 24,
          ),
          if (badge != null) badge,
        ],
      ),
      onPressed: onTap,
    );
  }

  void _onItemTapped(BuildContext context, int index) {
    Provider.of<NavigationService>(context, listen: false).setIndex(index);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer2<NotificationService, NavigationService>(
      builder: (context, notificationService, navigationService, child) {
        return Container(
          width: double.infinity,
          height: 90,
          child: Stack(
            children: [
              Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    width: double.infinity,
                    height: 80,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          blurRadius: 10,
                          color: Colors.black.withOpacity(0.05),
                          offset: const Offset(0, -10),
                          spreadRadius: 0.1,
                        ),
                      ],
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20),
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  _buildNavItem(
                    icon: Icons.home_rounded,
                    label: 'Trang chủ',
                    isSelected: navigationService.selectedIndex == 0,
                    onTap: () => _onItemTapped(context, 0),
                  ),
                  _buildNavItem(
                    icon: Icons.receipt_outlined,
                    label: 'Lịch sử',
                    isSelected: navigationService.selectedIndex == 1,
                    onTap: () => _onItemTapped(context, 1),
                  ),
                  _buildNavItem(
                    icon: Icons.qr_code_scanner,
                    label: 'Scan & Pay',
                    isSelected: navigationService.selectedIndex == 2,
                    isSpecial: true,
                    onTap: () => _onItemTapped(context, 2),
                  ),
                  _buildNavItem(
                    icon: Icons.notifications_outlined,
                    label: 'Thông báo',
                    isSelected: navigationService.selectedIndex == 3,
                    // badge: _buildNotificationBadge(notificationService.notificationCount),
                    onTap: () => _onItemTapped(context, 3),
                  ),
                  _buildNavItem(
                    icon: Icons.person_outline,
                    label: 'Tôi',
                    isSelected: navigationService.selectedIndex == 4,
                    onTap: () => _onItemTapped(context, 4),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}