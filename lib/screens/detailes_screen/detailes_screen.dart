import 'package:elnemr_invoice/core/strings.dart';
import 'package:elnemr_invoice/data/data_source/remot/firebase_manager.dart';
import 'package:elnemr_invoice/data/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import '../../core/colors.dart';
import '../shared.dart';

class DetailesScreen extends StatelessWidget {
  final Invoice? invoice;

  const DetailesScreen({super.key, required this.invoice});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 60.0, left: 10, right: 10),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                textDirection: TextDirection.rtl,
                children: [
                  Expanded(
                    child: Text(
                      invoice!.name,
                      style: Theme.of(context).textTheme.headline1,
                      overflow: TextOverflow.ellipsis,
                      textDirection: TextDirection.rtl,
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              FadeInImage.assetNetwork(
                placeholder: 'assets/images/giphy.gif',
                image: invoice!.imageUrl,
                width: MediaQuery.of(context).size.width * 0.90,
                height: MediaQuery.of(context).size.height * 0.70,
                fit: BoxFit.fill,
              ),
              const SizedBox(
                height: 10,
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
            decoration: BoxDecoration(
                color: cyanColor, borderRadius: BorderRadius.circular(20)),
            child: Text(
              'Total : ${invoice!.total} EGP',
              style: Theme.of(context)
                  .textTheme
                  .headline2
                  ?.copyWith(color: whiteColor),
            ),
          ),
          ElevatedButton(
              style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(Colors.red),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18.0),
                  ))),
              onPressed: () async{
                await alertDialog(context);

                //
              },
              child: const Text('مسح الفاتورة'))
        ],
      ),
    );
  }

  alertDialog(BuildContext context)async{
    await Alert(
                  context: context,
                  type: AlertType.error,
                  title: "تنبيه",
                  desc: "هل انت متأكد من حذف الفاتوره",
                  buttons: [
                    DialogButton(
                      onPressed: () {
                        FirebaseHelper().deleteUser(invoice!.id,invoice!.imageUrl);
                        Navigator.of(context).pop();
                        Navigator.of(context).pop();
                        showSnakBarSuccess(context,AppStrings.deleteMessage,redColor);
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
