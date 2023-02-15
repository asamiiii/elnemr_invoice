import 'package:flutter/material.dart';
import '../../core/constants.dart';
import 'home_widgets.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      extendBody: true,
      extendBodyBehindAppBar:true ,
      appBar:const PreferredSize(
        preferredSize: Size.fromHeight(100),
        child: HomeAppBar(),
      ),

      body: ListView.separated(
        itemBuilder: (context, index) =>  SizedBox(
          height: 100,
          //width: MediaQuery.of(context).size.width*0.20,
          //width: 200,
          child: Card(
          child: Row(
            textDirection:TextDirection.rtl ,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            //crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Expanded(child: Text(dummyUsersData[index].name,style:Theme.of(context).textTheme.headline1,)),
                  Text(dummyUsersData[index].date.toString(),),
                  
                ],
                
              ),
                Text('Total : ${dummyUsersData[index].total} EGP',style:Theme.of(context).textTheme.headline2?.copyWith(color:Colors.redAccent ),),
            ],
          ),
          ),
        ),
         separatorBuilder: (context, index) => const SizedBox(height: 5),
          itemCount: dummyUsersData.length),

    );
  }
}