import 'package:flutter/material.dart';
import 'package:logicon_demo/export.dart';

class customAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String appBarText;

  const customAppBar({required this.appBarText});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(appBarText),
      centerTitle: true,
      backgroundColor: colorRes.colorBlack,
      elevation: 0,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(70);
}
