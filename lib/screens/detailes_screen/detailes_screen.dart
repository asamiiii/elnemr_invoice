import 'package:flutter/material.dart';
import '../../core/colors.dart';
import '../../core/constants.dart';

class DetailesScreen extends StatelessWidget {
  const DetailesScreen({super.key});

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
                      ' أحمد سامي محمد محمود',
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
              Image.asset(
                'assets/images/test_Invoice.png',
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
              'Total : ${dummyUsersData[1].total} EGP',
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
              onPressed: () {},
              child: const Text('مسح الفاتورة'))
        ],
      ),
    );
  }
}
