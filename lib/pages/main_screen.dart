import 'package:flutter/material.dart';
import 'home.dart';
import 'settings.dart';
import 'favorites.dart';
import 'cart.dart';
import '../providers/settings_provider.dart';

class MainScreen extends StatefulWidget {
  final SettingsProvider settingsProvider;

  const MainScreen({super.key, required this.settingsProvider});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;

  bool get isDarkMode => widget.settingsProvider.isDarkMode;

  @override
  void initState() {
    super.initState();
    widget.settingsProvider.addListener(_onSettingsChanged);
  }

  @override
  void dispose() {
    widget.settingsProvider.removeListener(_onSettingsChanged);
    super.dispose();
  }

  void _onSettingsChanged() {
    if (mounted) setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> pages = [
      HomePage(settingsProvider: widget.settingsProvider),
      FavoritesPage(settingsProvider: widget.settingsProvider),
      CartPage(settingsProvider: widget.settingsProvider),
      SettingsPage(settingsProvider: widget.settingsProvider),
    ];

    return Scaffold(
      body: IndexedStack(
        index: _selectedIndex,
        children: pages,
      ),
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          color: Colors.transparent,
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 4),
            child: BottomNavigationBar(
              currentIndex: _selectedIndex,
              onTap: (index) => setState(() => _selectedIndex = index),
              backgroundColor: Colors.transparent,
              elevation: 0,
              selectedItemColor: Colors.teal,
              unselectedItemColor: isDarkMode ? Colors.grey[600] : Colors.grey[400],
              showSelectedLabels: true,
              showUnselectedLabels: true,
              type: BottomNavigationBarType.fixed,
              selectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
              unselectedLabelStyle: const TextStyle(fontWeight: FontWeight.w500, fontSize: 12),
              items: [
                BottomNavigationBarItem(
                  icon: const Icon(Icons.home_rounded),
                  activeIcon: const Icon(Icons.home_rounded, size: 28),
                  label: widget.settingsProvider.translate('home_title'),
                ),
                BottomNavigationBarItem(
                  icon: const Icon(Icons.favorite_rounded),
                  activeIcon: const Icon(Icons.favorite_rounded, size: 28),
                  label: widget.settingsProvider.translate('favorites'),
                ),
                BottomNavigationBarItem(
                  icon: const Icon(Icons.shopping_cart_rounded),
                  activeIcon: const Icon(Icons.shopping_cart_rounded, size: 28),
                  label: widget.settingsProvider.translate('cart'),
                ),
                BottomNavigationBarItem(
                  icon: const Icon(Icons.settings_rounded),
                  activeIcon: const Icon(Icons.settings_rounded, size: 28),
                  label: widget.settingsProvider.translate('settings'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
