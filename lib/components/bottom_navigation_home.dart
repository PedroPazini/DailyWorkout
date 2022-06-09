import 'package:flutter/material.dart';

class BottomNavigationHome extends StatelessWidget {
  const BottomNavigationHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          decoration: const BoxDecoration(
            border: Border(top: BorderSide(color: Color(0xFF2D343C))),
            color: Colors.white,
          ),
          height: 57,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                "images/halteres_40.png",
              ),
              GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, "/calendar");
                },
                child: Image.asset(
                  "images/calendar_35.png",
                  color: Colors.black.withOpacity(0.25),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
