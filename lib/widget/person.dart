import 'package:abaksirlabapi/models/user_details_model.dart';
import 'package:flutter/material.dart';

class Person extends StatelessWidget {
  final UserDetails userDetails;
  const Person({
    super.key, required this.userDetails,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Text(userDetails.name!,style: TextStyle(fontSize: 22,fontWeight: FontWeight.bold),),
          Text(userDetails.email!,style: TextStyle(fontSize: 12,),),
          Text(userDetails.address!.street!),
          ElevatedButton(onPressed: (){}, child: Text('Details'))
        ],
      ),
    );
  }
}