import 'package:flutter/material.dart';
 
void main() {
  runApp(const MaterialApp(home: MyPage()));
}
 
class MyPage extends StatefulWidget {
  const MyPage({super.key});
 
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
