import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/instance_manager.dart';
import 'package:flutter_lucide/flutter_lucide.dart';
import '../../controller/other/basic_table_controller.dart';
import '../../helper/extensions/string.dart';
import '../../helper/utils/ui_mixins.dart';
import '../../helper/widgets/my_breadcrumb.dart';
import '../../helper/widgets/my_breadcrumb_item.dart';
import '../../helper/widgets/my_container.dart';
import '../../helper/widgets/my_spacing.dart';
import '../../helper/widgets/my_text.dart';
import '../../helper/widgets/responsive.dart';
import '../../views/layout/layout.dart';

class BasicTable extends StatefulWidget {
  const BasicTable({super.key});

  @override
  State<BasicTable> createState() => _BasicTableState();
}

class _BasicTableState extends State<BasicTable> with SingleTickerProviderStateMixin, UIMixin {
  late BasicTableController controller;

  @override
  void initState() {
    super.initState();
    controller = Get.put(BasicTableController());
  }

  @override
  Widget build(BuildContext context) {
    return Layout(
      child: GetBuilder(
        init: controller,
        builder: (controller) {
          return Column(
            children: [
              Padding(
                padding: MySpacing.x(flexSpacing),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    MyText.titleMedium("basic_tables".tr().capitalizeWords, fontSize: 18, fontWeight: 600),
                    MyBreadcrumb(
                      children: [
                        MyBreadcrumbItem(name: 'ui'.tr()),
                        MyBreadcrumbItem(name: 'basic_table'.tr().capitalizeWords, active: true),
                      ],
                    ),
                  ],
                ),
              ),
              MySpacing.height(flexSpacing),
              Padding(
                padding: MySpacing.x(flexSpacing),
                child: PaginatedDataTable(
                  header: Row(children: [MyText.titleMedium("Product List", fontWeight: 600, fontSize: 20)]),
                  arrowHeadColor: contentTheme.primary,
                  source: controller.data!,
                  columns: [
                    DataColumn(label: MyText.bodyMedium('Id', fontWeight: 600)),
                    DataColumn(label: MyText.bodyMedium('Name', fontWeight: 600)),
                    DataColumn(label: MyText.bodyMedium('Code')),
                    DataColumn(label: MyText.bodyMedium('Price')),
                    DataColumn(label: MyText.bodyMedium('QTY')),
                    DataColumn(label: MyText.bodyMedium('Action')),
                  ],
                  columnSpacing: 230,
                  horizontalMargin: 28,
                  rowsPerPage: 10,
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

class MyData extends DataTableSource with UIMixin {
  List<Data> data = [];

  MyData(this.data);

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => data.length;

  @override
  int get selectedRowCount => 0;

  @override
  DataRow getRow(int index) {
    return DataRow(
      cells: [
        DataCell(MyText.bodyMedium(data[index].id.toString(), fontWeight: 600)),
        DataCell(MyText.bodyMedium(data[index].name, fontWeight: 600)),
        DataCell(MyText.bodyMedium(data[index].code.toString())),
        DataCell(MyText.bodyMedium(data[index].amount.toString())),
        DataCell(MyText.bodyMedium(data[index].qty.toString())),
        DataCell(
          Align(
            alignment: Alignment.center,
            child: Row(
              children: [
                MyContainer.bordered(
                  onTap: () => {},
                  padding: MySpacing.xy(6, 6),
                  borderColor: contentTheme.primary.withAlpha(40),
                  child: Icon(LucideIcons.pencil, size: 12, color: contentTheme.primary),
                ),
                MySpacing.width(12),
                MyContainer.bordered(
                  onTap: () => {},
                  padding: MySpacing.xy(6, 6),
                  borderColor: contentTheme.primary.withAlpha(40),
                  child: Icon(LucideIcons.trash_2, size: 12, color: contentTheme.primary),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
