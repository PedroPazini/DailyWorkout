import 'package:flutter/material.dart';

//ignore: must_be_immutable
class BottomNavigationCalendar extends StatelessWidget {
  const BottomNavigationCalendar({Key? key}) : super(key: key);

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
              GestureDetector(
                onTap: () {
                  Navigator.pushNamedAndRemoveUntil(context, "/home", (route) => false);
                },
                child: Image.asset(
                  "images/halteres_40.png",
                  color: Colors.black.withOpacity(0.25),
                ),
              ),
              Image.asset(
                "images/calendar_35.png",
              ),
            ],
          ),
        ),
      ],
    );
  }
}
