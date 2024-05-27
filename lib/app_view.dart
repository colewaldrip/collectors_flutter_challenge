import 'package:flutter/material.dart';

import 'screens/camera/camera_view.dart';
import 'screens/collection/collection_view.dart';
import 'screens/orders/orders_view.dart';

import 'components/bottom_tab_button.dart';
import 'components/bottom_tab_fab.dart';

class AppView extends StatefulWidget {
  const AppView({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _AppViewState createState() => _AppViewState();
}

class _AppViewState extends State<AppView> {
  int _selectedIndex = 1;

  final List<Widget> _tabOptions = [
    const OrdersView(),
    const CollectionView(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _tabOptions.elementAt(_selectedIndex),
      bottomNavigationBar: BottomAppBar(
        height: 100,
        padding: const EdgeInsets.all(0),
        color: Colors.white,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            BottomTabButton(
              iconPath: 'assets/icons/orders_icon.svg',
              label: 'Orders',
              isActive: _selectedIndex == 0,
              onPressed: () => _onItemTapped(0),
              notificationCount: 2,
            ),
            BottomTabFab(
                iconPath: 'assets/icons/camera_icon.svg',
                onPressed: () {
                  _showCameraFullScreen(context);
                }),
            BottomTabButton(
              iconPath: 'assets/icons/collection_icon.svg',
              label: 'Collection',
              isActive: _selectedIndex == 1,
              onPressed: () => _onItemTapped(1),
            ),
          ],
        ),
      ),
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void _showCameraFullScreen(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.black,
      builder: (BuildContext context) {
        return SizedBox(
          height: MediaQuery.of(context).size.height,
          child: Stack(
            children: [
              Positioned(
                top: 50,
                right: 20,
                child: IconButton(
                  icon: const Icon(Icons.close, color: Colors.white, size: 30),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
