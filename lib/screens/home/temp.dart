import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mycareteam/resources/constants/colors.dart';

class TempScreen extends StatefulWidget {
  const TempScreen({Key? key}) : super(key: key);

  @override
  State<TempScreen> createState() => _TempScreenState();
}

class _TempScreenState extends State<TempScreen>
    with SingleTickerProviderStateMixin {
  final _tabs = List.generate(10, (index) => 'Tab#${index + 1}');

  late final TabController _tabCont;
  @override
  void initState() {
    _tabCont = TabController(length: 10, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
          children: <Widget>[
    Expanded(
      child: Container(
        child: Center(
          child: Text(
            'First widget',
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ),
        color: Colors.blue,
        height: 100,
        width: 200,
      ),
    ),
    Expanded(
      child: Container(
        child: Center(
          child: Text(
            'Second widget',
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ),
        color: Colors.amber,
        width: 200,
      ),
    ),
    Container(
      child: Center(
        child: Text(
          'Third widget',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      color: Colors.orange,
      height: 100,
      width: 200,
    ),
          ],
        );
  }
}
