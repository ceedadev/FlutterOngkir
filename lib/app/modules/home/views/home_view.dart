import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Ongkos Kirim Indonesia'),
          centerTitle: true,
        ),
        body: ListView(
          padding: EdgeInsets.all(20),
          children: [
            DropdownSearch<String>(
              showClearButton: true,
              showSearchBox: true,
              mode: Mode.MENU,
              items: [
                "Banten",
                "DKI Jakarta",
                "Jawa Barat",
                "Jawa Tengah",
                "Jawa Timur"
              ],
              label: "Provinsi Asal",
              hint: "Pilih Provinsi Asal",
              onChanged: (value) => print(value),
              searchBoxDecoration: InputDecoration(
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                hintText: "Cari Provinsi",
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
            ),
          ],
        ));
  }
}
