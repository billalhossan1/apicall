import 'package:abaksirlabapi/models/user_details_model.dart';
import 'package:abaksirlabapi/networkcaller.dart';
import 'package:flutter/material.dart';

import 'widget/person.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<UserDetails> users = [];

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("User List")),
      body: Column(
        children: [
          Expanded(
            child: users.isEmpty
                ? const Center(child: CircularProgressIndicator())
                : ListView.builder(
              itemCount: users.length,
              itemBuilder: (context, index) {
                return Person(userDetails: users[index]);
              },
            ),
          ),
        ],
      ),
    );
  }

  void getData() async {
    final response = await NetworkCaller.getRequest(
      'https://jsonplaceholder.typicode.com/users',
    );

    if (response.isSuccess) {
      List<dynamic> jsonList = response.responseData;
      setState(() {
        users = jsonList.map((e) => UserDetails.fromJson(e)).toList();
      });
    } else {
      print('Failed to fetch data: ${response.statusCode}');
    }
  }
}
