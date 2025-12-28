import 'package:flutter/material.dart';
import 'package:first_app/providers/settings_provider.dart';
import 'package:first_app/models/profile_model.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flag/flag.dart';

class SettingsPage extends StatefulWidget {
  final SettingsProvider settingsProvider;

  const SettingsPage({super.key, required this.settingsProvider});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  final List<ProfileModel> profile = ProfileModel.getDefaultProfile();

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

  bool get isDarkMode => widget.settingsProvider.isDarkMode;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        scrolledUnderElevation: 0,
        title: Text(
          widget.settingsProvider.translate('settings'),
          style: TextStyle(
            color: isDarkMode ? Colors.white : Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        leading: Navigator.canPop(context)
            ? IconButton(
                icon: Icon(Icons.arrow_back_ios_new_rounded,
                    color: isDarkMode ? Colors.white : Colors.black),
                onPressed: () => Navigator.pop(context),
              )
            : null,
      ),
      body: ListView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        children: [
          _profileSection(),
          const SizedBox(height: 24),
          _sectionHeader(widget.settingsProvider.translate('appearance')),
          _settingsGroup([
            _switchTile(
              icon: Icons.dark_mode_rounded,
              iconColor: Colors.blue,
              title: widget.settingsProvider.translate('dark_mode'),
              value: widget.settingsProvider.isDarkMode,
              onChanged: (val) => widget.settingsProvider.setDarkMode(val),
            ),
            _actionTile(
              icon: Icons.translate_rounded,
              iconColor: Colors.orange,
              title: widget.settingsProvider.translate('language'),
              trailing: widget.settingsProvider.language,
              onTap: () => _showLanguageDialog(),
            ),
          ]),
          const SizedBox(height: 24),
          _sectionHeader(widget.settingsProvider.translate('notifications')),
          _settingsGroup([
            _switchTile(
              icon: Icons.notifications_active_rounded,
              iconColor: Colors.redAccent,
              title: widget.settingsProvider.translate('notifications'),
              value: widget.settingsProvider.notificationsEnabled,
              onChanged: (val) => widget.settingsProvider.setNotifications(val),
            ),
          ]),
          const SizedBox(height: 24),
          _sectionHeader(widget.settingsProvider.translate('general')),
          _settingsGroup([
            _actionTile(
              icon: Icons.info_rounded,
              iconColor: Colors.teal,
              title: widget.settingsProvider.translate('about_app'),
              onTap: () => _showAboutDialog(),
            ),
            _actionTile(
              icon: Icons.privacy_tip_rounded,
              iconColor: Colors.green,
              title: widget.settingsProvider.translate('privacy_policy'),
              onTap: () => _showSnackBar('privacy_unavailable'),
            ),
            _actionTile(
              icon: Icons.description_rounded,
              iconColor: Colors.grey,
              title: widget.settingsProvider.translate('terms'),
              onTap: () => _showSnackBar('terms_unavailable'),
            ),
          ]),
          const SizedBox(height: 24),
          _settingsGroup([
            _actionTile(
              icon: Icons.logout_rounded,
              iconColor: Colors.red,
              title: widget.settingsProvider.translate('logout'),
              textColor: Colors.red,
              onTap: () => _showLogoutDialog(),
              showChevron: false,
            ),
          ]),
          const SizedBox(height: 32),
          Center(
            child: Column(
              children: [
                Text(
                  widget.settingsProvider.translate('created_by'),
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: isDarkMode ? Colors.grey[500] : Colors.grey[600],
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  widget.settingsProvider.translate('for_lessons'),
                  style: TextStyle(
                    fontSize: 10,
                    color: isDarkMode ? Colors.grey[600] : Colors.grey[400],
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  'v1.0.0',
                  style: TextStyle(
                    fontSize: 10,
                    color: isDarkMode ? Colors.grey[800] : Colors.grey[500],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 40),
        ],
      ),
    );
  }

  Widget _profileSection() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: isDarkMode ? const Color(0xFF1E1E1E).withValues(alpha: 0.5) : Colors.teal.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(24),
      ),
      child: Row(
        children: [
          Container(
            width: 70,
            height: 70,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: Colors.teal.withValues(alpha: 0.2), width: 2),
            ),
            child: ClipOval(
              child: SvgPicture.asset(profile[0].avatarPath!, fit: BoxFit.cover),
            ),
          ),
          const SizedBox(width: 20),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.settingsProvider.translate(profile[0].name!),
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: isDarkMode ? Colors.white : Colors.black,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  profile[0].email!,
                  style: TextStyle(
                    fontSize: 14,
                    color: isDarkMode ? Colors.grey[400] : Colors.grey[600],
                  ),
                ),
                const SizedBox(height: 8),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.teal.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    widget.settingsProvider.translate('edit_profile'),
                    style: const TextStyle(
                      color: Colors.teal,
                      fontSize: 11,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _sectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.only(left: 4, bottom: 10),
      child: Text(
        title.toUpperCase(),
        style: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.bold,
          color: isDarkMode ? Colors.grey[500] : Colors.grey[600],
          letterSpacing: 1.2,
        ),
      ),
    );
  }

  Widget _settingsGroup(List<Widget> children) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        children: children,
      ),
    );
  }

  Widget _switchTile({
    required IconData icon,
    required Color iconColor,
    required String title,
    required bool value,
    required ValueChanged<bool> onChanged,
  }) {
    return ListTile(
      leading: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: iconColor.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Icon(icon, color: iconColor, size: 22),
      ),
      title: Text(
        title,
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          color: isDarkMode ? Colors.white : Colors.black,
        ),
      ),
      trailing: Switch.adaptive(
        value: value,
        onChanged: onChanged,
        activeThumbColor: Colors.teal,
      ),
    );
  }

  Widget _actionTile({
    required IconData icon,
    required Color iconColor,
    required String title,
    String? trailing,
    required VoidCallback onTap,
    Color? textColor,
    bool showChevron = true,
  }) {
    return ListTile(
      onTap: onTap,
      leading: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: iconColor.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Icon(icon, color: iconColor, size: 22),
      ),
      title: Text(
        title,
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          color: textColor ?? (isDarkMode ? Colors.white : Colors.black),
        ),
      ),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (trailing != null)
            Text(
              trailing,
              style: TextStyle(color: Colors.grey[500], fontSize: 14),
            ),
          if (showChevron)
            Icon(Icons.chevron_right_rounded, color: Colors.grey[400]),
        ],
      ),
    );
  }

  void _showLanguageDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        title: Center(
          child: Text(widget.settingsProvider.translate('choose_language')),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _languageOption('ភាសាខ្មែរ', FlagsCode.KH),
            const SizedBox(height: 12),
            _languageOption('English', FlagsCode.GB),
          ],
        ),
      ),
    );
  }

  Widget _languageOption(String lang, FlagsCode flag) {
    bool isSelected = widget.settingsProvider.language == lang;
    return InkWell(
      onTap: () {
        widget.settingsProvider.setLanguage(lang);
        Navigator.pop(context);
        _showSnackBar('language_changed');
      },
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: isSelected ? Colors.teal.withValues(alpha: 0.1) : Colors.transparent,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          children: [
            Flag.fromCode(
              flag,
              height: 24,
              width: 32,
              fit: BoxFit.cover,
              borderRadius: 4,
            ),
            const SizedBox(width: 16),
            Text(
              lang,
              style: TextStyle(
                fontSize: 16,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                color: isDarkMode ? Colors.white : Colors.black,
              ),
            ),
            const Spacer(),
            if (isSelected) const Icon(Icons.check_circle, color: Colors.teal),
          ],
        ),
      ),
    );
  }

  void _showAboutDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.teal.withValues(alpha: 0.1),
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.restaurant_menu_rounded, color: Colors.teal, size: 40),
            ),
            const SizedBox(height: 20),
            const Text('Food App', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
            const SizedBox(height: 12),
            Text(
              widget.settingsProvider.translate('about_description'),
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.grey[600]),
            ),
            const SizedBox(height: 24),
            Text(widget.settingsProvider.translate('created_by_name')),
            const SizedBox(height: 8),
            Text('${widget.settingsProvider.translate('version')} 1.0.0'),
            const SizedBox(height: 24),
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text(widget.settingsProvider.translate('close')),
            ),
          ],
        ),
      ),
    );
  }

  void _showLogoutDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        title: Center(child: Text(widget.settingsProvider.translate('logout'))),
        content: Text(widget.settingsProvider.translate('confirm_logout')),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(widget.settingsProvider.translate('cancel')),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              _showSnackBar('logged_out');
            },
            child: const Text('Logout', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }

  void _showSnackBar(String key) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(widget.settingsProvider.translate(key)),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        backgroundColor: Colors.teal,
      ),
    );
  }
}
