import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../apis/dashboard_apis.dart';
import '../../constants/controllers.dart';
import '../../controllers/dashboard_controller.dart';
import '../../helpers/reponsiveness.dart';
import '../../widgets/custom_text.dart';
import 'widgets/clients_table.dart';

class ClientsPage extends StatefulWidget {
  const ClientsPage({ Key key }) : super(key: key);

  @override
  State<ClientsPage> createState() => _ClientsPageState();
}
int pageNum = 1;
DashboardController dashController = Get.find();

class _ClientsPageState extends State<ClientsPage> {
  @override
  Widget build(BuildContext context) {
   var value = dashController.getAllPationtModelData.value.data;
         return Container(
                child: Column(
                children: [
                 Obx(() => Row(
                    children: [
                      Container(
                        margin: EdgeInsets.only(top:
                        ResponsiveWidget.isSmallScreen(context) ? 56 : 6),
                        child: CustomText(text: menuController.activeItem.value, size: 24, weight: FontWeight.bold,)),
                    ],
                  ),),

                  Expanded(child: ListView(
                    children: [
                      Clientstable(),
                     value.pagination.lastPage>pageNum?SizedBox(
                       height: 70,
                       child: TextButton(onPressed: (){
                         if(value.pagination.lastPage>pageNum){
                           setState(() =>pageNum++);
                           DashboardApis.dashboardApis.getAllPation(pageNumber:pageNum);
                         }else{}
                       }, child: Row(
                         mainAxisAlignment: MainAxisAlignment.center,
                         children: const[
                           CustomText(text:'Show More',size: 17,weight: FontWeight.bold),
                           SizedBox(width: 10,),
                           Icon(Icons.expand_more_sharp)
                         ],
                       )),
                     ):const SizedBox(),
                     const SizedBox(height: 40,),
                    ],
                  )),

                  ],
                ),
              );
  }
}