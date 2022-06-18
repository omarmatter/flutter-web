import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lazy_load_scrollview/lazy_load_scrollview.dart';

import '../../../apis/dashboard_apis.dart';
import '../../../constants/style.dart';
import '../../../controllers/dashboard_controller.dart';
import '../../../model/disease_by_pationt_model.dart';
import '../../../routing/routes.dart';
import '../../../widgets/custom_text.dart';
import 'client_disease.dart';

/// Example without datasource
class Clientstable extends StatelessWidget {
  DashboardController dashController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: active.withOpacity(.4), width: .5),
        boxShadow: [
          BoxShadow(
              offset: Offset(0, 6),
              color: lightGrey.withOpacity(.1),
              blurRadius: 12)
        ],
        borderRadius: BorderRadius.circular(8),
      ),
      padding: const EdgeInsets.all(16),
      margin: EdgeInsets.only(bottom: 30),
      child: Obx(() => dashController.getAllPationtModelData.value.data == null
          ? Center(child: CircularProgressIndicator())
          : DataTable2(

              columnSpacing: 12,
              horizontalMargin: 12,
              minWidth: 600,
              columns: const[
                DataColumn2(
                  label: Text("اسم المريض"),
                  size: ColumnSize.L,
                ),
                DataColumn(
                  label: Text('رقم الهوية'),
                ),
                DataColumn(
                  label: Text('الجنس'),
                ),
                DataColumn(
                  label: Text('Action'),
                ),
              ],
              rows: List<DataRow>.generate(
                  DashboardApis.dashboardApis.patientList
                      .length,
                  (index) {
                    var patientList = DashboardApis.dashboardApis.patientList[index];
                    return DataRow(


                        cells: [
                          DataCell(CustomText(
                              text:  patientList.name)),
                          DataCell(CustomText(
                              text:  patientList.idNumber)),
                          DataCell(CustomText(
                              text:  patientList.gender)),
                          DataCell(InkWell(
                            onTap: (){
                              dashController.getDiseaseByPatientModelData.value=
                                  DiseaseByPatientModel.fromJson({});
                              DashboardApis.dashboardApis.getDiseaseByPatient(patientList.id);
                              Get.to(ClientDisease(name: patientList.name,patientId: patientList.id.toString(),),);},
                            child: Container(
                                decoration: BoxDecoration(
                                  color: light,
                                  borderRadius: BorderRadius.circular(20),
                                  border: Border.all(color: active, width: .5),
                                ),
                                padding: EdgeInsets.symmetric(
                                    horizontal: 12, vertical: 6),
                                child: CustomText(
                                  text: "تفاصيل",
                                  color: active.withOpacity(.7),
                                  weight: FontWeight.bold,
                                )),
                          )),
                        ]);
                  } ))),
    );
  }
}
