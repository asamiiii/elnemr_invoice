import 'package:elnemr_invoice/data/models/user_model.dart';
import 'package:elnemr_invoice/screens/search_screen.dart/search_screen.dart';
import 'package:flutter/material.dart';
import 'dart:ui' as ui;
import 'package:intl/intl.dart';
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
          child: Text(AppStrings.appName, maxLines: 1, softWrap: false,style:GoogleFonts.notoKufiArabic(),)),
      
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
            onPressed: (context) {},
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
                color: nemrYellow,
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
            Container(
              margin: const EdgeInsets.only(right: 10, left: 10),
              width: 150,
              height: MediaQuery.of(context).size.height * 0.05,
              decoration: BoxDecoration(
                  color: blackColor, borderRadius: BorderRadius.circular(10)),
              child: Center(child: Text('حساب : ${invoice!.total}ج',style:Theme.of(context).textTheme.headline2?.copyWith(color:whiteColor,overflow: TextOverflow.ellipsis ),textDirection: ui.TextDirection.rtl,)),
            )
          ],
        ),
      ),
    );
  }
}
