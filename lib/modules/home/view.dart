import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_todo_list/modules/home/controller.dart';
import 'package:getx_todo_list/app/core/utils/extensions.dart';
class HomePage extends GetView<HomeController> {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          children: [
            Padding(
              padding: EdgeInsets.all(4.0.wp),
              child: Text(
                'My list',
                style: TextStyle(
                  fontSize: 24.0.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
            )
          ],
        )
      ),
    );
  }
}