import 'package:flutter/material.dart';
import 'package:first_app/providers/settings_provider.dart';

class SettingsPage extends StatefulWidget {
  final SettingsProvider settingsProvider;

  const SettingsPage({super.key, required this.settingsProvider});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
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
    setState(() {});
  }

  bool get isDarkMode => widget.settingsProvider.isDarkMode;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _sectionTitle(widget.settingsProvider.translate('appearance')),
          _settingsCard([
            _switchTile(
              icon: Icons.dark_mode_rounded,
              title: widget.settingsProvider.translate('dark_mode'),
              subtitle: widget.settingsProvider.translate('dark_mode_subtitle'),
              value: widget.settingsProvider.isDarkMode,
              onChanged: (value) {
                widget.settingsProvider.setDarkMode(value);
              },
            ),
            _divider(),
            _navigationTile(
              icon: Icons.language_rounded,
              title: widget.settingsProvider.translate('language'),
              subtitle: widget.settingsProvider.language,
              onTap: () => _showLanguageDialog(),
            ),
          ]),
          const SizedBox(height: 24),
          _sectionTitle(widget.settingsProvider.translate('notifications')),
          _settingsCard([
            _switchTile(
              icon: Icons.notifications_rounded,
              title: widget.settingsProvider.translate('notifications'),
              subtitle: widget.settingsProvider.translate(
                'notifications_subtitle',
              ),
              value: widget.settingsProvider.notificationsEnabled,
              onChanged: (value) {
                widget.settingsProvider.setNotifications(value);
              },
            ),
          ]),
          const SizedBox(height: 24),
          _sectionTitle(widget.settingsProvider.translate('general')),
          _settingsCard([
            _navigationTile(
              icon: Icons.info_outline_rounded,
              title: widget.settingsProvider.translate('about_app'),
              subtitle: widget.settingsProvider.translate('about_subtitle'),
              onTap: () => _showAboutDialog(),
            ),
            _divider(),
            _navigationTile(
              icon: Icons.privacy_tip_outlined,
              title: widget.settingsProvider.translate('privacy_policy'),
              subtitle: widget.settingsProvider.translate('privacy_subtitle'),
              onTap: () => _showSnackBar(
                widget.settingsProvider.translate('privacy_unavailable'),
              ),
            ),
            _divider(),
            _navigationTile(
              icon: Icons.description_outlined,
              title: widget.settingsProvider.translate('terms'),
              subtitle: widget.settingsProvider.translate('terms_subtitle'),
              onTap: () => _showSnackBar(
                widget.settingsProvider.translate('terms_unavailable'),
              ),
            ),
          ]),
          const SizedBox(height: 24),
          _sectionTitle(widget.settingsProvider.translate('account')),
          _settingsCard([
            _navigationTile(
              icon: Icons.logout_rounded,
              title: widget.settingsProvider.translate('logout'),
              subtitle: widget.settingsProvider.translate('logout_subtitle'),
              onTap: () => _showLogoutDialog(),
              iconColor: Colors.red[400],
              textColor: Colors.red[400],
            ),
          ]),
          const SizedBox(height: 32),
          _versionInfo(),
        ],
      ),
    );
  }

  AppBar _appBar() {
    return AppBar(
      backgroundColor: Colors.teal,
      title: Text(
        widget.settingsProvider.translate('settings'),
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 24,
        ),
      ),
      leading: GestureDetector(
        onTap: () => Navigator.pop(context),
        child: Container(
          alignment: Alignment.center,
          margin: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: const Color(0xFF00897B),
            borderRadius: BorderRadius.circular(10),
          ),
          child: const Icon(
            Icons.arrow_back_rounded,
            color: Colors.white,
            size: 24,
          ),
        ),
      ),
      centerTitle: true,
    );
  }

  Widget _sectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(left: 4, bottom: 12),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          color: isDarkMode ? Colors.grey[400] : Colors.grey[700],
        ),
      ),
    );
  }

  Widget _settingsCard(List<Widget> children) {
    return Container(
      decoration: BoxDecoration(
        color: isDarkMode ? const Color(0xFF1E1E1E) : Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: isDarkMode
            ? []
            : [
                BoxShadow(
                  color: Colors.grey.withValues(alpha: 0.1),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
      ),
      child: Column(children: children),
    );
  }

  Widget _switchTile({
    required IconData icon,
    required String title,
    required String subtitle,
    required bool value,
    required ValueChanged<bool> onChanged,
  }) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      leading: Container(
        width: 44,
        height: 44,
        decoration: BoxDecoration(
          color: Colors.teal.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Icon(icon, color: Colors.teal, size: 24),
      ),
      title: Text(
        title,
        style: TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: 16,
          color: isDarkMode ? Colors.white : Colors.grey[800],
        ),
      ),
      subtitle: Text(
        subtitle,
        style: TextStyle(
          color: isDarkMode ? Colors.grey[500] : Colors.grey[600],
          fontSize: 13,
        ),
      ),
      trailing: Switch(
        value: value,
        onChanged: onChanged,
        activeThumbColor: Colors.teal,
      ),
    );
  }

  Widget _navigationTile({
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
    Color? iconColor,
    Color? textColor,
  }) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      leading: Container(
        width: 44,
        height: 44,
        decoration: BoxDecoration(
          color: (iconColor ?? Colors.teal).withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Icon(icon, color: iconColor ?? Colors.teal, size: 24),
      ),
      title: Text(
        title,
        style: TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: 16,
          color: textColor ?? (isDarkMode ? Colors.white : Colors.grey[800]),
        ),
      ),
      subtitle: Text(
        subtitle,
        style: TextStyle(
          color: isDarkMode ? Colors.grey[500] : Colors.grey[600],
          fontSize: 13,
        ),
      ),
      trailing: Icon(
        Icons.chevron_right_rounded,
        color: isDarkMode ? Colors.grey[600] : Colors.grey[400],
      ),
      onTap: onTap,
    );
  }

  Widget _divider() {
    return Divider(
      height: 1,
      indent: 76,
      endIndent: 16,
      color: isDarkMode ? Colors.grey[800] : Colors.grey[200],
    );
  }

  Widget _versionInfo() {
    return Center(
      child: Column(
        children: [
          Text(
            'Food App',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: isDarkMode ? Colors.grey[500] : Colors.grey[600],
            ),
          ),
          const SizedBox(height: 4),
          Text(
            '${widget.settingsProvider.translate('version')} 1.0.0',
            style: TextStyle(
              fontSize: 12,
              color: isDarkMode ? Colors.grey[600] : Colors.grey[400],
            ),
          ),
        ],
      ),
    );
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            const Icon(Icons.check_circle_outline_rounded, color: Colors.white),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                message,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
        backgroundColor: Colors.teal,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        margin: const EdgeInsets.all(16),
        elevation: 6,
        duration: const Duration(seconds: 2),
      ),
    );
  }

  void _showLanguageDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: isDarkMode ? const Color(0xFF1E1E1E) : Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        title: Center(
          child: Text(
            widget.settingsProvider.translate('choose_language'),
            style: TextStyle(
              color: isDarkMode ? Colors.white : Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 12,
          vertical: 16,
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _languageOption('ភាសាខ្មែរ'),
            const SizedBox(height: 8),
            _languageOption('English'),
          ],
        ),
      ),
    );
  }

  Widget _languageOption(String language) {
    final isSelected = widget.settingsProvider.language == language;
    return Container(
      decoration: BoxDecoration(
        color: isSelected
            ? Colors.teal.withValues(alpha: 0.1)
            : Colors.transparent,
        borderRadius: BorderRadius.circular(12),
        border: isSelected
            ? Border.all(color: Colors.teal.withValues(alpha: 0.5), width: 1)
            : Border.all(color: Colors.transparent),
      ),
      child: ListTile(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        title: Text(
          language,
          style: TextStyle(
            color: isDarkMode ? Colors.white : Colors.black,
            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
          ),
        ),
        trailing: isSelected
            ? Container(
                padding: const EdgeInsets.all(4),
                decoration: const BoxDecoration(
                  color: Colors.teal,
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.check, color: Colors.white, size: 16),
              )
            : null,
        onTap: () {
          widget.settingsProvider.setLanguage(language);
          Navigator.pop(context);
          _showSnackBar(widget.settingsProvider.translate('language_changed'));
        },
      ),
    );
  }

  void _showAboutDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: isDarkMode ? const Color(0xFF1E1E1E) : Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        title: Center(
          child: Column(
            children: [
              Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  color: Colors.teal.withValues(alpha: 0.1),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.restaurant_menu,
                  color: Colors.teal,
                  size: 28,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                'Food App',
                style: TextStyle(
                  color: isDarkMode ? Colors.white : Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
            ],
          ),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.settingsProvider.translate('about_description'),
              style: TextStyle(
                color: isDarkMode ? Colors.grey[400] : Colors.grey[700],
              ),
            ),
            const SizedBox(height: 16),
            Text(
              widget.settingsProvider.translate('created_by_name'),
              style: TextStyle(
                fontSize: 13,
                color: isDarkMode ? Colors.grey[500] : Colors.grey[600],
              ),
            ),
            Text(
              '${widget.settingsProvider.translate('version')}: 1.0.0',
              style: TextStyle(
                fontSize: 13,
                color: isDarkMode ? Colors.grey[500] : Colors.grey[600],
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              widget.settingsProvider.translate('close'),
              style: TextStyle(color: Colors.teal),
            ),
          ),
        ],
      ),
    );
  }

  void _showLogoutDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: isDarkMode ? const Color(0xFF1E1E1E) : Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        title: Center(
          child: Text(
            widget.settingsProvider.translate('logout'),
            style: TextStyle(
              color: isDarkMode ? Colors.white : Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
        ),
        content: Text(
          widget.settingsProvider.translate('confirm_logout'),
          textAlign: TextAlign.center,
          style: TextStyle(
            color: isDarkMode ? Colors.grey[400] : Colors.grey[700],
            fontSize: 16,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              widget.settingsProvider.translate('cancel'),
              style: TextStyle(
                color: isDarkMode ? Colors.grey[500] : Colors.grey[600],
              ),
            ),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              _showSnackBar(widget.settingsProvider.translate('logged_out'));
            },
            child: Text(
              widget.settingsProvider.translate('logout'),
              style: TextStyle(color: Colors.red[400]),
            ),
          ),
        ],
      ),
    );
  }
}
