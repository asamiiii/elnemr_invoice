import 'dart:io';
import 'package:elnemr_invoice/core/strings.dart';
import 'package:elnemr_invoice/screens/add_invoice_screen/add_invoice_vm.dart';
import 'package:flutter/material.dart';
import '../../core/colors.dart';

class AddInoviceScreen extends StatefulWidget {
  final File image;
  final String imagePath;
  const AddInoviceScreen(
      {super.key, required this.image, required this.imagePath});

  @override
  State<AddInoviceScreen> createState() => _AddInoviceScreenState();
}

class _AddInoviceScreenState extends State<AddInoviceScreen> {
  TextEditingController? userNameController;

  TextEditingController? totalInvoiceController;

  @override
  void initState() {
    super.initState();
    userNameController = TextEditingController();
    totalInvoiceController = TextEditingController();
  }

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
                widget.image,
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
                          image: widget.image,
                          imagePath: widget.imagePath,
                          total: totalInvoiceController!.text,
                          date: DateTime.now(),
                        );
                        hideLoading(context);
                        hideLoading(context);
                        showSnakBarSuccess(context);
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

  showSnakBarSuccess(BuildContext context) {
    final snackBar = SnackBar(
      backgroundColor: greenColor,
      content: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            AppStrings.successMessage,
            textAlign: TextAlign.center,
            style:Theme.of(context).textTheme.headline2,
          ),
        ],
      ),
      action: SnackBarAction(
        textColor: whiteColor,
        label: 'ok',
        onPressed: () {
          // Some code to undo the change.
        },
      ),
    );

    // Find the ScaffoldMessenger in the widget tree
    // and use it to show a SnackBar.
    return ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  showLoading(BuildContext context, String message,
      {bool isCancellable = true}) {
    return showDialog(
      context: context,
      barrierDismissible: isCancellable,
      builder: (context) {
        return AlertDialog(
          title: Row(
            children: [
              Text(message),
              const SizedBox(
                width: 15,
              ),
              const CircularProgressIndicator()
            ],
          ),
        );
      },
    );
  }

  @override
  hideLoading(BuildContext context) {
    Navigator.of(context).pop();
  }
}
