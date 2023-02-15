import 'package:flutter/material.dart';

import '../../core/colors.dart';
import '../../core/strings.dart';

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
        icon:  ImageIcon(const AssetImage('assets/images/bill.png'),color:blackColor,),
        onPressed: () {},
      ),
      actions: [
        IconButton(
          iconSize: 30,
          icon: Icon(
            Icons.search,
            color: blackColor,
          ),
          onPressed: () {},
        )
      ],
    );
  }
}
