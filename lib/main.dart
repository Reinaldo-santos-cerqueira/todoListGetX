import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_todo_list/data/service/storage/services.dart';
import 'package:getx_todo_list/modules/home/view.dart';
import 'package:get_storage/get_storage.dart';

void main() async {
  await GetStorage.init();
  await Get.putAsync(()=> StorageService().init());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const GetMaterialApp(
      title: "Todo list with getx",
      home: HomePage(),
    );
  }
}