import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:achiever/DALayer/ApiClient.dart';

class AchieverNavigationBar extends BottomNavigationBar {
  AchieverNavigationBar({
      @required int currentIndex, 
      @required String profileImagePath, 
      @required Function(int) onTap
    }) : super(
    currentIndex: currentIndex,
    onTap: onTap,
    type: BottomNavigationBarType.fixed,
    items: [
      BottomNavigationBarItem(
        icon: Image.asset('assets/navigation_icons/home_icon.png',
          width: 24.0, height: 25.0,),
        activeIcon: Image.asset('assets/navigation_icons/home_icon_active.png',
          width: 24, height: 25,),
        title: Container()
      ),
      BottomNavigationBarItem(
        icon: Image.asset('assets/navigation_icons/search_icon.png', width: 23.0, height: 23.0,),
        activeIcon: Image.asset('assets/navigation_icons/search_icon_active.png', width: 23, height: 23,),
        title: Container()
      ),
      BottomNavigationBarItem(
        icon: Image.asset('assets/navigation_icons/plus_icon.png', width: 31.0, height: 31.0,),
        title: Container()
      ),
      BottomNavigationBarItem(
        icon: Image.asset('assets/navigation_icons/notification_icon.png', width: 21.0, height: 23.0,),
        activeIcon: Image.asset('assets/navigation_icons/notification_icon_active.png', width: 21, height: 23,),
        title: Container()
      ),
      BottomNavigationBarItem(
        icon: _buildProfileImage(profileImagePath),
        activeIcon: Container(
          height: 32,
          width: 32,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(width: 2, color: Color.fromARGB(255, 51, 51, 51))
          ),
          child: Center(
            child: _buildProfileImage(profileImagePath),
          )
        ),
        title: Container()
      ),
    ],
  );

  static Widget _buildProfileImage(String profileImagePath) {
    return Container(
      height: 25.0,
      width: 25.0,
      child: new ClipRRect(
        borderRadius: BorderRadius.circular(50.0),
        child: CachedNetworkImage(imageUrl: '${ApiClient.staticUrl}/$profileImagePath',
          width: 25.0, height: 25.0,)
      ),
    );
  }
}