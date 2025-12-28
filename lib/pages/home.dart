import 'package:first_app/models/catagory_model.dart';
import 'package:first_app/models/diet_model.dart';
import 'package:first_app/models/popular_model.dart';
import 'package:first_app/models/profile_model.dart';
import 'package:first_app/providers/settings_provider.dart';
import 'package:first_app/providers/cart_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HomePage extends StatefulWidget {
  final SettingsProvider settingsProvider;
  final CartProvider cartProvider;

  const HomePage({
    super.key,
    required this.settingsProvider,
    required this.cartProvider,
  });

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<CatagoryModel> catagoryList = [];
  List<DietModel> dietList = [];
  List<PopularModel> popularList = [];
  List<ProfileModel> profile = [];

  bool get isDarkMode => widget.settingsProvider.isDarkMode;

  void _getInitailInfo() {
    catagoryList = CatagoryModel.getCatagoryList();
    dietList = DietModel.getDietList();
    popularList = PopularModel.getPopularList();
    profile = ProfileModel.getDefaultProfile();

    // Initial sync with cart and favorites
    for (int i = 0; i < dietList.length; i++) {
      dietList[i] = dietList[i].copyWith(
        viewIsSelected: widget.cartProvider.isInCart(dietList[i].name),
        isFavorite: widget.cartProvider.isFavorite(dietList[i].name),
      );
    }
  }

  @override
  void initState() {
    super.initState();
    _getInitailInfo();
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
    if (mounted) {
      setState(() {
        // Sync cart and favorite state with our local list
        for (int i = 0; i < dietList.length; i++) {
          dietList[i] = dietList[i].copyWith(
            viewIsSelected: widget.cartProvider.isInCart(dietList[i].name),
            isFavorite: widget.cartProvider.isFavorite(dietList[i].name),
          );
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(),
      body: ListView(
        physics: const BouncingScrollPhysics(),
        children: [
          _welcomeSection(),
          _searchField(),
          const SizedBox(height: 24),
          _catagorySection(),
          const SizedBox(height: 32),
          _deitSection(),
          const SizedBox(height: 32),
          _popularSection(),
          const SizedBox(height: 24),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: Colors.teal,
        elevation: isDarkMode ? 0 : 4,
        child: const Icon(Icons.add_rounded, color: Colors.white, size: 28),
      ),
    );
  }

  Widget _welcomeSection() {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20, top: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '${widget.settingsProvider.translate('welcome_greeting')}, ${widget.settingsProvider.translate(profile[0].name!)} 👋',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: isDarkMode ? Colors.white : Colors.black,
              letterSpacing: -0.5,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            widget.settingsProvider.translate('welcome_subtitle'),
            style: TextStyle(
              fontSize: 16,
              color: isDarkMode ? Colors.grey[400] : Colors.grey[600],
            ),
          ),
        ],
      ),
    );
  }

  Widget _searchField() {
    return Container(
      margin: const EdgeInsets.only(left: 20, right: 20, top: 20),
      decoration: BoxDecoration(
        color: isDarkMode ? const Color(0xFF1E1E1E) : Colors.white,
        borderRadius: BorderRadius.circular(50),
        border: Border.all(
          color: isDarkMode ? Colors.grey[800]! : Colors.grey[200]!,
          width: 1,
        ),
      ),
      child: TextField(
        style: TextStyle(color: isDarkMode ? Colors.white : Colors.black),
        decoration: InputDecoration(
          hintText: widget.settingsProvider.translate('search_hint'),
          hintStyle: TextStyle(
            color: isDarkMode ? Colors.grey[600] : Colors.grey[400],
            fontSize: 15,
          ),
          filled: true,
          fillColor: isDarkMode ? const Color(0xFF1E1E1E) : Colors.white,
          contentPadding: const EdgeInsets.symmetric(horizontal: 25, vertical: 12),
          prefixIcon: Padding(
            padding: const EdgeInsets.only(left: 20, right: 12),
            child: SvgPicture.asset(
              'assets/icons/search.svg',
              colorFilter: ColorFilter.mode(
                isDarkMode ? Colors.grey[500]! : Colors.grey[400]!,
                BlendMode.srcIn,
              ),
              width: 18,
            ),
          ),
          suffixIcon: SizedBox(
            width: 70,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  height: 20,
                  width: 1,
                  color: isDarkMode ? Colors.grey[800] : Colors.grey[200],
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 12, right: 20),
                  child: SvgPicture.asset(
                    'assets/icons/sort-numeric-down.svg',
                    colorFilter: ColorFilter.mode(
                      isDarkMode ? Colors.teal[400]! : Colors.teal,
                      BlendMode.srcIn,
                    ),
                    width: 18,
                  ),
                ),
              ],
            ),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(50),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }

  Column _catagorySection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                widget.settingsProvider.translate('categories'),
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: isDarkMode ? Colors.white : Colors.black,
                ),
              ),
              Text(
                widget.settingsProvider.translate('see_all'),
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.teal,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        SizedBox(
          height: 110,
          child: ListView.separated(
            itemCount: catagoryList.length,
            scrollDirection: Axis.horizontal,
            separatorBuilder: (context, index) => const SizedBox(width: 24),
            padding: const EdgeInsets.symmetric(horizontal: 20),
            itemBuilder: (context, index) {
              return Column(
                children: [
                  SizedBox(
                    height: 70,
                    width: 70,
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Image.asset(
                          catagoryList[index].iconPath!,
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    widget.settingsProvider.translate(
                      catagoryList[index].catagoryName!,
                    ),
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: isDarkMode ? Colors.grey[300] : Colors.grey[700],
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ],
    );
  }

  Column _deitSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                widget.settingsProvider.translate('diets'),
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: isDarkMode ? Colors.white : Colors.black,
                ),
              ),
              Text(
                widget.settingsProvider.translate('see_all'),
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.teal,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        SizedBox(
          height: 265,
          child: ListView.separated(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
            scrollDirection: Axis.horizontal,
            clipBehavior: Clip.none,
            itemBuilder: (context, index) {
              final isSelected = dietList[index].viewIsSelected;
              return Container(
                width: 210,
                decoration: BoxDecoration(
                  color: isDarkMode ? const Color(0xFF1E1E1E) : Colors.white,
                  borderRadius: BorderRadius.circular(24),
                  boxShadow: isDarkMode ? [] : [
                    BoxShadow(
                      color: Colors.teal.withValues(alpha: 0.08),
                      blurRadius: 20,
                      offset: const Offset(0, 10),
                    ),
                  ],
                ),
                child: Stack(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Center(
                            child: Image.asset(
                              dietList[index].iconPath,
                              height: 80,
                              width: 80,
                              fit: BoxFit.contain,
                            ),
                          ),
                          const SizedBox(height: 12),
                          Text(
                            widget.settingsProvider.translate(dietList[index].name),
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: isDarkMode ? Colors.white : Colors.black,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            widget.settingsProvider.translate(dietList[index].duration),
                            style: TextStyle(
                              fontSize: 12,
                              color: isDarkMode ? Colors.grey[500] : Colors.grey[600],
                            ),
                          ),
                          const Spacer(),
                          Text(
                            '\$${dietList[index].price}',
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.teal,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Positioned(
                      right: 0,
                      top: 0,
                      child: GestureDetector(
                        behavior: HitTestBehavior.opaque,
                        onTap: () {
                          widget.cartProvider.toggleFavorite(dietList[index]);
                          setState(() {});
                        },
                        child: Container(
                          height: 40,
                          width: 40,
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(20),
                              topRight: Radius.circular(24),
                            ),
                          ),
                          child: Icon(
                            dietList[index].isFavorite
                                ? Icons.favorite_rounded
                                : Icons.favorite_border_rounded,
                            color: dietList[index].isFavorite
                                ? Colors.redAccent
                                : Colors.grey[400],
                            size: 20,
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      right: 0,
                      bottom: 0,
                      child: GestureDetector(
                        behavior: HitTestBehavior.opaque,
                        onTap: () {
                          widget.cartProvider.toggleItem(dietList[index]);
                          setState(() {});
                        },
                        child: Container(
                          height: 50, // Slightly larger hit area
                          width: 50,  // Slightly larger hit area
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: !isSelected
                                  ? [Colors.teal, Colors.teal[700]!]
                                  : [
                                      isDarkMode
                                          ? Colors.grey[800]!
                                          : Colors.grey[200]!,
                                      isDarkMode
                                          ? Colors.grey[800]!
                                          : Colors.grey[200]!
                                    ],
                            ),
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(25),
                              bottomRight: Radius.circular(24),
                            ),
                            boxShadow: isDarkMode ? [] : [
                              BoxShadow(
                                color: !isSelected
                                    ? Colors.teal.withValues(alpha: 0.3)
                                    : Colors.black.withValues(alpha: 0.05),
                                blurRadius: 10,
                                offset: const Offset(-2, -2),
                              ),
                            ],
                          ),
                          child: Icon(
                            isSelected ? Icons.horizontal_rule_rounded : Icons.add_rounded,
                            color: !isSelected ? Colors.white : Colors.grey[600],
                            size: 26, // Slightly larger icon
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
            separatorBuilder: (context, index) => const SizedBox(width: 16),
            itemCount: dietList.length,
          ),
        ),
      ],
    );
  }

  Column _popularSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                widget.settingsProvider.translate('popular'),
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: isDarkMode ? Colors.white : Colors.black,
                ),
              ),
              Text(
                widget.settingsProvider.translate('see_all'),
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.teal,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        ListView.separated(
          physics: const NeverScrollableScrollPhysics(),
          separatorBuilder: (context, index) => const SizedBox(height: 16),
          padding: const EdgeInsets.symmetric(horizontal: 20),
          shrinkWrap: true,
          itemCount: popularList.length,
          itemBuilder: (context, index) {
            return Container(
              height: 100,
              decoration: BoxDecoration(
                color: Colors.transparent,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Row(
                  children: [
                    Image.asset(
                      popularList[index].iconPath,
                      height: 60,
                      width: 60,
                      fit: BoxFit.contain,
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.settingsProvider.translate(
                              popularList[index].name,
                            ),
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: isDarkMode ? Colors.white : Colors.black,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            '${widget.settingsProvider.translate(popularList[index].duration)} | ${widget.settingsProvider.translate(popularList[index].calorie)} | \$${popularList[index].price}',
                            style: TextStyle(
                              fontSize: 13,
                              color: isDarkMode
                                  ? Colors.grey[500]
                                  : Colors.grey[600],
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Icon(
                      Icons.chevron_right_rounded,
                      color: Colors.teal,
                      size: 24,
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ],
    );
  }


  AppBar appBar() {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      scrolledUnderElevation: 0,
      title: Text(
        widget.settingsProvider.translate('home_title'),
        style: TextStyle(
          color: isDarkMode ? Colors.white : Colors.black,
          fontWeight: FontWeight.w900,
          fontSize: 20,
        ),
      ),
      leading: Padding(
        padding: const EdgeInsets.only(left: 16.0),
        child: Center(
          child: Container(
            width: 32,
            height: 32,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: Colors.teal.withValues(alpha: 0.3), width: 1.5),
            ),
            child: ClipOval(
              child: SvgPicture.asset(profile[0].avatarPath!, fit: BoxFit.cover),
            ),
          ),
        ),
      ),
      actions: [
        if (widget.settingsProvider.notificationsEnabled)
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: Stack(
              children: [
                IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.notifications_none_rounded,
                    color: isDarkMode ? Colors.white : Colors.black,
                    size: 22,
                  ),
                ),
                Positioned(
                  right: 12,
                  top: 12,
                  child: Container(
                    width: 6,
                    height: 6,
                    decoration: const BoxDecoration(
                      color: Colors.red,
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
              ],
            ),
          ),
        Padding(
          padding: const EdgeInsets.only(right: 16.0),
          child: IconButton(
            onPressed: () => widget.settingsProvider.setLanguage(
              widget.settingsProvider.language == 'English'
                  ? 'ភាសាខ្មែរ'
                  : 'English',
            ),
            icon: Icon(
              Icons.translate_rounded,
              color: isDarkMode ? Colors.white : Colors.black,
              size: 22,
            ),
          ),
        ),
      ],
      centerTitle: true,
    );
  }

}
