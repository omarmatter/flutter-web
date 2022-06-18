import 'package:flutter/material.dart';

import '../pages/clients/clients.dart';
import '../pages/drivers/drivers.dart';
import '../pages/overview/overview.dart';
import '../pages/pationt/pationt_disease_page.dart';
import '../pages/specialties/specialties.dart';
import 'routes.dart';


Route<dynamic> generateRoute(RouteSettings settings){
  switch (settings.name) {
    case overviewPageRoute:
      return _getPageRoute(OverviewPage());
    case driversPageRoute:
      return _getPageRoute(DriversPage());
    case clientsPageRoute:
      return _getPageRoute(ClientsPage());
      case PationtDiseasePageRoute:
      return _getPageRoute(PationtDiseasePage());
    case specialtiesPageRoute:
      return _getPageRoute(Specialties());
    default:
      return _getPageRoute(OverviewPage());

  }
}

PageRoute _getPageRoute(Widget child){
  return MaterialPageRoute(builder: (context) => child);
}