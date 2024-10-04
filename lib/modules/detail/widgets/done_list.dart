import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_todo_list/app/core/utils/extensions.dart';
import 'package:getx_todo_list/modules/home/controller.dart';

class DoneList extends StatelessWidget {
  final homeController = Get.find<HomeController>();
  DoneList({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      ()=> homeController.doingTodos.isEmpty && homeController.doneTodos.isEmpty
        ? Column(
          children: [
            Image.asset('assets/images/task.png', fit: BoxFit.cover,width: 100.0.wp,),
            Text(
              "Add task",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16.0.sp
              ),
            )
          ]
        )
        : const Text("Have task")
    );
  }
}