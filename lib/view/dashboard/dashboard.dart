// ignore_for_file: deprecated_member_use
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';
import 'package:spsole/view/dashboard/menu.dart';
import 'package:spsole/view/dashboard/orders.dart';
import 'package:spsole/view/dashboard/products.dart';
import 'package:spsole/widgets/mycolors.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  late PersistentTabController _controller;

  @override
  void initState() {
    super.initState();
    _controller = PersistentTabController(initialIndex: 0);
  }

  // ---------------- SCREENS ----------------
  List<Widget> _buildScreens() {
    return [
      const _DashboardHome(),
       Products(),
      const _ScannerScreen(),
      const Orders(),
       Menu(),
    ];
  }

  // ---------------- NAV ITEMS ----------------
  List<PersistentBottomNavBarItem> _navBarsItems() {
    return [
      PersistentBottomNavBarItem(
        icon: const Icon(Icons.home),
        title: ("Dashboard"),
        activeColorPrimary: AppColors.primary,
        inactiveColorPrimary: AppColors.surface,
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(Icons.shopping_bag),
        title: ("Products"),
        activeColorPrimary: AppColors.primary,
        inactiveColorPrimary: AppColors.surface,
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(Icons.scanner_outlined),
        title: ("scanner"),
        activeColorPrimary: AppColors.primary,
        inactiveColorPrimary: AppColors.surface,
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(Icons.trending_up),
        title: ("Orders"),
        activeColorPrimary: AppColors.primary,
        inactiveColorPrimary: AppColors.surface,
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(Icons.person_2_outlined),
        title: ("Menu"),
        activeColorPrimary: AppColors.primary,
        inactiveColorPrimary: AppColors.surface,
      ),
    ];
  }

  // ---------------- MAIN UI ----------------
  @override
  Widget build(BuildContext context) {
    return PersistentTabView(
      context,
      controller: _controller,
      screens: _buildScreens(),
      items: _navBarsItems(),
      navBarStyle: NavBarStyle.style15,
      backgroundColor: AppColors.fgcolor,
      decoration: NavBarDecoration(
        colorBehindNavBar: AppColors.bgcolor,
        borderRadius: BorderRadius.circular(12),
      ),
      handleAndroidBackButtonPress: true,
      resizeToAvoidBottomInset: true,
      stateManagement: true,
      // safeArea: true, // ✅ FIXED
    );
  }
}

// ============================================================================
// HOME SCREEN (EMPTY)
// ============================================================================
class _DashboardHome extends StatelessWidget {
  const _DashboardHome();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgcolor,
      body: const SafeArea(
        child: Center(
          child: Text(
            "Dashboard",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
        ),
      ),
    );
  }
}

// ============================================================================
// SCANNER SCREEN (PLACEHOLDER)
// ============================================================================
class _ScannerScreen extends StatelessWidget {
  const _ScannerScreen();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgcolor,
      body: const SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.scanner_outlined, size: 64, color: Colors.white),
              SizedBox(height: 16),
              Text(
                "Scanner",
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ============================================================================
// MENU SCREEN (PLACEHOLDER)
// ============================================================================
// ignore: unused_element
class _MenuScreen extends StatelessWidget {
  const _MenuScreen();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgcolor,
      body: const SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.person_2_outlined, size: 64, color: Colors.white),
              SizedBox(height: 16),
              Text("Menu", style: TextStyle(color: Colors.white, fontSize: 20)),
            ],
          ),
        ),
      ),
    );
  }
}
