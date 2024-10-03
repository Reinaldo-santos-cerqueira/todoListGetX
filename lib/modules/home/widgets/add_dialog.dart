import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:getx_todo_list/app/core/utils/extensions.dart';
import 'package:getx_todo_list/modules/home/controller.dart';

class AddDialog extends StatelessWidget {
  final homeCtrl = Get.find<HomeController>();
  AddDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: homeCtrl.formKey,
        child: ListView(
          children: [
            Padding(
              padding: EdgeInsets.all(3.0.wp),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                      onPressed: () {
                        Get.back();
                        homeCtrl.editController.clear();
                        homeCtrl.changeTask(null);
                      },
                      icon: const Icon(Icons.close)),
                  TextButton(
                    onPressed: () {
                      if(homeCtrl.formKey.currentState!.validate()){
                        if(homeCtrl.task.value == null){
                          EasyLoading.showError("Please select task type");
                        }else {
                          var success = homeCtrl.updateTask(
                            homeCtrl.task.value!,
                            homeCtrl.editController.text
                          );
                          if (success) {
                            EasyLoading.showSuccess("Todo item add success");
                            Get.back();
                          } else {
                            EasyLoading.showError("Todo already exists");
                          }
                          homeCtrl.editController.clear();
                        }
                      }
                    },
                    child: const Text("Done")
                  )
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 5.0.wp),
              child: Text(
                "New Task",
                style:
                    TextStyle(fontSize: 20.0.sp, fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 6.0.wp),
              child: TextFormField(
                controller: homeCtrl.editController,
                autofocus: true,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Please enter your todo item';
                  }
                  return null;
                },
                decoration: InputDecoration(
                    focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey[400]!))),
              ),
            ),
            Padding(
              padding:
                  EdgeInsets.symmetric(horizontal: 6.0.wp, vertical: 3.0.wp),
              child: Text(
                'Add to',
                style: TextStyle(fontSize: 14.0.sp, color: Colors.grey),
              ),
            ),
            ...homeCtrl.tasks.map((e) => Obx(
                  () => InkWell(
                    onTap: () {
                      homeCtrl.changeTask(e);
                    },
                    child: Padding(
                      padding: EdgeInsets.all(6.0.wp),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Icon(
                                  IconData(e.icon, fontFamily: 'MaterialIcons'),
                                  color: HexColor.fromHex(e.color)),
                                  SizedBox(width: 10.0.sp,),
                              Text(
                                e.title,
                                style: TextStyle(
                                    fontSize: 12.0.sp,
                                    fontWeight: FontWeight.bold),
                              )
                            ],
                          ),
                          if (homeCtrl.task.value == e)
                            const Icon(
                              Icons.check,
                              color: Colors.blue,
                            )
                        ],
                      ),
                    ),
                  ),
                ))
          ],
        ),
      ),
    );
  }
}
