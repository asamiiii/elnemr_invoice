import 'dart:io';
import 'package:elnemr_invoice/data/models/user_model.dart';
import 'package:elnemr_invoice/screens/add_invoice_screen/add_invoice_screen.dart';
import 'package:elnemr_invoice/screens/search_screen.dart/search_screen.dart';
import 'package:path/path.dart' as p;
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../../core/colors.dart';
import '../../core/strings.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

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
          child: Text(AppStrings.appName, maxLines: 1, softWrap: false)),
      leading: IconButton(
        iconSize: 30,
        icon: ImageIcon(
          const AssetImage('assets/images/bill.png'),
          color: blackColor,
        ),
        onPressed: () async {
          final pickedFile = await ImagePicker().pickImage(
            source: ImageSource.camera,
            //maxHeight: 400,
            //maxWidth: 300,
            imageQuality: 70,
          );
          if (pickedFile != null) {
            final imageFile = File(pickedFile.path);
            //debugPrint(p.basename(pickedFile.path));
            // ignore: use_build_context_synchronously
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AddInoviceScreen(
                      image: imageFile, imagePath: p.basename(pickedFile.path)),
                ));
          } else {
            debugPrint('No image selected.');
          }
        },
      ),
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
    return Slidable(
      key: const Key('d'),
      startActionPane: ActionPane(
        motion: const ScrollMotion(),
        children: [
          SlidableAction(
            onPressed: (context) {},
            backgroundColor: cyanColor,
            foregroundColor: Colors.white,
            icon: Icons.edit,
            label: 'تعديل',
            borderRadius: BorderRadius.circular(20),
            autoClose: true,
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
          textDirection: TextDirection.rtl,

          children: [
            Container(
              margin: const EdgeInsets.all(20),
              width: 5,
              height: MediaQuery.of(context).size.height * 50,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: greenColor,
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
                      style: Theme.of(context).textTheme.headline1,
                      textDirection: TextDirection.rtl,
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Row(
                    textDirection: TextDirection.rtl,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const Icon(
                        Icons.more_time_rounded,
                        color: Colors.black,
                        textDirection: TextDirection.rtl,
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Expanded(
                          child: Text(
                        '${invoice!.date}',
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.headline3,
                        textDirection: TextDirection.rtl,
                      ))
                    ],
                  )
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.only(right: 10, left: 10),
              width: 70,
              height: MediaQuery.of(context).size.height * 0.05,
              decoration: BoxDecoration(
                  color: greenColor, borderRadius: BorderRadius.circular(10)),
              child: Center(child: Text(invoice!.total)),
            )
          ],
        ),
      ),
    );
  }
}
