import 'package:elnemr_invoice/core/strings.dart';
import 'package:elnemr_invoice/data/data_source/remot/firebase_manager.dart';
import 'package:elnemr_invoice/data/models/user_model.dart';
import 'package:elnemr_invoice/screens/detailes_screen/detailes_screen.dart';
import 'package:flutter/material.dart';
import '../../core/colors.dart';
import '../../core/constants.dart';
import 'home_widgets.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      displacement: 100,
      onRefresh: () async{
        setState(() {
          
        });
      },
      child: Scaffold(
        extendBody: true,
        extendBodyBehindAppBar: true,
        appBar: const PreferredSize(
          preferredSize: Size.fromHeight(100),
          child: HomeAppBar(),
        ),
        body: FutureBuilder(
          future: FirebaseHelper().getInvoicesFromFirestore(),
          builder: (context, snapshot) {
            List<Invoice?> list=snapshot.data??[];
            if(snapshot.connectionState==ConnectionState.waiting){
              return const Center(child: CircularProgressIndicator());
            }
            else if(list.isEmpty){
              return  Center(child: Text(AppStrings.noInvoiceExist));
            }
            else if(snapshot.hasError){
              return  Center(child: Text(AppStrings.hasErrorMessage));
            }
           
        
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 3, vertical: 4),
              child: ListView.separated(
                  itemBuilder: (context, index) => SizedBox(
                        height: 120,
                        child: InkWell(
                          onTap: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context) => const DetailesScreen(),));
                          },
                          child: Card(
                            child: Row(
                              textDirection: TextDirection.rtl,
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              //crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                  children: [
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width*0.60,
                                        child: Text(
                                      list[index]!.name,
                                      style: Theme.of(context).textTheme.headline1,
                                      textDirection: TextDirection.rtl,
                                    )),
                                    Text(
                                      list[index]!.date.toString(),
                                    ),
                                  ],
                                ),
                                Container(
                                  width: 130,
                                  padding: const EdgeInsets.symmetric(horizontal:5,vertical: 10 ),
                                  decoration: BoxDecoration(
                                    color: cyanColor,
                                    borderRadius: BorderRadius.circular(20)
                                  ),
                                  child: Text(
                                    'Total : ${list[index]!.total} EGP',
                                    overflow: TextOverflow.ellipsis,
                                    style: Theme.of(context)
                                        .textTheme
                                        .headline2
                                        ?.copyWith(color: whiteColor),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                  separatorBuilder: (context, index) => const SizedBox(height: 5),
                  itemCount: list.length),
            );
          }
        ),
      ),
    );
  }
}
