import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../../controllers/home_controller.dart';
import '../../city_model.dart';

class CityDropdownSearch extends GetView<HomeController> {
  const CityDropdownSearch({
    Key? key,
    required this.provId,
    required this.tipe,
  }) : super(key: key);

  final int provId;
  final String tipe;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: DropdownSearch<City>(
        onFind: (String filter) async {
          Uri url = Uri.parse(
              "https://api.rajaongkir.com/starter/city?province=$provId");

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

            var listAllCity = data["rajaongkir"]["results"] as List<dynamic>;

            var models = City.fromJsonList(listAllCity);
            return models;
          } catch (err) {
            return List<City>.empty();
          }
        },
        popupItemBuilder: (context, item, isSelected) {
          return Container(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Text(
              "${item.type} ${item.cityName}",
              style: TextStyle(
                fontSize: 18,
              ),
            ),
          );
        },
        itemAsString: (item) => "${item.type} ${item.cityName}",
        label: tipe == "asal"
            ? "Kota / Kabupaten Asal"
            : "Kota / Kabupaten Tujuan",
        hint: tipe == "asal"
            ? "Pilih Kota / Kabupaten Asal"
            : "Pilih Kota / Kabupaten Tujuan",
        onChanged: (city) {
          if (city != null) {
            if (tipe == 'asal') {
              controller.cityIdAsal.value = int.parse(city.cityId!);
            } else {
              controller.cityIdTujuan.value = int.parse(city.cityId!);
            }
          } else {
            if (tipe == 'asal') {
              print('No City Asal Selected');
              controller.cityIdTujuan.value = 0;
            } else {
              print('No City Tujuan Selected');
              controller.cityIdTujuan.value = 0;
            }
          }
          controller.showButton();
        },
        showClearButton: true,
        showSearchBox: true,
        mode: Mode.MENU,
        searchBoxDecoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          hintText: "Cari Kota / Kabupaten",
          prefixIcon: Icon(Icons.search),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(4),
          ),
        ),
      ),
    );
  }
}
