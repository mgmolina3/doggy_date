import 'package:flutter/material.dart';
import 'custom_colors.dart';

// custom drawer for the settings
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

// custome circle button with icon
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

// custom circle button with text (no icon)
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

// custom dropdown button with title
Row textDropdownButton(
    title, value, items, void Function(Object?) onChangedAction) {
  return Row(
    children: [
      Text(title),
      DropdownButton(
        value: value,
        items: mapItems(items),
        onChanged: onChangedAction,
      ),
    ],
  );
}

List<DropdownMenuItem<Object>>? mapItems(items) {
  List<DropdownMenuItem<Object>> list = [];
  for (var item in items) {
    DropdownMenuItem<Object> dropdownMenuItem =
        DropdownMenuItem(value: item, child: Text(item));
    list.add(dropdownMenuItem);
  }
  return list;
}
