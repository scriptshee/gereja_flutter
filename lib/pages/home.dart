// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gereja_flutter/pages/home/home_screen.dart';
import 'package:gereja_flutter/pages/home/setting_screen.dart';
import 'package:gereja_flutter/pages/main.dart';
import 'package:gereja_flutter/pages/notification/notificaton_screen.dart';
import 'package:gereja_flutter/services/auth_services.dart';
import 'package:gereja_flutter/utils/use_store.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final api = AuthServices();
  int _selectedIndex = 0;

  Future<void> logout() async {
    final resp = await api.logout(context);
    await Store.clear();
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => const MainPage(),
      ),
    );
  }

  static const List<Widget> _widgetOptions = <Widget>[
    HomeScreen(),
    NotificationScreen(),
    SettingScreen()
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Image(
          image: const AssetImage('assets/logo_gereja.png'),
          width: 40.sp,
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        actions: [
          IconButton(onPressed: () => logout(), icon: Icon(Icons.login))
        ],
      ),
      body: _widgetOptions.elementAt(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications),
            label: 'Notification',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.info),
            label: 'About',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber[800],
        onTap: _onItemTapped,
      ),
    );
  }
}
