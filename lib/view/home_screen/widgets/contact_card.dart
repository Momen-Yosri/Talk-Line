import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ContactCard extends StatelessWidget {
  final String name;
  final String email;
  final String image;
  const ContactCard({super.key,required this.name,required this.email,required this.image});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){},
      child: Column(
        children: [
          Padding(
            padding: REdgeInsets.symmetric(vertical: 20.0),
            child: Row(children: [
              CircleAvatar(
                backgroundImage: AssetImage(image),
                radius: 30.r,
              ),
              SizedBox(width: 16.w),Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(name,style: Theme.of(context).textTheme.bodyLarge,),
                  Text(email,style: Theme.of(context).textTheme.bodyMedium),
                ],
              )]
              ),
          ),
           
            Divider(),
        ],
      ),
    );
  }
}