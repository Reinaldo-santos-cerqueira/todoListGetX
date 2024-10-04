import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:getx_todo_list/app/core/utils/extensions.dart';
import 'package:getx_todo_list/modules/detail/widgets/doing_list.dart';
import 'package:getx_todo_list/modules/detail/widgets/done_list.dart';
import 'package:getx_todo_list/modules/home/controller.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';

class DetailsPage extends StatelessWidget {
  final homeController = Get.find<HomeController>();
  DetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    var task = homeController.task.value!;
    var color = HexColor.fromHex(task.color);
    return Scaffold(
      backgroundColor: Colors.white,
      body: Form(
        key: homeController.formKey,
        child: ListView(
          children: [
            Padding(
              padding: EdgeInsets.all(3.0.wp),
              child: Row(
                children: [
                  IconButton(
                      onPressed: () {
                        homeController.updateTodos();
                        homeController.changeTask(null);
                        homeController.editController.clear();
                        Get.back();
                      },
                      icon: const Icon(Icons.arrow_back)),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.0.wp),
              child: Row(
                children: [
                  Icon(
                    IconData(task.icon, fontFamily: 'MaterialIcons'),
                    color: color,
                  ),
                  SizedBox(
                    height: 3.0.wp,
                  ),
                  Text(
                    task.title,
                    style: TextStyle(
                        fontSize: 12.0.sp, fontWeight: FontWeight.bold),
                  )
                ],
              ),
            ),
            Padding(
              padding:
                  EdgeInsets.only(top: 5.0.wp, left: 16.0.wp, right: 16.0.wp),
              child: Obx(() {
                var totalTodos = homeController.doingTodos.length +
                    homeController.doneTodos.length;
                return Row(
                  children: [
                    Text(
                      "$totalTodos Tasks",
                      style: TextStyle(fontSize: 12.0.sp, color: Colors.grey),
                    ),
                    SizedBox(width: 3.0.wp),
                    Expanded(
                        child: StepProgressIndicator(
                      totalSteps: totalTodos == 0 ? 1 : totalTodos,
                      currentStep: homeController.doneTodos.length,
                      size: 5,
                      padding: 0,
                      selectedGradientColor: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [color.withOpacity(.5), color]),
                      unselectedGradientColor: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [Colors.grey[300]!, Colors.grey[300]!]),
                    ))
                  ],
                );
              }),
            ),
            Padding(
              padding:
                  EdgeInsets.symmetric(horizontal: 5.0.wp, vertical: 2.0.wp),
              child: TextFormField(
                controller: homeController.editController,
                autofocus: true,
                decoration: InputDecoration(
                  prefixIcon: Icon(
                    Icons.check_box_outline_blank,
                    color: Colors.grey[400],
                  ),
                  suffixIcon: IconButton(
                      onPressed: () {
                        var success = homeController
                            .addTodo(homeController.editController.text);
                        if (success) {
                          EasyLoading.showSuccess("Todo item success");
                        } else {
                          EasyLoading.showError("Todo item already exist");
                        }
                      },
                      icon: const Icon(Icons.done)),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey[400]!),
                  ),
                ),
              ),
            ),
            Center(child:  DoingList()),
            
          ],
        ),
      ),
    );
  }
}
