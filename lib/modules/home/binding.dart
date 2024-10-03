import 'package:get/get.dart';
import 'package:getx_todo_list/data/providers/task/provider.dart';
import 'package:getx_todo_list/data/service/storage/repository.dart';
import 'package:getx_todo_list/modules/home/controller.dart';

class HomeBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(
      () => HomeController(taskRepository: TaskRepository(taskProvider: TaskProvider()))
    );
  }
}