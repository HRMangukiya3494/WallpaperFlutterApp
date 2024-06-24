import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:wallpaper/controller/BottomNavigationController.dart';
import 'package:wallpaper/views/screen/CategoryPage.dart';
import 'package:wallpaper/views/screen/HomePage.dart';
import 'package:wallpaper/views/screen/LikePage.dart';
import 'package:wallpaper/views/screen/PrivacyPolicyPage.dart';
import 'package:wallpaper/views/screen/SearchPage.dart';

class BottomNavigationPage extends StatelessWidget {
  final BottomNavigationController homeController = Get.put(
    BottomNavigationController(),
  );

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Obx(
            () => _getPage(
          homeController.selectedIndex.value,
        ),
      ),
      extendBody: true,
      bottomNavigationBar: Container(
        height: h * 0.18,
        padding: EdgeInsets.all(
          h * 0.03,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(
            h * 0.02,
          ),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(
            h * 0.03,
          ),
          child: BottomNavigationBar(
            showSelectedLabels: false,
            showUnselectedLabels: false,
            type: BottomNavigationBarType.fixed,
            items: <BottomNavigationBarItem>[
              _buildBottomNavigationBarItem(
                icon: Icons.home,
                label: 'Home',
                index: 0,
              ),
              _buildBottomNavigationBarItem(
                icon: Icons.search,
                label: 'Search',
                index: 1,
              ),
              _buildBottomNavigationBarItem(
                icon: Icons.favorite_border,
                label: 'Favorites',
                index: 2,
              ),
            ],
            currentIndex: homeController.selectedIndex.value,
            selectedItemColor: Colors.black,
            backgroundColor: Colors.white.withOpacity(0.4),
            onTap: homeController.changeTab,
          ),
        ),
      ),
    );
  }

  Widget _getPage(int index) {
    switch (index) {
      case 0:
        return const HomePage();
      case 1:
        return SearchPage();
      case 2:
        return LikePage();
      default:
        return Container();
    }
  }

  BottomNavigationBarItem _buildBottomNavigationBarItem({
    required IconData icon,
    required String label,
    required int index,
  }) {
    return BottomNavigationBarItem(
      icon: Obx(() => _buildIcon(
        icon: icon,
        isSelected: homeController.selectedIndex.value == index,
        h: MediaQuery.of(Get.context!).size.height,
      )),
      label: label,
    );
  }

  Widget _buildIcon({
    required IconData icon,
    required bool isSelected,
    required double h,
  }) {
    return Center(
      child: Container(
        width: h * 0.06,
        height: h * 0.06,
        padding: EdgeInsets.all(
          h * 0.01,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(h * 0.16),
          color: isSelected ? Colors.grey[100] : Colors.transparent,
        ),
        child: Icon(
          icon,
          color: isSelected ? Colors.black : Colors.black,
          size: h * 0.04,
        ),
      ),
    );
  }
}
