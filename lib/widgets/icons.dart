import 'package:flutter/material.dart';
import 'package:getx_todo_list/app/core/values/icons.dart';

List<Icon> getIcons(){
 return const [
  Icon(IconData(personIcon, fontFamily: 'MaterialIcons'),color: Colors.purple),
  Icon(IconData(workIcon, fontFamily: 'MaterialIcons'),color: Colors.orange),
  Icon(IconData(movieIcon, fontFamily: 'MaterialIcons'),color: Colors.green),
  Icon(IconData(sportIcon, fontFamily: 'MaterialIcons'),color: Color.fromARGB(255, 255, 204, 0)),
  Icon(IconData(travelIcon, fontFamily: 'MaterialIcons'),color: Colors.pink),
  Icon(IconData(shopIcon, fontFamily: 'MaterialIcons'),color: Colors.blue),
 ];
}