import 'package:flutter/material.dart';

class Navbar extends StatefulWidget {
  const Navbar({super.key});

  @override
  State<Navbar> createState() => _NavbarState();
}

class _NavbarState extends State<Navbar> {
  int selected = 0;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Image(image: NetworkImage('https://fakeimg.pl/40/')),
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(100)),
            boxShadow: [
              BoxShadow(
                color: Color(0x40AEAEAE),
                blurRadius: 8,
                offset: Offset(0, 8),
              ),
            ],
          ),
          child: Row(
            spacing: 4,
            children: [
              TextButton(
                style: TextButton.styleFrom(
                  padding: EdgeInsets.all(20),
                  backgroundColor:
                      (selected == 0) ? Color(0xFF0B74E7) : Colors.white,
                  foregroundColor:
                      (selected == 0) ? Colors.white : Colors.black,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(100)),
                  ),
                ),
                onPressed: () {
                  setState(() {
                    selected = 0;
                  });
                },
                child: Text(
                  "Dashboard",
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontFamily: "Inter",
                  ),
                ),
              ),
              TextButton(
                style: TextButton.styleFrom(
                  padding: EdgeInsets.all(20),
                  backgroundColor:
                      (selected == 1) ? Color(0xFF0B74E7) : Colors.white,
                  foregroundColor:
                      (selected == 1) ? Colors.white : Colors.black,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(100)),
                  ),
                ),
                onPressed: () {
                  setState(() {
                    selected = 1;
                  });
                },
                child: Text(
                  "Candidat",
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontFamily: "Inter",
                  ),
                ),
              ),
              TextButton(
                style: TextButton.styleFrom(
                  padding: EdgeInsets.all(20),
                  backgroundColor:
                      (selected == 2) ? Color(0xFF0B74E7) : Colors.white,
                  foregroundColor:
                      (selected == 2) ? Colors.white : Colors.black,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(100)),
                  ),
                ),
                onPressed: () {
                  setState(() {
                    selected = 2;
                  });
                },
                child: Text(
                  "Garants",
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontFamily: "Inter",
                  ),
                ),
              ),
            ],
          ),
        ),
        Row(
          children: [
            Image(image: NetworkImage('https://fakeimg.pl/40/')),
            Column(children: [Text("Jolan Cochet"), Text("Candidat")]),
            Icon(Icons.keyboard_arrow_down),
          ],
        ),
      ],
    );
  }
}
