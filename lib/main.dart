import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(const ThemeApp());
}

class ThemeApp extends StatefulWidget {
  const ThemeApp({super.key});

  @override
  State<ThemeApp> createState() => _ThemeAppState();
}

class _ThemeAppState extends State<ThemeApp> {
  static const _themePreferenceKey = 'isDarkMode';
  final SharedPreferencesAsync _preferences = SharedPreferencesAsync();
  ThemeMode _themeMode = ThemeMode.light;
  bool _isReady = false;

  @override
  void initState() {
    super.initState();
    _loadThemePreference();
  }

  Future<void> _loadThemePreference() async {
    final isDarkMode = await _preferences.getBool(_themePreferenceKey) ?? false;
    if (!mounted) return;
    setState(() {
      _themeMode = isDarkMode ? ThemeMode.dark : ThemeMode.light;
      _isReady = true;
    });
  }

  Future<void> _setDarkMode(bool isDarkMode) async {
    setState(() {
      _themeMode = isDarkMode ? ThemeMode.dark : ThemeMode.light;
    });
    await _preferences.setBool(_themePreferenceKey, isDarkMode);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'GitHub Lab',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
        useMaterial3: true,
      ),
      darkTheme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.indigo,
          brightness: Brightness.dark,
        ),
        useMaterial3: true,
      ),
      themeMode: _themeMode,
      home: _isReady
          ? MyPage(
              isDarkMode: _themeMode == ThemeMode.dark,
              onThemeChanged: _setDarkMode,
            )
          : const Scaffold(body: Center(child: CircularProgressIndicator())),
    );
  }
}

class MyPage extends StatefulWidget {
  const MyPage({super.key, required this.isDarkMode, required this.onThemeChanged});

  final bool isDarkMode;
  final ValueChanged<bool> onThemeChanged;

  @override
  State<MyPage> createState() => _MyPageState();
}

class _MyPageState extends State<MyPage> {
  String message = 'ยังไม่ได้กดปุ่ม';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('GitHub Lab')),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 420),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(message),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    message = 'กดปุ่มแล้ว!';
                  });
                },
                child: const Text('Hello againt'),
              ),
              SwitchListTile(
                title: const Text('Dark mode'),
                subtitle: Text(widget.isDarkMode ? 'เปิดใช้งาน' : 'ปิดใช้งาน'),
                secondary: Icon(
                  widget.isDarkMode ? Icons.dark_mode : Icons.light_mode,
                ),
                value: widget.isDarkMode,
                onChanged: widget.onThemeChanged,
              ),
              const SizedBox(height: 12),
              ElevatedButton.icon(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute<void>(
                      builder: (context) => const ProfilePage(),
                    ),
                  );
                },
                icon: const Icon(Icons.person),
                label: const Text('Profile'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          tooltip: 'ย้อนกลับ',
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text('Profile'),
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const CircleAvatar(
              radius: 44,
              child: Icon(Icons.person, size: 48),
            ),
            const SizedBox(height: 16),
            Text('My Profile', style: Theme.of(context).textTheme.headlineSmall),
            const SizedBox(height: 8),
            const Text('ข้อมูลโปรไฟล์ของคุณ'),
            const SizedBox(height: 24),
            OutlinedButton.icon(
              onPressed: () => Navigator.of(context).pop(),
              icon: const Icon(Icons.arrow_back),
              label: const Text('ย้อนกลับ'),
            ),
          ],
        ),
      ),
    );
  }
}
