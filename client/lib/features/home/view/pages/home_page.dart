import 'package:client/core/providers/current_user_notifier.dart';
import 'package:client/core/theme/app_palette.dart';
import 'package:client/features/home/view/pages/library_page.dart';
import 'package:client/features/home/view/pages/search_page.dart';
import 'package:client/features/home/view/pages/songs_page.dart';
import 'package:client/features/home/view/widgets/music_slab.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  int selectedIndex = 0;
  final pages = const [
    SongsPage(),
    SearchPage(),
    LibraryPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          pages[selectedIndex],
          const Positioned(bottom: 0, child: MusicSlab())
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: selectedIndex,
        onTap: (value) {
          setState(() {
            selectedIndex = value;
          });
        },
        items: [
          BottomNavigationBarItem(
              icon: selectedIndex == 0
                  ? Image.asset('assets/images/home_filled.png')
                  : Image.asset('assets/images/home_unfilled.png'),
              backgroundColor: selectedIndex == 0
                  ? Pallete.whiteColor
                  : Pallete.inactiveBottomBarItemColor,
              label: 'Home'),
          BottomNavigationBarItem(
              icon: selectedIndex == 1
                  ? Image.asset('assets/images/search_filled.png')
                  : Image.asset('assets/images/search_unfilled.png'),
              backgroundColor: selectedIndex == 1
                  ? Pallete.whiteColor
                  : Pallete.inactiveBottomBarItemColor,
              label: 'Search'),
          BottomNavigationBarItem(
              icon: Image.asset('assets/images/library.png'),
              backgroundColor: selectedIndex == 2
                  ? Pallete.whiteColor
                  : Pallete.inactiveBottomBarItemColor,
              label: 'Library'),
        ],
      ),
    );
  }
}
