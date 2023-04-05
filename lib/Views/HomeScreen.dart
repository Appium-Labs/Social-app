import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:get_storage/get_storage.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final prefs = GetStorage();
    String user = prefs.read("user_id").toString();
    print(user);
    return Scaffold(
      body: Text(user),
    );
  }
}
