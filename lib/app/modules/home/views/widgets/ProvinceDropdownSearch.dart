import 'dart:convert';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../../controllers/home_controller.dart';
import '../../province_model.dart';

class ProvinceDropdownSearch extends GetView<HomeController> {
  const ProvinceDropdownSearch({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: DropdownSearch<Province>(
        onFind: (String filter) async {
          Uri url = Uri.parse("https://api.rajaongkir.com/starter/province");

          try {
            final response = await http.get(
              url,
              headers: {"key": "fd1816b4ba35f38e256ad2c271fadef3"},
            );

            var data = json.decode(response.body) as Map<String, dynamic>;

            var statusCode = data["rajaongkir"]["status"]["code"];
            var statusDesc = data["rajaongkir"]["status"]["description"];

            if (statusCode != 200) {
              throw statusDesc;
            }

            var listAllProvince = data["rajaongkir"]["results"];

            var models = Province.fromJsonList(listAllProvince);
            return models;
          } catch (err) {
            return List<Province>.empty();
          }
        },
        popupItemBuilder: (context, item, isSelected) {
          return Container(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Text(
              "${item.province}",
              style: TextStyle(
                fontSize: 18,
              ),
            ),
          );
        },
        itemAsString: (item) => item.province!,
        label: "Provinsi Asal",
        hint: "Pilih Provinsi Asal",
        onChanged: (prov) {
          if (prov != null) {
            controller.hiddenKota.value = false;
            controller.provId.value = int.parse(prov.provinceId!);
            print(prov.province);
          } else {
            controller.hiddenKota.value = true;
            controller.provId.value = 0;
            print("No Selected Province");
          }
        },
        showClearButton: true,
        showSearchBox: true,
        mode: Mode.MENU,
        searchBoxDecoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          hintText: "Cari Provinsi",
          prefixIcon: Icon(Icons.search),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(4),
          ),
        ),
      ),
    );
  }
}
