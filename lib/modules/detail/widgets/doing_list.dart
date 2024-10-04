import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_todo_list/app/core/utils/extensions.dart';
import 'package:getx_todo_list/modules/home/controller.dart';

class DoingList extends StatelessWidget {
  final homeController = Get.find<HomeController>();
  DoingList({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() => homeController.doingTodos.isEmpty &&
            homeController.doneTodos.isEmpty
        ? Column(
            children: [
              Image.asset(
                'assets/images/task.png',
                fit: BoxFit.cover,
                width: 65.0.wp,
              ),
              Text(
                "Add task",
                style:
                    TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0.sp),
              )
            ],
          )
        :   ListView(
          shrinkWrap: true,
          physics: const  ClampingScrollPhysics(),
          children: [
            ...homeController.doingTodos.map((e)=>
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 9.0.wp, vertical: 3.0.wp),
                child: Row(
                  children: [
                    SizedBox(
                      width: 20,
                      height: 20,
                      child: Checkbox(
                        value: e['done'], 
                        onChanged: (value){
                          homeController.doneTodo(e['title']);
                        }
                      ),
                    ),
                    Text(
                      e['title'],
                      overflow: TextOverflow.ellipsis,
                    )
                  ],
                ),
              )
            ).toList()
          ],
        )
      );
  }
}
