import 'package:flutter/material.dart';
import 'home.dart';
import 'settings.dart';
import 'favorites.dart';
import 'cart.dart';
import '../providers/settings_provider.dart';
import '../providers/cart_provider.dart';

class MainScreen extends StatefulWidget {
  final SettingsProvider settingsProvider;
  final CartProvider cartProvider;

  const MainScreen({
    super.key,
    required this.settingsProvider,
    required this.cartProvider,
  });

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;
  late final List<Widget> _pages;

  bool get isDarkMode => widget.settingsProvider.isDarkMode;

  @override
  void initState() {
    super.initState();
    _pages = [
      HomePage(
        settingsProvider: widget.settingsProvider,
        cartProvider: widget.cartProvider,
      ),
      FavoritesPage(
        settingsProvider: widget.settingsProvider,
        cartProvider: widget.cartProvider,
      ),
      CartPage(
        settingsProvider: widget.settingsProvider,
        cartProvider: widget.cartProvider,
      ),
      SettingsPage(settingsProvider: widget.settingsProvider),
    ];
    widget.settingsProvider.addListener(_onSettingsChanged);
    widget.cartProvider.addListener(_onSettingsChanged);
  }

  @override
  void dispose() {
    widget.settingsProvider.removeListener(_onSettingsChanged);
    widget.cartProvider.removeListener(_onSettingsChanged);
    super.dispose();
  }

  void _onSettingsChanged() {
    if (mounted) setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(index: _selectedIndex, children: _pages),
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(color: Colors.transparent),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 4),
            child: BottomNavigationBar(
              currentIndex: _selectedIndex,
              onTap: (index) => setState(() => _selectedIndex = index),
              backgroundColor: Colors.transparent,
              elevation: 0,
              selectedItemColor: Colors.teal,
              unselectedItemColor: isDarkMode
                  ? Colors.grey[600]
                  : Colors.grey[400],
              showSelectedLabels: true,
              showUnselectedLabels: true,
              type: BottomNavigationBarType.fixed,
              selectedLabelStyle: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 12,
              ),
              unselectedLabelStyle: const TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 12,
              ),
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
                  icon: Badge(
                    label: Text(widget.cartProvider.items.length.toString()),
                    isLabelVisible: widget.cartProvider.items.isNotEmpty,
                    backgroundColor: Colors.teal,
                    child: const Icon(Icons.shopping_cart_rounded),
                  ),
                  activeIcon: Badge(
                    label: Text(widget.cartProvider.items.length.toString()),
                    isLabelVisible: widget.cartProvider.items.isNotEmpty,
                    backgroundColor: Colors.teal,
                    child: const Icon(Icons.shopping_cart_rounded, size: 28),
                  ),
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
