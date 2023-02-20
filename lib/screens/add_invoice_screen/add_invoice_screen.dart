import 'dart:io';
import 'package:elnemr_invoice/core/strings.dart';
import 'package:elnemr_invoice/screens/add_invoice_screen/add_invoice_vm.dart';
import 'package:flutter/material.dart';
import '../../core/colors.dart';
import '../shared.dart';

// ignore: must_be_immutable
class AddInoviceScreen extends StatelessWidget {
  final File image;
  final String imagePath;
   AddInoviceScreen(
      {super.key, required this.image, required this.imagePath});

  TextEditingController? userNameController=TextEditingController();

  TextEditingController? totalInvoiceController=TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding:
            const EdgeInsets.only(top: 60.0, left: 10, right: 10, bottom: 15),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                textDirection: TextDirection.rtl,
                children: [
                  const SizedBox(
                    height: 100,
                  ),
                  Expanded(
                    child: TextFormField(
                      controller: userNameController,
                      style: const TextStyle(
                        fontSize: 20,
                      ),
                      textDirection: TextDirection.rtl,
                      decoration: InputDecoration(
                          prefixIcon:
                              const Icon(Icons.person_add_alt_1_rounded),
                          border: const OutlineInputBorder(),
                          hintText: 'اسم العميل',
                          hintStyle: const TextStyle(color: Colors.grey),
                          labelText: 'اسم العميل',
                          labelStyle: TextStyle(color: blackColor)),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
                Image.file(
                image,
                width: MediaQuery.of(context).size.width * 0.90,
                height: MediaQuery.of(context).size.height * 0.65,
                fit: BoxFit.fill,
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                textDirection: TextDirection.rtl,
                children: [
                  Expanded(
                    child: TextFormField(
                      textDirection: TextDirection.rtl,
                      controller: totalInvoiceController,
                      style: const TextStyle(
                        fontSize: 20,
                      ),
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.price_change),
                        border: const OutlineInputBorder(),
                        hintText: 'اجمالي الفاتوره',
                        hintStyle: const TextStyle(color: Colors.grey),
                        labelText: "الاجمالي",
                        labelStyle: TextStyle(color: blackColor),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 50,
                  ),
                  ElevatedButton(
                      onPressed: () async {
                        showLoading(context, 'جاري التحميل');
                        await AddInvoiceVM().addInvoice(
                          context: context,
                          clientName: userNameController!.text,
                          image: image,
                          imagePath: imagePath,
                          total: totalInvoiceController!.text,
                          date: DateTime.now(),
                        );
                        // ignore: use_build_context_synchronously
                        hideLoading(context);
                        // ignore: use_build_context_synchronously
                        hideLoading(context);
                        // ignore: use_build_context_synchronously
                        showSnakBarSuccess(context,AppStrings.successMessage,greenColor);
                      },
                      style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all<Color>(Colors.green),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18.0),
                          ))),
                      child: const Text('اضافة الفاتورة'))
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
