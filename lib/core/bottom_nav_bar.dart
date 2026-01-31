import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hello_flutter/screens/history_screen.dart';
import 'package:hello_flutter/screens/home_screen.dart';


class BottomNavBar extends StatefulWidget {
  const BottomNavBar({super.key});

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {

  final List<Widget> appScreens = [
    const HomeScreen(),
    const HistoryScreen(),
    const Center(child: Text("Profile")),
  ];

  //Cambiar index desde la barra inferior

  int _selectedIndex = 0;

  void _onItemTapper(int index){
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body:Center(child: appScreens[_selectedIndex]),

      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapper,
        selectedItemColor: Colors.green,
        unselectedItemColor: const Color(0xFF526400),

        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.history), label: "History"),
          BottomNavigationBarItem(icon: Icon(Icons.account_circle), label: "Profile")
        ],
      ),
    );
  }
}
