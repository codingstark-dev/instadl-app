import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Tabs extends StatefulWidget {
  const Tabs({Key? key}) : super(key: key);

  @override
  State<Tabs> createState() => _TabsState();
}

class _TabsState extends State<Tabs> with TickerProviderStateMixin {
  late TabController _tabController;

  // This widget is the root of your application.
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 7, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: TabBar(
        labelStyle: TextStyle(fontSize: 12),

        labelColor: Colors.blue,
        // unselectedLabelColor: Colors.black,
        // overlayColor: MaterialStateProperty.all(Colors.black),
        controller: _tabController,
        isScrollable: true,
        tabs: <Widget>[
          Tab(
            icon: Icon(Icons.video_collection_outlined),
            text: "Reels",
            iconMargin: EdgeInsets.all(2),
          ),
          Tab(
            icon: Icon(Icons.person_pin),
            text: "Profile",
            iconMargin: EdgeInsets.all(2),
          ),
          Tab(
            icon: Icon(Icons.supervised_user_circle),
            text: "Stories",
            iconMargin: EdgeInsets.all(2),
          ),
          Tab(
            icon: Icon(Icons.audio_file),
            text: "Audio",
            iconMargin: EdgeInsets.all(2),
          ),
          Tab(
            icon: Icon(Icons.image),
            text: "Photo",
            iconMargin: EdgeInsets.all(2),
          ),
          Tab(
            icon: Icon(Icons.video_file),
            text: "Video",
            iconMargin: EdgeInsets.all(2),
          ),
          Tab(
            icon: Icon(Icons.live_tv_outlined),
            text: "IGTV",
            iconMargin: EdgeInsets.all(2),
          ),
        ],
      ),
    );
  }
}
