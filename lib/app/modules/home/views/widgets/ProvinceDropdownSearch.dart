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
    required this.tipe,
  }) : super(key: key);

  final String tipe;

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
        label: tipe == "asal" ? "Provinsi Asal" : "Provinsi Tujuan",
        hint: tipe == "asal" ? "Pilih Provinsi Asal" : "Pilih Provinsi Tujuan",
        onChanged: (prov) {
          if (prov != null) {
            if (tipe == 'asal') {
              controller.hiddenKotaAsal.value = false;
              controller.provIdAsal.value = int.parse(prov.provinceId!);
            } else {
              controller.hiddenKotaTujuan.value = false;
              controller.provIdTujuan.value = int.parse(prov.provinceId!);
            }
          } else {
            if (tipe == 'asal') {
              controller.hiddenKotaAsal.value = true;
              controller.provIdAsal.value = 0;
            } else {
              controller.hiddenKotaTujuan.value = true;
              controller.provIdTujuan.value = 0;
            }
          }
          controller.showButton();
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
