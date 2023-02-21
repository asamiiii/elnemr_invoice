import 'dart:io';
import 'package:elnemr_invoice/core/strings.dart';
import 'package:elnemr_invoice/screens/add_invoice_screen/add_invoice_vm.dart';
import 'package:flutter/material.dart';
import '../../core/colors.dart';
import '../shared.dart';

// ignore: must_be_immutable
class AddInoviceScreen extends StatefulWidget {
  final File image;
  final String imagePath;
  const AddInoviceScreen({super.key, required this.image, required this.imagePath});

  @override
  State<AddInoviceScreen> createState() => _AddInoviceScreenState();
}

class _AddInoviceScreenState extends State<AddInoviceScreen> {
  TextEditingController? userNameController = TextEditingController();

  TextEditingController? totalInvoiceController = TextEditingController();

  TextEditingController? invoiceNotesController = TextEditingController();

  bool isDelivered = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding:
            const EdgeInsets.only(top: 40.0, left: 10, right: 10, bottom: 15),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: Container(
                        height: 55,
                        padding: const EdgeInsets.only(top: 7),
                        child: AppTextField(
                          controller: userNameController!,
                          hintText: AppStrings.clientNameText,
                          icon: const Icon(Icons.person),
                          keyboardType: TextInputType.text,
                        )),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  Expanded(
                    child: Container(
                        height: 55,
                        padding: const EdgeInsets.only(top: 7),
                        child: AppTextField(
                          controller: totalInvoiceController!,
                          icon: const Icon(Icons.attach_money_outlined),
                          keyboardType: TextInputType.number,
                          hintText: AppStrings.totalText,
                        )),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.file(
                  widget.image,
                  //width: MediaQuery.of(context).size.width * 0.90,
                  height: MediaQuery.of(context).size.height * 0.65,
                  fit: BoxFit.fill,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                textDirection: TextDirection.rtl,
                children: [
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: AppTextField(
                      controller: invoiceNotesController!,
                      keyboardType: TextInputType.text,
                      icon: const Icon(Icons.edit),
                      maxLines: 4,
                      hintText: AppStrings.notesText,
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    AppStrings.isDeliveredText,
                    style: Theme.of(context).textTheme.headline3,
                  ),
                  Checkbox(
                    checkColor: Colors.greenAccent,
                    activeColor: Colors.red,
                    value: isDelivered,
                    onChanged: (value) {
                      isDelivered = value!;
                      debugPrint('$value');
                      setState(() {});
                    },
                  ),
                ],
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
                      notes: invoiceNotesController?.text,
                      isDelivered: isDelivered,
                      date: DateTime.now(),
                    );
                    // ignore: use_build_context_synchronously
                    hideLoading(context);
                    // ignore: use_build_context_synchronously
                    hideLoading(context);
                    // ignore: use_build_context_synchronously
                    showSnakBarSuccess(
                        context, AppStrings.successMessage, greenColor);
                  },
                  style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all<Color>(Colors.green),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18.0),
                      ))),
                  child: const Text('اضافة الفاتورة')),
            ],
          ),
        ),
      ),
    );
  }
}
