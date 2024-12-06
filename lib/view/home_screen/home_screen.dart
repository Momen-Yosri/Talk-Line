import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:talk_line/view/home_screen/widgets/contact_card.dart';

class HomeScreen extends StatelessWidget {
    static const String routeName="home_screen";

  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(leading: Padding(
        padding: REdgeInsets.all(10.0),
        child: Image.asset("assets/Ellipse 5.png"),
      ),title:Text("Jira Mo'men",style: Theme.of(context).textTheme.titleMedium,),actions: [IconButton(icon:Icon(Icons.add),color: Colors.white, onPressed: () {  }),SizedBox(width: 10.w,),IconButton(icon:Icon(Icons.notifications),color: Colors.white, onPressed: () {  },),SizedBox(width: 25.w,)],),
      body: Padding(
        padding: REdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            ContactCard(image:"assets/Ellipse 5.png" ,name:"keko" ,email:"keko@jira.com"),
            ContactCard(image:"assets/Ellipse 5.png" ,name:"keko" ,email:"keko@jira.com"),
          ],
        ),
      )
    ) ;
  }
}