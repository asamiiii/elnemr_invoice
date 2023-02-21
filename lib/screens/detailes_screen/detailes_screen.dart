import 'package:elnemr_invoice/core/strings.dart';
import 'package:elnemr_invoice/data/data_source/remot/firebase_manager.dart';
import 'package:elnemr_invoice/data/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import '../../core/colors.dart';
import '../shared.dart';
import 'detailes_widgets.dart';

class DetailesScreen extends StatelessWidget {
  final Invoice? invoice;

  const DetailesScreen({super.key, required this.invoice});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      extendBodyBehindAppBar: true,
      appBar: PreferredSize(
          preferredSize: const Size.fromHeight(100),
          child: DetailesAppBar(
            clientName: invoice!.name,
          )),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 130.0,left: 10,right: 10),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 10,
                ),
                ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: FadeInImage.assetNetwork(
                    placeholder: 'assets/images/giphy.gif',
                    image: invoice!.imageUrl,
                    //width: MediaQuery.of(context).size.width * 0.90,
                    height: MediaQuery.of(context).size.height * 0.70,
                    fit: BoxFit.fill,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TotalContainer(total: invoice!.total),
                    Expanded(
                      child: Text(
                        invoice?.isDelivered == false
                            ? AppStrings.isDeliveredFalse
                            : AppStrings.isDeliveredTrue,
                        style: Theme.of(context).textTheme.headline2?.copyWith(
                            color: invoice?.isDelivered == false
                                ? redColor
                                : greenColor,
                                overflow: TextOverflow.ellipsis),
                                textDirection: TextDirection.rtl,
                                textAlign: TextAlign.center,
                      ),

                    )
                  ],
                ),
                const SizedBox(height: 20,),
                Text(
                        invoice?.notes == ''
                            ? AppStrings.notesInvoiceisNotExist
                            : invoice!.notes,
                        style: Theme.of(context).textTheme.headline2?.copyWith(
                                overflow: TextOverflow.ellipsis),
                                textDirection: TextDirection.rtl,
                                textAlign: TextAlign.center,
                      ),

                const SizedBox(height: 20,),
                ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all<Color>(Colors.red),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18.0),
                        ))),
                    onPressed: () async {
                      await alertDialog(context);

                      //
                    },
                    child: const Text('مسح الفاتورة'))
              ],
            ),
          ),
        ),
      ),
    );
  }

  alertDialog(BuildContext context) async {
    await Alert(
      context: context,
      type: AlertType.error,
      title: "تنبيه",
      desc: "هل انت متأكد من حذف الفاتوره",
      buttons: [
        DialogButton(
          onPressed: () {
            FirebaseHelper().deleteUser(invoice!.id, invoice!.imageUrl);
            Navigator.of(context).pop();
            Navigator.of(context).pop();
            showSnakBarSuccess(context, AppStrings.deleteMessage, redColor);
          },
          width: 120,
          child: const Text(
            "حذف",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
        )
      ],
    ).show();
  }
}
