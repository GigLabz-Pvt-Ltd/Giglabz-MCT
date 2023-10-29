import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mycareteam/resources/constants/colors.dart';
import 'package:mycareteam/widgets/bordered_edit_text.dart';
import 'package:mycareteam/widgets/profile_setting_widget.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen>
    with SingleTickerProviderStateMixin {
  final _tabs = [
    "Profile Setting",
    "Avatar",
    "Privacy Settings",
    "Set Notifications"
  ];

  late final TabController _tabCont;
  var currentTab = 0;

  @override
  void initState() {
    _tabCont = TabController(length: 4, vsync: this);
    super.initState();

    _tabCont.addListener(() {
      setState(() {
        currentTab = _tabCont.index;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: scaffoldGrey,
      body: NestedScrollView(
        headerSliverBuilder: (_, __) {
          return [
            SliverAppBar(
              backgroundColor: primaryColor,
              pinned: true,
              floating: false,
              forceElevated: true,
              elevation: 1,
              titleSpacing: 0,
              leading: GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: const Icon(
                  Icons.arrow_back_ios_new,
                  color: Colors.white,
                  size: 20,
                ),
              ),
              title: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Profile",
                  textAlign: TextAlign.left,
                  style: GoogleFonts.poppins(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Colors.white),
                ),
              ),
              centerTitle: false,
              bottom: PreferredSize(
                preferredSize: _tabBar.preferredSize,
                child: ColoredBox(color: Colors.white, child: _tabBar),
              ),
            ),
          ];
        },
        body: TabBarView(
          controller: _tabCont,
          children: const [
            ProfileSettingWidget(),
            Center(child: Text("2")),
            Center(child: Text("3")),
            Center(child: Text("4")),
          ],
        ),
      ),
    );
  }

  TabBar get _tabBar => TabBar(
        controller: _tabCont,
        isScrollable: true,
        indicatorColor: tabSelected,
        tabAlignment: TabAlignment.start,
        tabs: [
          ..._tabs.map(
            (label) => Tab(
              child: Text(
                label,
                style: GoogleFonts.poppins(
                  color: blueGrey,
                  fontSize: 12,
                  fontWeight: _tabs[currentTab] == label
                      ? FontWeight.w500
                      : FontWeight.w400,
                ),
              ),
            ),
          ),
        ],
      );
}
