import 'package:figure_ui_flutter/consts.dart';
import 'package:flutter/material.dart';

import 'package:figure_ui_flutter/presentation/views/views.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _pageIndex = 0;

  void _handlePressed(int index) {
    setState(() {
      _pageIndex = index;
    });
  }

  final List<Widget> viewRoutes = const [
    HomeView(),
    Text("data"),
    Text("data"),
    Text("data"),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _pageIndex,
        children: viewRoutes,
      ),
      bottomNavigationBar: CustomNavigationBar(
        pageIndex: _pageIndex,
        onPressed: _handlePressed,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: const FloatingActionButton(
          backgroundColor: Color(0xffa2a5a4),
          onPressed: null,
          child: Icon(
            Icons.photo_camera,
            size: 40.0,
          )),
    );
  }
}

class CustomNavigationBar extends StatelessWidget {
  final Function(int) onPressed;
  final int pageIndex;

  const CustomNavigationBar({
    super.key,
    required this.pageIndex,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
      ),
      child: BottomNavigationBar(
        currentIndex: pageIndex,
        onTap: onPressed,
        type: BottomNavigationBarType.fixed,
        backgroundColor: black,
        selectedFontSize: 14,
        unselectedFontSize: 14,
        selectedItemColor: white,
        unselectedItemColor: white,
        elevation: 0,
        showUnselectedLabels: true,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_max),
            label: 'Inicio',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.label_outline),
            label: 'Categorías',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.photo_sharp),
            label: 'Photo',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite_outline),
            label: 'Favoritos',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite_outline),
            label: 'zxc',
          ),
        ],
      ),
    );
  }
}
