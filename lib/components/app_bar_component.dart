import 'package:flutter/material.dart';

//ignore: must_be_immutable
class AppBarComponent extends StatelessWidget implements PreferredSizeWidget {
  late String title;
  late int color;
  late double? barHeight;
  late double? fontSizes;
  late Image? image;

  AppBarComponent({required this.title, required this.color, this.barHeight, this.fontSizes, this.image});

  @override
  Widget build(BuildContext context) {
    return AppBar(

      backgroundColor: Color(color),
      elevation: 0,
      toolbarHeight: barHeight,
      centerTitle: true,
      title: Text(
        title,
        style: TextStyle(fontSize: fontSizes, fontWeight: FontWeight.bold),
      ),
      leading: image != null
          ? Image.asset(
              "images/logo_pequena_40.png",
            )
          : null,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
