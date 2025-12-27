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

  void _getInitailInfo() {
    catagoryList = CatagoryModel.getCatagoryList();
    dietList = DietModel.getDietList();
    popularList = PopularModel.getPopularList();
    profile = ProfileModel.getDefaultProfile();
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
        elevation: 4,
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
                'មើលទាំងអស់',
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
                'មើលទាំងអស់',
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
          height: 250,
          child: ListView.separated(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              final isSelected = dietList[index].viewIsSelected;
              return Container(
                width: 210,
                decoration: BoxDecoration(
                  color: Colors.transparent,
                  borderRadius: BorderRadius.circular(24),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Image.asset(
                      dietList[index].iconPath,
                      height: 90,
                      width: 90,
                      fit: BoxFit.contain,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12.0),
                      child: Text(
                        widget.settingsProvider.translate(dietList[index].name),
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                          color: isDarkMode ? Colors.white : Colors.black,
                        ),
                      ),
                    ),
                    Text(
                      '${widget.settingsProvider.translate(dietList[index].lavel)} | ${widget.settingsProvider.translate(dietList[index].duration)} | ${widget.settingsProvider.translate(dietList[index].calorie)}',
                      style: TextStyle(
                        fontSize: 13,
                        color: isDarkMode ? Colors.grey[500] : Colors.grey[600],
                      ),
                    ),
                    Container(
                      height: 44,
                      width: 130,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: isSelected
                              ? [Colors.teal, Colors.teal[700]!]
                              : [Colors.grey[200]!, Colors.grey[200]!],
                        ),
                        borderRadius: BorderRadius.circular(22),
                      ),
                      child: Center(
                        child: Text(
                          widget.settingsProvider.translate('select'),
                          style: TextStyle(
                            color: isSelected ? Colors.white : Colors.grey[600],
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
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
                'មើលទាំងអស់',
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
                            '${widget.settingsProvider.translate(popularList[index].duration)} | ${widget.settingsProvider.translate(popularList[index].calorie)}',
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
      leading: Builder(
        builder: (context) => IconButton(
          onPressed: () => Scaffold.of(context).openDrawer(),
          icon: Icon(
            Icons.menu_rounded,
            color: isDarkMode ? Colors.white : Colors.black,
            size: 24,
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

  Widget _buildDrawer() {
    return Drawer(
      width: MediaQuery.of(context).size.width * 0.7,
      backgroundColor: isDarkMode ? const Color(0xFF1E1E1E) : Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.zero,
      ),
      child: Column(
        children: [
          // Premium Header with Gradient
          Container(
            width: double.infinity,
            padding: const EdgeInsets.only(top: 50, bottom: 20, left: 24, right: 24),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.teal, Colors.teal[700]!],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.white.withValues(alpha: 0.5), width: 2),
                  ),
                  child: ClipOval(
                    child: SvgPicture.asset(profile[0].avatarPath!, fit: BoxFit.cover),
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  widget.settingsProvider.translate(profile[0].name!),
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  profile[0].email!,
                  style: TextStyle(
                    color: Colors.white.withValues(alpha: 0.8),
                    fontSize: 13,
                  ),
                ),
              ],
            ),
          ),
          // Scrollable Menu Items
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
              children: [
                _buildDrawerItem(Icons.home_rounded, 'home_title', true, Colors.blue),
                _buildDrawerItem(Icons.favorite_rounded, 'favorites', false, Colors.redAccent),
                _buildDrawerItem(Icons.restaurant_menu_rounded, 'recipes', false, Colors.orange),
                _buildDrawerItem(Icons.history_rounded, 'history', false, Colors.purple),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  child: Divider(
                    color: isDarkMode ? Colors.grey[800] : Colors.grey[200],
                    height: 1,
                  ),
                ),
                _buildDrawerItem(Icons.settings_rounded, 'settings', false, Colors.teal, () {
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => SettingsPage(settingsProvider: widget.settingsProvider),
                    ),
                  );
                }),
                _buildDrawerItem(Icons.help_outline_rounded, 'help', false, Colors.grey),
              ],
            ),
          ),
          // Styled Logout Button at Footer
          Padding(
            padding: const EdgeInsets.all(16),
            child: InkWell(
              onTap: () => Navigator.pop(context),
              borderRadius: BorderRadius.circular(12),
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                decoration: BoxDecoration(
                  color: Colors.red.withValues(alpha: 0.08),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.logout_rounded, color: Colors.red, size: 20),
                    const SizedBox(width: 12),
                    Text(
                      widget.settingsProvider.translate('logout'),
                      style: const TextStyle(
                        color: Colors.red,
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDrawerItem(IconData icon, String key, bool isSelected, Color iconColor, [VoidCallback? onTap]) {
    return Container(
      margin: const EdgeInsets.only(bottom: 4),
      decoration: BoxDecoration(
        color: isSelected ? iconColor.withValues(alpha: 0.1) : Colors.transparent,
        borderRadius: BorderRadius.circular(12),
      ),
      child: ListTile(
        onTap: onTap ?? () => Navigator.pop(context),
        leading: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: isSelected ? iconColor.withValues(alpha: 0.2) : iconColor.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(icon, color: iconColor, size: 22),
        ),
        title: Text(
          widget.settingsProvider.translate(key),
          style: TextStyle(
            color: isSelected ? (isDarkMode ? Colors.white : Colors.black) : (isDarkMode ? Colors.grey[300] : Colors.grey[800]),
            fontWeight: isSelected ? FontWeight.bold : FontWeight.w600,
            fontSize: 15,
          ),
        ),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    );
  }
}
