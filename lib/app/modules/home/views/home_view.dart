import 'dart:convert';

import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:get/get.dart';
import 'package:ongkir/app/modules/home/city_model.dart';
import 'package:ongkir/app/modules/home/province_model.dart';

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
            ProvinceDropdownSearch(),
            Obx(() => controller.hiddenKota.isTrue
                ? SizedBox()
                : CityDropdownSearch(
                    provId: controller.provId.value,
                  ))
          ],
        ));
  }
}

class CityDropdownSearch extends StatelessWidget {
  const CityDropdownSearch({
    Key? key,
    required this.provId,
  }) : super(key: key);

  final int provId;

  @override
  Widget build(BuildContext context) {
    return DropdownSearch<City>(
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
      label: "Kota / Kabupaten Asal",
      hint: "Pilih Kota / Kabupaten Asal",
      onChanged: (city) {
        if (city != null) {
          print(city.cityName);
        } else {
          print("No City Selected");
        }
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
    );
  }
}

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
