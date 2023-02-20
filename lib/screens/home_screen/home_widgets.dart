import 'dart:io';

import 'package:elnemr_invoice/data/models/user_model.dart';
import 'package:elnemr_invoice/screens/home_screen/home_provider.dart';
import 'package:elnemr_invoice/screens/search_screen.dart/search_screen.dart';
import 'package:elnemr_invoice/screens/shared.dart';
import 'package:flutter/material.dart';
import 'dart:ui' as ui;
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../../core/colors.dart';
import '../../core/strings.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeAppBar extends StatelessWidget {
  const HomeAppBar({super.key});
  @override
  Widget build(BuildContext context) {
    return AppBar(
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
        bottom: Radius.circular(50),
      )),
      flexibleSpace: Container(),
      title: Container(
          padding: const EdgeInsets.all(10),
          child: Text(
            AppStrings.appName,
            maxLines: 1,
            softWrap: false,
            style: GoogleFonts.notoKufiArabic(),
          )),
      actions: [
        IconButton(
          iconSize: 30,
          icon: Icon(
            Icons.search,
            color: blackColor,
          ),
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => const SearchScreen(),
            ));
          },
        )
      ],
    );
  }
}

// ignore: must_be_immutable
class InvoiceItem extends StatelessWidget {
  Invoice? invoice;

  InvoiceItem(this.invoice, {super.key});

  @override
  Widget build(BuildContext context) {
    String formattedDate = DateFormat.yMMMEd().format(invoice!.date);
    return Slidable(
      key: const Key('d'),
      startActionPane: ActionPane(
        extentRatio: 0.3,
        motion: const ScrollMotion(),
        children: [
          SlidableAction(
            onPressed: (context) async {
              await showBottomSheetTask(
                context,
                invoice: invoice,
              );
            },
            backgroundColor: nemrYellow,
            foregroundColor: blackColor,
            icon: Icons.edit,
            label: 'تعديل',
            borderRadius: BorderRadius.circular(20),
            autoClose: false,
            flex: 2,
          ),
        ],
      ),
      child: Container(
        width: double.infinity,
        height: 100,
        decoration: BoxDecoration(
            color: whiteColor, borderRadius: BorderRadius.circular(20)),
        child: Row(
          //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          textDirection: ui.TextDirection.rtl,

          children: [
            Container(
              margin: const EdgeInsets.all(20),
              width: 5,
              height: MediaQuery.of(context).size.height * 50,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: invoice?.isDelivered == false ? redColor : nemrYellow,
              ),
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Text(
                      invoice!.name,
                      style: Theme.of(context).textTheme.headline2,
                      textDirection: ui.TextDirection.rtl,
                      textAlign: TextAlign.center,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Row(
                    textDirection: ui.TextDirection.rtl,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const Icon(
                        Icons.more_time_rounded,
                        color: Colors.black,
                        textDirection: ui.TextDirection.rtl,
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Expanded(
                          child: Text(
                        formattedDate,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.headline3,
                        textDirection: ui.TextDirection.rtl,
                      ))
                    ],
                  )
                ],
              ),
            ),
            TotalContainer(total: invoice!.total)
          ],
        ),
      ),
    );
  }
}

Future showBottomSheetTask(BuildContext context,
    {required Invoice? invoice, File? imageFile}) {
  TextEditingController? invoiceNameController = TextEditingController(
    text: invoice?.name,
  );
  TextEditingController? invoiceTotalController =
      TextEditingController(text: invoice?.total);
  TextEditingController? invoiceDescriptionController =
      TextEditingController(text: invoice?.notes);
  String imageUrl;

  final formKey = GlobalKey<FormState>();

  var myProvider = Provider.of<HomeProvider>(context, listen: false);

  return showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (context) {
        return ChangeNotifierProvider(
            create: (context) => HomeProvider(),
            builder: (context, child) {
              return Material(
                child: Container(
                  margin: const EdgeInsets.all(20),
                  padding: MediaQuery.of(context).viewInsets,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                          child: Text(
                        AppStrings.editInvoice,
                        style: Theme.of(context).textTheme.headline2,
                      )),
                      Form(
                          key: formKey,
                          child: Column(
                            children: [
                              AppTextField(
                                controller: invoiceNameController,
                                hintText: AppStrings.clientNameText,
                                icon: const Icon(Icons.person),
                                keyboardType: TextInputType.text,
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              AppTextField(
                                controller: invoiceTotalController,
                                icon: const Icon(Icons.attach_money_outlined),
                                keyboardType: TextInputType.number,
                                hintText: AppStrings.totalText,
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              AppTextField(
                                controller: invoiceDescriptionController,
                                keyboardType: TextInputType.text,
                                icon: const Icon(Icons.edit),
                                maxLines: 4,
                                hintText: AppStrings.notesText,
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    AppStrings.isDeliveredText,
                                    style:
                                        Theme.of(context).textTheme.headline3,
                                  ),
                                  Consumer<HomeProvider>(
                                    builder: (context, provider, child) =>
                                        Checkbox(
                                      checkColor: Colors.greenAccent,
                                      activeColor: Colors.red,
                                      value: provider.isDelivered,
                                      onChanged: (value) {
                                        provider.isDeliveredToggle(value!);
                                        debugPrint(
                                            '--->${myProvider.isDelivered}');
                                        debugPrint('--------->$value');
                                      },
                                    ),
                                  )
                                ],
                              ),
                              imageFile == null
                                  ? InkWell(
                                      onTap: () {},
                                      child: Stack(children: [
                                        ImageFromCloud(
                                          url: invoice!.imageUrl,
                                          hight: 200,
                                          width: 150,
                                        ),
                                        Icon(Icons.change_circle_rounded,color:nemrYellow,)
                                      ]),
                                    )
                                  : ImageFromLocal(file: null!),
                            ],
                          )),
                      SizedBox(
                        height: 20,
                      ),
                      ElevatedButton(
                          onPressed: () {
                            if (formKey.currentState!.validate()) {}
                          },
                          child: null)
                    ],
                  ),
                ),
              );
            });
      });
}
