import 'package:flutter/material.dart';
import '../EducationModeScreen/EducationModeScreen.dart';
import '../HelpModeScreen/HelpModeScreen.dart';
import '../ParentChildMode/ParentChildModeScreen.dart';

class HomeScreen extends StatefulWidget {
  final int initialIndex; // 初期インデックスを受け取る
  const HomeScreen({super.key, this.initialIndex = 0});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.initialIndex; // 初期インデックスを設定
  }

  final List<Widget> _screens = [
    // ホーム画面
    const Center(
      child: Text(
        'ホーム',
        style: TextStyle(
          fontSize: 28,
          fontWeight: FontWeight.bold,
        ),
      ),
    ),
    // 各モード画面
    const EducationModeScreen(),
    const HelpModeScreen(),
    const ParentChildModeScreen(displayText: '星空を観察しよう!'),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return Scaffold(
      body: Stack(
        children: [
          // 現在の画面を表示
          Positioned.fill(
            child: Container(
              color: Colors.white,
              child: _screens[_selectedIndex],
            ),
          ),
          // 上部デコレーション
          if (_selectedIndex == 0) // ホームのときだけデコレーションを表示
            ...[
              Positioned(
                top: -50,
                left: -50,
                child: Container(
                  width: 200,
                  height: 200,
                  decoration: BoxDecoration(
                    color: Colors.blue[100],
                    shape: BoxShape.circle,
                  ),
                ),
              ),
              Positioned(
                top: 100,
                right: -30,
                child: Container(
                  width: 150,
                  height: 150,
                  decoration: BoxDecoration(
                    color: Colors.yellow[100],
                    shape: BoxShape.circle,
                  ),
                ),
              ),
              Positioned(
                top: screenSize.height * 0.15,
                left: 0,
                right: 0,
                child: Column(
                  children: [
                    Text(
                      'ぼうけんにでてみよう',
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey[800],
                        fontFamily: 'Comic Sans MS',
                      ),
                    ),
                  ],
                ),
              ),
            ],
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'ホーム',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.school),
            label: 'おべんきょう',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.volunteer_activism),
            label: 'おてつだい',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.family_restroom),
            label: 'おやこミッション',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.blueAccent,
        unselectedItemColor: Colors.grey,
        backgroundColor: const Color.fromARGB(255, 255, 255, 255),
        iconSize: 50.0, // アイコンサイズを指定
        onTap: _onItemTapped,
      ),
    );
  }
}