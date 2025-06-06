import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_lucide/flutter_lucide.dart';
import '../../../controller/apps/CRM/contacts_controller.dart';
import '../../../helper/theme/app_style.dart';
import '../../../helper/utils/my_shadow.dart';
import '../../../helper/utils/ui_mixins.dart';
import '../../../helper/utils/utils.dart';
import '../../../helper/widgets/my_breadcrumb.dart';
import '../../../helper/widgets/my_breadcrumb_item.dart';
import '../../../helper/widgets/my_button.dart';
import '../../../helper/widgets/my_card.dart';
import '../../../helper/widgets/my_container.dart';
import '../../../helper/widgets/my_flex.dart';
import '../../../helper/widgets/my_flex_item.dart';
import '../../../helper/widgets/my_spacing.dart';
import '../../../helper/widgets/my_text.dart';
import '../../../helper/widgets/my_text_style.dart';
import '../../../helper/widgets/responsive.dart';
import '../../../images.dart';
import '../../../models/contects_data.dart';
import '../../../views/layout/layout.dart';

class ContactsPage extends StatefulWidget {
  const ContactsPage({super.key});

  @override
  State<ContactsPage> createState() => _ContactsPageState();
}

class _ContactsPageState extends State<ContactsPage> with SingleTickerProviderStateMixin, UIMixin {
  late ContactsController controller;

  @override
  void initState() {
    super.initState();
    controller = Get.put(ContactsController());
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
                    MyText.titleMedium("Contact", fontWeight: 600),
                    MyBreadcrumb(
                      children: [MyBreadcrumbItem(name: "CRM"), MyBreadcrumbItem(name: "Contact", active: true)],
                    ),
                  ],
                ),
              ),
              MySpacing.height(flexSpacing),
              Padding(
                padding: MySpacing.x(flexSpacing),
                child: MyFlex(
                  contentPadding: false,
                  children: [
                    MyFlexItem(
                      sizes: "xxl-4 xl-4",
                      child: MyCard(
                        shadow: MyShadow(elevation: 0.5),
                        paddingAll: 20,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                MyContainer.roundBordered(
                                  alignment: Alignment.topLeft,
                                  paddingAll: 0,
                                  clipBehavior: Clip.antiAliasWithSaveLayer,
                                  height: 60,
                                  child: Image.asset(Images.avatars[1], fit: BoxFit.cover, height: 60),
                                ),
                                MySpacing.width(16),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    MyText.bodyMedium("Gareth Ivanets", fontSize: 20),
                                    MyText.bodyMedium("Branch Manager", muted: true),
                                  ],
                                ),
                              ],
                            ),
                            MySpacing.height(16),
                            MyContainer(
                              paddingAll: 8,
                              color: contentTheme.primary.withAlpha(30),
                              child: Row(
                                children: [
                                  Icon(LucideIcons.user, color: contentTheme.primary),
                                  MySpacing.width(12),
                                  Expanded(
                                    child: MyText.bodyMedium(
                                      "PERSONAL INFORMATION",
                                      fontSize: 16,
                                      color: contentTheme.primary,
                                      overflow: TextOverflow.ellipsis,
                                      fontWeight: 600,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            MySpacing.height(16),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                MyText.titleMedium("ABOUT ME:", fontWeight: 600),
                                MySpacing.height(12),
                                MyText.bodyMedium(
                                  controller.dummyTexts[2],
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 3,
                                  muted: true,
                                ),
                              ],
                            ),
                            MySpacing.height(16),
                            buildPersonalDetail("DATE OF BIRTH :", "March 23, 1984 (34 Years)"),
                            MySpacing.height(16),
                            buildPersonalDetail("COMPANY :", "Vine Corporation"),
                            MySpacing.height(16),
                            buildPersonalDetail("ADDED:", "April 22, 2016"),
                            MySpacing.height(16),
                            buildPersonalDetail("UPDATED:", "Dec 13, 2017"),
                          ],
                        ),
                      ),
                    ),
                    MyFlexItem(
                      sizes: "xxl-8 xl-8",
                      child: Column(
                        children: [
                          if (controller.data != null)
                            PaginatedDataTable(
                              header: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Padding(
                                    padding: MySpacing.only(top: 6),
                                    child: SizedBox(
                                      width: 200,
                                      child: TextFormField(
                                        maxLines: 1,
                                        style: MyTextStyle.bodyMedium(),
                                        decoration: InputDecoration(
                                          hintText: "search...",
                                          hintStyle: MyTextStyle.bodySmall(xMuted: true),
                                          border: outlineInputBorder,
                                          enabledBorder: outlineInputBorder,
                                          focusedBorder: focusedInputBorder,
                                          contentPadding: MySpacing.xy(16, 12),
                                          isCollapsed: true,
                                          floatingLabelBehavior: FloatingLabelBehavior.never,
                                        ),
                                      ),
                                    ),
                                  ),
                                  MyButton(
                                    onPressed:
                                        () => showDialog(
                                          context: context,
                                          builder:
                                              (context) => AlertDialog(
                                                clipBehavior: Clip.antiAliasWithSaveLayer,
                                                title: Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [MyText.titleMedium("Add item")],
                                                ),
                                                titlePadding: MySpacing.xy(16, 12),
                                                insetPadding: MySpacing.y(300),
                                                actionsPadding: MySpacing.xy(190, 16),
                                                contentPadding: MySpacing.x(16),
                                                content: Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    MyText.bodyMedium("Name"),
                                                    MySpacing.height(8),
                                                    TextFormField(
                                                      keyboardType: TextInputType.emailAddress,
                                                      decoration: InputDecoration(
                                                        labelText: "Enter Name",
                                                        labelStyle: MyTextStyle.bodySmall(xMuted: true),
                                                        border: outlineInputBorder,
                                                        contentPadding: MySpacing.all(16),
                                                        isCollapsed: true,
                                                        floatingLabelBehavior: FloatingLabelBehavior.never,
                                                      ),
                                                    ),
                                                    MySpacing.height(16),
                                                    MyText.bodyMedium("Email"),
                                                    MySpacing.height(8),
                                                    TextFormField(
                                                      keyboardType: TextInputType.emailAddress,
                                                      decoration: InputDecoration(
                                                        labelText: "Enter Email",
                                                        labelStyle: MyTextStyle.bodySmall(xMuted: true),
                                                        border: outlineInputBorder,
                                                        contentPadding: MySpacing.all(16),
                                                        isCollapsed: true,
                                                        floatingLabelBehavior: FloatingLabelBehavior.never,
                                                      ),
                                                    ),
                                                    MySpacing.height(16),
                                                    MyText.bodyMedium("Phone"),
                                                    MySpacing.height(8),
                                                    TextFormField(
                                                      keyboardType: TextInputType.emailAddress,
                                                      decoration: InputDecoration(
                                                        labelText: "Enter Phone Number",
                                                        labelStyle: MyTextStyle.bodySmall(xMuted: true),
                                                        border: outlineInputBorder,
                                                        contentPadding: MySpacing.all(16),
                                                        isCollapsed: true,
                                                        floatingLabelBehavior: FloatingLabelBehavior.never,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                actions: [
                                                  MyButton(
                                                    onPressed: () {
                                                      Navigator.pop(context);
                                                    },
                                                    elevation: 0,
                                                    backgroundColor: contentTheme.primary,
                                                    borderRadiusAll: AppStyle.buttonRadius.medium,
                                                    child: MyText.bodyMedium("Ok", color: contentTheme.onPrimary),
                                                  ),
                                                  MyButton(
                                                    onPressed: () {
                                                      Navigator.pop(context);
                                                    },
                                                    elevation: 0,
                                                    backgroundColor: contentTheme.primary,
                                                    borderRadiusAll: AppStyle.buttonRadius.medium,
                                                    child: MyText.bodyMedium("Cancel", color: contentTheme.onPrimary),
                                                  ),
                                                ],
                                              ),
                                        ),
                                    elevation: 0,
                                    padding: MySpacing.xy(12, 18),
                                    backgroundColor: contentTheme.primary,
                                    borderRadiusAll: AppStyle.buttonRadius.medium,
                                    child: MyText.bodySmall("Add Contact", color: contentTheme.onPrimary),
                                  ),
                                ],
                              ),
                              source: controller.data!,
                              columns: [
                                DataColumn(label: MyText.titleMedium('Name', fontWeight: 600)),
                                DataColumn(label: MyText.titleMedium('Phone Number', fontWeight: 600)),
                                DataColumn(label: MyText.titleMedium('Email', fontWeight: 600)),
                                DataColumn(label: MyText.titleMedium('Company', fontWeight: 600)),
                                DataColumn(label: MyText.titleMedium('Created At', fontWeight: 600)),
                              ],
                              columnSpacing: 60,
                              horizontalMargin: 28,
                              rowsPerPage: 10,
                            ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget buildPersonalDetail(String title, String description) {
    return Row(
      children: [
        MyText.titleMedium(title, fontWeight: 600),
        MySpacing.width(8),
        Expanded(child: MyText.bodyMedium(description, overflow: TextOverflow.ellipsis)),
      ],
    );
  }
}

class ContactsData extends DataTableSource with UIMixin {
  List<Contacts> data = [];

  ContactsData(this.data);

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
        DataCell(MyText.titleMedium(data[index].name, fontWeight: 600, fontSize: 14)),
        DataCell(MyText.bodyMedium("91+ ${data[index].phoneNumber}", fontSize: 14)),
        DataCell(MyText.bodyMedium(data[index].email, fontSize: 14)),
        DataCell(MyText.bodyMedium(data[index].company, fontSize: 14)),
        DataCell(MyText.bodyMedium('${Utils.getDateStringFromDateTime(data[index].createdAt, showMonthShort: true)}')),
      ],
    );
  }
}
