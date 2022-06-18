import 'package:cloud_hospital/apis/dashboard_apis.dart';
import 'package:cloud_hospital/services/sp_helper.dart';
import 'package:flutter/material.dart';


import 'helpers/local_navigator.dart';
import 'helpers/reponsiveness.dart';
import 'widgets/large_screen.dart';
import 'widgets/side_menu.dart';
import 'widgets/top_nav.dart';


class SiteLayout extends StatefulWidget {
  @override
  State<SiteLayout> createState() => _SiteLayoutState();
}

class _SiteLayoutState extends State<SiteLayout> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();
  @override
  void initState() {
   if(SPHelper.spHelper.getUserType()=='admin'){
     DashboardApis.dashboardApis.getAllDoctor();
     DashboardApis.dashboardApis.getAllPation();
   }else if(SPHelper.spHelper.getUserType()=='patient'){
     DashboardApis.dashboardApis.getPationtDisease();
   }


    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      extendBodyBehindAppBar: true,
      appBar:  topNavigationBar(context, scaffoldKey),
      drawer: Drawer(
        child: SideMenu(),
      ),
      body: ResponsiveWidget(
        largeScreen: LargeScreen(),
      smallScreen: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: localNavigator(),
      )
      ),
    );
  }
}
