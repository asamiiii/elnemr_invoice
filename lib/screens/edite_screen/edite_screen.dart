import 'dart:io';
import 'package:path/path.dart' as p;
import 'package:elnemr_invoice/core/colors.dart';
import 'package:elnemr_invoice/data/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../../core/strings.dart';
import '../../data/data_source/remot/firebase_manager.dart';
import '../shared.dart';

// ignore: must_be_immutable
class EditeScreen extends StatefulWidget {
  Invoice invoice;
  late File? imageFile;

  EditeScreen({super.key, required this.invoice, this.imageFile});

  @override
  State<EditeScreen> createState() => _EditeScreenState();
}

class _EditeScreenState extends State<EditeScreen> {
  TextEditingController? invoiceNameController;

  TextEditingController? invoiceTotalController;

  TextEditingController? invoiceDescriptionController;

  late String imageUrl;

  bool isDelivered = false;

  bool isLocalImage = false;

  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    invoiceNameController = TextEditingController(
      text: widget.invoice.name,
    );
    invoiceTotalController = TextEditingController(text: widget.invoice.total);
    invoiceDescriptionController =
        TextEditingController(text: widget.invoice.notes);
    isDelivered = widget.invoice.isDelivered;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: scaffoldColor,
        elevation: 0,
        iconTheme: IconThemeData(color:blackColor),
        toolbarHeight: 28
      ),
      body: Container(
        margin: const EdgeInsets.only(right: 20, left: 20),
        padding: MediaQuery.of(context).viewInsets,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                  child: Text(
                AppStrings.editInvoice,
                style: Theme.of(context).textTheme.headline1,
              )),
              Form(
                  key: formKey,
                  child: Column(
                    children: [
                      AppTextField(
                        controller: invoiceNameController!,
                        hintText: AppStrings.clientNameText,
                        icon: const Icon(Icons.person),
                        keyboardType: TextInputType.text,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      AppTextField(
                        controller: invoiceTotalController!,
                        icon: const Icon(Icons.attach_money_outlined),
                        keyboardType: TextInputType.number,
                        hintText: AppStrings.totalText,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      AppTextField(
                        controller: invoiceDescriptionController!,
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
                            style: Theme.of(context).textTheme.headline3,
                          ),
                          Checkbox(
                            checkColor: Colors.greenAccent,
                            activeColor: Colors.red,
                            value: isDelivered,
                            onChanged: (value) {
                              isDelivered = value!;
                              setState(() {});
                            },
                          ),
                        ],
                      ),
                      isLocalImage == false
                          ? InkWell(
                              onTap: () async {
                                final pickedFile =
                                    await ImagePicker().pickImage(
                                  source: ImageSource.camera,
                                  imageQuality: 70,
                                );
                                if (pickedFile != null) {
                                  final imageFile = File(pickedFile.path);
                                  imageUrl = await FirebaseHelper()
                                      .uploadImageOnFirebaseStorage(imageFile,
                                          p.basename(pickedFile.path));
                                  //debugPrint(p.basename(pickedFile.path));
                                  // ignore: use_build_context_synchronously
                                  isLocalImage = true;
                                  setState(() {});
                                } else {
                                  debugPrint('No image selected.');
                                }
                              },
                              child: Stack(children: [
                                ImageFromCloud(
                                  url: widget.invoice.imageUrl,
                                  hight: 200,
                                  width: 150,
                                ),
                                Icon(
                                  Icons.change_circle_rounded,
                                  color: nemrYellow,
                                )
                              ]),
                            )
                          : ImageFromCloud(
                              url: imageUrl,
                              hight: 200,
                              width: 150,
                            ),
                    ],
                  )),
              const SizedBox(
                height: 20,
              ),
              Center(
                child: ElevatedButton(
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        showLoading(context, AppStrings.editInvoiceProgress);
                        FirebaseHelper().updateTask(
                            widget.invoice.id!,
                            Invoice(
                              name: invoiceNameController!.text,
                              total: invoiceTotalController!.text,
                              imageUrl: isLocalImage == false
                                  ? widget.invoice.imageUrl
                                  : imageUrl,
                              notes: invoiceDescriptionController!.text,
                              isDelivered: isDelivered,
                            ));
                        hideLoading(context);
                        hideLoading(context);
                        showSnakBarSuccess(
                            context, AppStrings.editInvoiceDone, greenColor);
                      }
                    },
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all<Color>(Colors.green),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18.0),
                        ))),
                    child: Text(AppStrings.editInvoice)),
              )
            ],
          ),
        ),
      ),
    );
  }
}
