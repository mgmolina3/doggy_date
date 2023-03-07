import 'package:flutter/material.dart';
import 'custom_colors.dart';

Drawer settingsDrawer = Drawer(
  backgroundColor: white,
  child: ListView(
    padding: EdgeInsets.zero,
    children: [
      DrawerHeader(
        decoration: BoxDecoration(color: homeBackground),
        child: Text(
          "Settings",
          style: TextStyle(
            color: iconDarkGray,
            fontSize: 30,
          ),
        ),
      ),
      ListTile(
        title: const Text(
          'View Profile',
          style: TextStyle(fontSize: 15),
        ),
        onTap: () {},
      ),
      Divider(thickness: 1, color: homeBackground),
      ListTile(
        title: const Text(
          'Edit Profile',
          style: TextStyle(fontSize: 15),
        ),
        onTap: () {},
      ),
      Divider(thickness: 1, color: homeBackground),
      ListTile(
        title: const Text(
          'Friends',
          style: TextStyle(fontSize: 15),
        ),
        onTap: () {},
      ),
      Divider(thickness: 1, color: homeBackground),
      ListTile(
        title: const Text(
          'About',
          style: TextStyle(fontSize: 15),
        ),
        onTap: () {},
      ),
    ],
  ),
);

Container circleButton(IconData icon, void Function() onPressedAction) =>
    Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: grayText,
            blurRadius: 10,
            spreadRadius: 1,
          ),
        ],
      ),
      child: ElevatedButton(
        onPressed: onPressedAction,
        style: ButtonStyle(
          shape: MaterialStateProperty.all(const CircleBorder()),
          padding: MaterialStateProperty.all(const EdgeInsets.all(20)),
          shadowColor: MaterialStateProperty.all(black),
          backgroundColor: MaterialStateProperty.all(homeBackground),
        ),
        child: Icon(
          icon,
          size: 30,
          color: grayText,
        ),
      ),
    );

Text circleButtonText(String text, double size,
        {Color color = const Color.fromARGB(255, 145, 145, 145)}) =>
    Text(
      text,
      style: TextStyle(
        color: color,
        fontSize: size,
        fontFamily: 'OpenSans',
        fontWeight: FontWeight.bold,
      ),
    );
