import 'package:fit_track/features/core/theme/app_colors.dart';
import 'package:fit_track/features/fit_track/presentations/bottomNavigation/navigation_pages/Homepage.dart';
import 'package:fit_track/features/fit_track/presentations/bottomNavigation/navigation_pages/logPage.dart';
import 'package:fit_track/features/fit_track/presentations/bottomNavigation/navigation_pages/settingPage.dart';
import 'package:fit_track/features/fit_track/presentations/bottomNavigation/navigation_pages/statisticsPage.dart';
import 'package:fit_track/features/fit_track/providers/bottomnavigation_provider/bottom_navigation_Provider.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class MyNavigationBar extends ConsumerWidget {
  MyNavigationBar({super.key});
  final index = 0;
  final List<Widget> pages = [
    const Homepage(),
    Statisticspage(),
    const Logpage(),

    const SettingsPage(),
  ];
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final indexProvider = ref.watch(bottomNaviationIndexProvider);
    return Scaffold(
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          gradient: SweepGradient(
            startAngle: 0,
            endAngle: 45,
            center: Alignment.topRight,

            colors: [AppColors.black, AppColors.yelow],
          ),
        ),
        child: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          backgroundColor: Colors.transparent,
          elevation: 0,

          selectedItemColor: AppColors.yelow,
          unselectedItemColor: Colors.grey.shade500,
          showSelectedLabels: true,
          showUnselectedLabels: false,
          currentIndex: indexProvider,
          onTap: (value) {
            ref.read(bottomNaviationIndexProvider.notifier).state = value;
          },
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.home_outlined),
              activeIcon: Icon(Icons.home, color: AppColors.yelow),
              label: 'Home',
              backgroundColor: AppColors.yelow,
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.bar_chart_outlined),
              activeIcon: Icon(Icons.bar_chart, color: AppColors.yelow),
              label: 'Statistics',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.add, color: Colors.white, size: 28),
              activeIcon: Icon(Icons.person, color: AppColors.yelow),
              label: 'Log',
            ),

            BottomNavigationBarItem(
              icon: Icon(Icons.settings),
              activeIcon: Icon(Icons.settings, color: AppColors.yelow),
              label: 'Settings',
            ),
          ],
        ),
      ),
      body: pages[indexProvider],
    );
  }
}
