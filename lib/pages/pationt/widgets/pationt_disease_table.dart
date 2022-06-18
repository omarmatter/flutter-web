import 'package:cloud_hospital/controllers/dashboard_controller.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../constants/style.dart';
import '../../../utils/progress_dialog_utils.dart';
import '../../../widgets/custom_text.dart';

/// Example without datasource
class PationtDiseaseTable extends StatelessWidget {
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
      child: Obx(() => dashController.getAllDiseasesModelData.value.data == null
          ? Center(child: CircularProgressIndicator())
          : DataTable2(
              columnSpacing: 12,
              horizontalMargin: 12,
              minWidth: 600,
              columns: const[
                DataColumn2(
                  label: Text("المرض"),
                  size: ColumnSize.L,
                ),
                DataColumn(
                  label: Text('تفاصيل عن المرض'),
                ),
                DataColumn(
                  label: Text('Action'),
                ),
              ],
              rows: List<DataRow>.generate(
                  dashController.getAllDiseasesModelData.value.data.length,
                  (index) => DataRow(cells: [
                        DataCell(CustomText(text: dashController.getAllDiseasesModelData.value.data[index].name)),
                        DataCell(CustomText(text: dashController.getAllDiseasesModelData.value.data[index].description)),
                        DataCell(Container(
                            decoration: BoxDecoration(
                              color: light,
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(color: active, width: .5),
                            ),
                            padding: EdgeInsets.symmetric(
                                horizontal: 12, vertical: 6),
                            child: CustomText(
                              text: "Block",
                              color: active.withOpacity(.7),
                              weight: FontWeight.bold,
                            ))),
                      ])))),
    );
  }
}
