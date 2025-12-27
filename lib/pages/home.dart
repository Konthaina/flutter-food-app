import 'package:first_app/models/catagory_model.dart';
import 'package:first_app/models/diet_model.dart';
import 'package:first_app/models/popular_model.dart';
import 'package:first_app/models/profile_model.dart';
import 'package:first_app/pages/settings.dart';
import 'package:first_app/providers/settings_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HomePage extends StatefulWidget {
  final SettingsProvider settingsProvider;

  const HomePage({super.key, required this.settingsProvider});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<CatagoryModel> catagoryList = [];
  List<DietModel> dietList = [];
  List<PopularModel> popularList = [];
  List<ProfileModel> profile = [];

  bool get isDarkMode => widget.settingsProvider.isDarkMode;

  void _getCatagoryList() {
    catagoryList = CatagoryModel.getCatagoryList();
  }

  void _getDietList() {
    dietList = DietModel.getDietList();
  }

  void _getPopularList() {
    popularList = PopularModel.getPopularList();
  }

  void _getDefaultProfile() {
    profile = ProfileModel.getDefaultProfile();
  }

  void _getInitailInfo() {
    _getCatagoryList();
    _getDietList();
    _getPopularList();
    _getDefaultProfile();
  }

  @override
  void initState() {
    super.initState();
    _getInitailInfo();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(),
      drawer: _buildDrawer(),
      body: ListView(
        children: [
          _searchField(),
          _catagorySection(),
          const SizedBox(height: 16),
          _deitSection(),
          const SizedBox(height: 16),
          _popularSection(),
          _createBySection(),
        ],
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: _onFabPressed,
        backgroundColor: Colors.teal,
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }

  Column _createBySection() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 24.0),
          child: SizedBox(
            width: double.infinity,
            child: Column(
              children: [
                Text(
                  widget.settingsProvider.translate('created_by'),
                  style: TextStyle(
                    fontSize: 12,
                    color: isDarkMode ? Colors.grey[500] : Colors.grey[600],
                  ),
                  textAlign: TextAlign.center,
                ),
                Text(
                  widget.settingsProvider.translate('for_lessons'),
                  style: TextStyle(
                    fontSize: 10,
                    color: isDarkMode ? Colors.grey[600] : Colors.grey[400],
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
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
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
          child: Text(
            widget.settingsProvider.translate('popular'),
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w100,
              color: isDarkMode ? Colors.white : Colors.grey[800],
            ),
          ),
        ),
        SizedBox(height: 12),
        ListView.separated(
          physics: const NeverScrollableScrollPhysics(),
          separatorBuilder: (context, index) => SizedBox(height: 12),
          padding: const EdgeInsets.symmetric(horizontal: 16),
          shrinkWrap: true,
          itemCount: popularList.length,
          itemBuilder: (context, index) {
            return Container(
              height: 115,
              decoration: BoxDecoration(
                color: popularList[index].boxIsSelected
                    ? (isDarkMode
                        ? Colors.teal.withValues(alpha: 0.3)
                        : const Color(0xFFB2DFDB))
                    : Colors.transparent,
                borderRadius: BorderRadius.circular(16),
                boxShadow: popularList[index].boxIsSelected
                    ? [
                        BoxShadow(
                          color: isDarkMode
                              ? Colors.transparent
                              : Colors.teal.withValues(alpha: 0.2),
                          offset: Offset(0, 4),
                          spreadRadius: 0,
                          blurRadius: 40,
                        ),
                      ]
                    : [],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Image.asset(
                    popularList[index].iconPath,
                    height: 60,
                    width: 60,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.settingsProvider.translate(
                          popularList[index].name,
                        ),
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w800,
                          color: isDarkMode ? Colors.white : Colors.grey[800],
                        ),
                      ),
                      Text(
                        '${widget.settingsProvider.translate(popularList[index].duration)} | ${widget.settingsProvider.translate(popularList[index].calorie)}',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: isDarkMode
                              ? Colors.grey[400]
                              : Colors.grey[600],
                        ),
                      ),
                    ],
                  ),
                  GestureDetector(
                    onTap: () {},
                    child: SvgPicture.asset(
                      'assets/icons/box-arrow-in-up-right.svg',
                      width: 20,
                      height: 20,
                      fit: BoxFit.contain,
                      colorFilter: const ColorFilter.mode(
                        Colors.grey,
                        BlendMode.srcIn,
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ],
    );
  }

  Column _deitSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
          child: Text(
            widget.settingsProvider.translate('diets'),
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w100,
              color: isDarkMode ? Colors.white : Colors.black,
            ),
          ),
        ),
        SizedBox(
          height: 240,
          child: ListView.separated(
            itemBuilder: (context, index) {
              return Container(
                width: 210,
                decoration: BoxDecoration(
                  color: isDarkMode
                      ? (dietList[index].viewIsSelected
                          ? Colors.teal.withValues(alpha: 0.3)
                          : Colors.grey.withValues(alpha: 0.1))
                      : dietList[index].boxColor,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Image.asset(
                      dietList[index].iconPath,
                      height: 80,
                      width: 80,
                    ),
                    Text(
                      widget.settingsProvider.translate(dietList[index].name),
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w800,
                        color: isDarkMode ? Colors.grey[200] : Colors.grey[800],
                      ),
                    ),
                    Text(
                      '${widget.settingsProvider.translate(dietList[index].lavel)} | ${widget.settingsProvider.translate(dietList[index].duration)} | ${widget.settingsProvider.translate(dietList[index].calorie)}',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: isDarkMode ? Colors.grey[400] : Colors.grey[600],
                      ),
                    ),
                    Container(
                      height: 40,
                      width: 140,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            dietList[index].viewIsSelected
                                ? Colors.teal
                                : Colors.teal[100]!,
                            dietList[index].viewIsSelected
                                ? Colors.teal.shade700
                                : Colors.grey.withValues(
                                    alpha: isDarkMode ? 0.6 : 1.0,
                                  ),
                          ],
                        ),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Center(
                        child: Text(
                          widget.settingsProvider.translate('select'),
                          style: TextStyle(
                            color: dietList[index].viewIsSelected
                                ? Colors.white
                                : (isDarkMode
                                      ? Colors.grey[300]
                                      : Colors.grey[800]),
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
            separatorBuilder: (context, index) => SizedBox(width: 12),
            itemCount: dietList.length,
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16),
          ),
        ),
      ],
    );
  }

  Column _catagorySection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 0),
          child: Text(
            widget.settingsProvider.translate('categories'),
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w100,
              color: isDarkMode ? Colors.white : Colors.black,
            ),
          ),
        ),
        SizedBox(height: 12),
        SizedBox(
          height: 150,
          child: ListView.separated(
            itemCount: catagoryList.length,
            scrollDirection: Axis.horizontal,
            separatorBuilder: (context, index) => SizedBox(width: 12),
            padding: const EdgeInsets.symmetric(horizontal: 16),
            itemBuilder: (context, index) {
              return Container(
                width: 120,
                decoration: BoxDecoration(
                  color: isDarkMode
                      ? catagoryList[index].boxColor!.withValues(alpha: 0.3)
                      : catagoryList[index].boxColor,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      height: 80,
                      width: 80,
                      decoration: BoxDecoration(
                        color: isDarkMode
                            ? Colors.white.withValues(alpha: 0.9)
                            : Colors.white,
                        shape: BoxShape.circle,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Image.asset(catagoryList[index].iconPath!),
                      ),
                    ),
                    Text(
                      widget.settingsProvider.translate(
                        catagoryList[index].catagoryName!,
                      ),
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w800,
                        color: isDarkMode ? Colors.grey[200] : Colors.grey[800],
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  AppBar appBar() {
    return AppBar(
      backgroundColor: Colors.teal,
      title: Text(
        widget.settingsProvider.translate('home_title'),
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 24,
        ),
      ),
      leading: Builder(
        builder: (context) => GestureDetector(
          onTap: () => Scaffold.of(context).openDrawer(),
          child: Container(
            alignment: Alignment.center,
            margin: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Color(0xFF00897B),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(Icons.menu_rounded, color: Colors.white, size: 24),
          ),
        ),
      ),
      actions: [
        GestureDetector(
          onTap: _onTap,
          child: Container(
            alignment: Alignment.center,
            width: 37,
            margin: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Color(0xFF00897B),
              borderRadius: BorderRadius.circular(10),
            ),
            child: SvgPicture.asset(
              'assets/icons/three-dots.svg',
              colorFilter: const ColorFilter.mode(
                Colors.white,
                BlendMode.srcIn,
              ),
              width: 20,
              height: 20,
            ),
          ),
        ),
      ],
      centerTitle: true,
    );
  }

  Widget _buildDrawer() {
    return Drawer(
      backgroundColor: isDarkMode ? Color(0xFF1E1E1E) : Colors.white,
      child: Column(
        children: [
          // Profile Header Section
          Container(
            width: double.infinity,
            padding: const EdgeInsets.only(
              top: 50,
              bottom: 24,
              left: 20,
              right: 20,
            ),
            decoration: BoxDecoration(color: Colors.teal),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Avatar
                Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white,
                    border: Border.all(color: Colors.white, width: 3),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(
                          alpha: isDarkMode ? 0.5 : 0.2,
                        ),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: ClipOval(
                    child: SvgPicture.asset(
                      profile[0].avatarPath!,
                      width: 80,
                      height: 80,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                // Name
                Text(
                  widget.settingsProvider.translate(profile[0].name!),
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                // Email
                Text(
                  profile[0].email!,
                  style: TextStyle(
                    color: Colors.white.withValues(alpha: 0.9),
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
          // Menu Items
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(vertical: 8),
              children: [
                _buildDrawerItem(
                  icon: Icons.home_rounded,
                  title: widget.settingsProvider.translate('home_title'),
                  isSelected: true,
                  onTap: () => Navigator.pop(context),
                ),
                _buildDrawerItem(
                  icon: Icons.favorite_rounded,
                  title: widget.settingsProvider.translate('favorites'),
                  onTap: () => Navigator.pop(context),
                ),
                _buildDrawerItem(
                  icon: Icons.restaurant_menu_rounded,
                  title: widget.settingsProvider.translate('recipes'),
                  onTap: () => Navigator.pop(context),
                ),
                _buildDrawerItem(
                  icon: Icons.history_rounded,
                  title: widget.settingsProvider.translate('history'),
                  onTap: () => Navigator.pop(context),
                ),
                const Divider(height: 32, indent: 16, endIndent: 16),
                _buildDrawerItem(
                  icon: Icons.person_rounded,
                  title: widget.settingsProvider.translate('profile'),
                  onTap: () => Navigator.pop(context),
                ),
                _buildDrawerItem(
                  icon: Icons.settings_rounded,
                  title: widget.settingsProvider.translate('settings'),
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SettingsPage(
                          settingsProvider: widget.settingsProvider,
                        ),
                      ),
                    );
                  },
                ),
                _buildDrawerItem(
                  icon: Icons.help_outline_rounded,
                  title: widget.settingsProvider.translate('help'),
                  onTap: () => Navigator.pop(context),
                ),
              ],
            ),
          ),
          // Logout Button
          Container(
            padding: const EdgeInsets.all(16),
            child: ListTile(
              leading: Icon(Icons.logout_rounded, color: Colors.red[400]),
              title: Text(
                widget.settingsProvider.translate('logout'),
                style: TextStyle(
                  color: Colors.red[400],
                  fontWeight: FontWeight.w600,
                ),
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              onTap: () {
                Navigator.pop(context);
                // Add logout logic here
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDrawerItem({
    required IconData icon,
    required String title,
    bool isSelected = false,
    required VoidCallback onTap,
  }) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 2),
      decoration: BoxDecoration(
        color: isSelected
            ? Colors.teal.withValues(alpha: 0.1)
            : Colors.transparent,
        borderRadius: BorderRadius.circular(12),
      ),
      child: ListTile(
        leading: Icon(
          icon,
          color: isSelected
              ? Colors.teal
              : (isDarkMode ? Colors.grey[400] : Colors.grey[700]),
        ),
        title: Text(
          title,
          style: TextStyle(
            color: isSelected
                ? Colors.teal
                : (isDarkMode ? Colors.grey[200] : Colors.grey[800]),
            fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
          ),
        ),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        onTap: onTap,
      ),
    );
  }

  void _onTap() {
    showModalBottomSheet(
      backgroundColor: isDarkMode ? Color(0xFF1E1E1E) : Colors.white,
      context: context,
      elevation: 10,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (_) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(height: 10),
            Container(
              width: 52, // size (width)
              height: 5, // size (height)
              decoration: BoxDecoration(
                color: isDarkMode
                    ? Colors.grey[700]
                    : Colors.grey[300], // ✅ color
                borderRadius: BorderRadius.circular(99),
              ),
            ),
            ListTile(
              iconColor: Colors.teal,
              leading: const Icon(Icons.person),
              title: Text(
                widget.settingsProvider.translate('profile'),
                style: const TextStyle(
                  color: Colors.teal,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              onTap: () => Navigator.pop(context),
            ),
            ListTile(
              iconColor: Colors.teal,
              leading: const Icon(Icons.settings),
              title: Text(
                widget.settingsProvider.translate('settings'),
                style: const TextStyle(
                  color: Colors.teal,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              onTap: () => Navigator.pop(context),
            ),
            ListTile(
              iconColor: Colors.red[300],
              leading: const Icon(Icons.logout),
              title: Text(
                widget.settingsProvider.translate('logout'),
                style: TextStyle(
                  color: Colors.red[300]!,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              onTap: () => Navigator.pop(context),
            ),
          ],
        ),
      ),
    );
  }

  Widget _searchField() {
    return Container(
      margin: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        boxShadow: isDarkMode
            ? []
            : [
                BoxShadow(
                  color: Colors.grey.withValues(alpha: 0.2),
                  spreadRadius: 0,
                  blurRadius: 40,
                ),
              ],
      ),
      child: TextField(
        style: TextStyle(color: isDarkMode ? Colors.white : Colors.black),
        decoration: InputDecoration(
          hintText: widget.settingsProvider.translate('search_hint'),
          hintStyle: TextStyle(
            color: isDarkMode ? Colors.grey[600] : Colors.grey[500],
          ),
          filled: true,
          fillColor: isDarkMode ? Color(0xFF1E1E1E) : Colors.grey[50],
          prefixIcon: Padding(
            padding: const EdgeInsets.all(12.0),
            child: SvgPicture.asset(
              'assets/icons/search.svg',
              width: 20,
              height: 20,
              fit: BoxFit.contain,
              colorFilter: ColorFilter.mode(
                isDarkMode ? Colors.grey[400]! : Colors.grey,
                BlendMode.srcIn,
              ),
            ),
          ),
          suffixIcon: Padding(
            padding: const EdgeInsets.all(12.0),
            child: SvgPicture.asset(
              'assets/icons/sort-numeric-down.svg',
              width: 20,
              height: 20,
              fit: BoxFit.contain,
              colorFilter: ColorFilter.mode(
                isDarkMode ? Colors.grey[400]! : Colors.grey,
                BlendMode.srcIn,
              ),
            ),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }

  Future<void> _onFabPressed() async {
    final overlay = Overlay.of(context).context.findRenderObject() as RenderBox;
    final value = await showMenu<String>(
      context: context,
      color: isDarkMode ? Color(0xFF1E1E1E) : Colors.white,
      elevation: isDarkMode ? 0 : 12,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(14),
        side: isDarkMode
            ? BorderSide(color: Colors.grey[800]!, width: 1)
            : BorderSide.none,
      ),
      position: RelativeRect.fromLTRB(
        overlay.size.width - 220, // x
        overlay.size.height - 270, // y (near FAB)
        16,
        100,
      ),
      items: [
        PopupMenuItem<String>(
          value: 'add_category',
          child: Row(
            children: [
              Icon(Icons.category, color: Colors.teal),
              SizedBox(width: 10),
              Text(
                widget.settingsProvider.translate('add_category'),
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: isDarkMode ? Colors.white : Colors.black,
                ),
              ),
            ],
          ),
        ),
        PopupMenuItem<String>(
          value: 'add_diet',
          child: Row(
            children: [
              Icon(Icons.restaurant_menu, color: Colors.teal),
              SizedBox(width: 10),
              Text(
                widget.settingsProvider.translate('add_diet'),
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: isDarkMode ? Colors.white : Colors.black,
                ),
              ),
            ],
          ),
        ),
        PopupMenuItem<String>(
          value: 'add_popular',
          child: Row(
            children: [
              Icon(Icons.star, color: Colors.teal),
              SizedBox(width: 10),
              Text(
                widget.settingsProvider.translate('add_popular'),
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: isDarkMode ? Colors.white : Colors.black,
                ),
              ),
            ],
          ),
        ),
      ],
    );

    if (value == 'add_category') {
    } else if (value == 'add_diet') {
    } else if (value == 'logout') {}
  }
}
