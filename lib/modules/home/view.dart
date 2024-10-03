import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:getx_todo_list/data/models/task.dart';
import 'package:getx_todo_list/modules/home/controller.dart';
import 'package:getx_todo_list/app/core/utils/extensions.dart';
import 'package:getx_todo_list/modules/home/widgets/add_card.dart';
import 'package:getx_todo_list/modules/home/widgets/task_card.dart';

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
          ),
          Obx(
            () => GridView.count(
              crossAxisCount: 2,
              shrinkWrap: true,
              physics: const ClampingScrollPhysics(),
              children: [
                ...controller.tasks.map((element) => LongPressDraggable<Task>(
                    data: element, // Certifique-se de que a tarefa está sendo passada
                    onDragStarted: () {
                      controller.changeDeleting(true);
                    },
                    onDraggableCanceled: (_, __) {
                      controller.changeDeleting(false);
                    },
                    onDragEnd: (_) {
                      controller.changeDeleting(false);
                    },
                    feedback: Opacity(
                      opacity: 0.8,
                      child: TaskCard(task: element),
                    ),
                    child: TaskCard(task: element))),
                AddCard()
              ],
            ),
          )
        ],
      )),
      floatingActionButton: DragTarget<Task>(
        builder: (_, __, ___) {
          return Obx(() => FloatingActionButton(
              backgroundColor:
                  controller.deleting.value ? Colors.red : Colors.blue,
              onPressed: () {},
              child: controller.deleting.value
                  ? const Icon(Icons.delete_outline, color: Colors.white)
                  : const Icon(Icons.add, color: Colors.white)));
        },
        onAcceptWithDetails: (DragTargetDetails<Task> task) {
          controller.deleteTask(task.data);
          EasyLoading.showSuccess("Delete success");
        },
      ),
    );
  }
}
