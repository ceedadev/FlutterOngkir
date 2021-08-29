import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import './widgets/BeratBarang.dart';
import './widgets/CityDropdownSearch.dart';
import './widgets/ProvinceDropdownSearch.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Ongkos Kirim Indonesia'),
        centerTitle: true,
        backgroundColor: Colors.red[800],
      ),
      body: ListView(
        padding: EdgeInsets.all(20),
        children: [
          ProvinceDropdownSearch(tipe: 'asal'),
          Obx(
            () => controller.hiddenKotaAsal.isTrue
                ? SizedBox()
                : CityDropdownSearch(
                    provId: controller.provIdAsal.value,
                    tipe: 'asal',
                  ),
          ),
          ProvinceDropdownSearch(tipe: 'tujuan'),
          Obx(
            () => controller.hiddenKotaTujuan.isTrue
                ? SizedBox()
                : CityDropdownSearch(
                    provId: controller.provIdTujuan.value,
                    tipe: 'tujuan',
                  ),
          ),
          BeratBarang(),
          DropdownSearch<Map<String, dynamic>>(
            mode: Mode.MENU,
            showClearButton: true,
            items: [
              {"code": "jne", "display": "Jalur Nugraha Ekakurir (JNE)"},
              {"code": "tiki", "display": "Titipan Kilat (TiKi)"},
              {"code": "pos", "display": "Pos Indonesia "},
            ],
            label: "Ekspedisi",
            hint: "Pilih Jasa Ekspedisi",
            onChanged: (value) {
              if (value != null) {
                controller.kurir.value = value['code'];
                controller.showButton();
              } else {
                controller.hiddenButton.value = true;
                controller.kurir.value = '';
              }
            },
            popupItemBuilder: (context, item, isSelected) => Container(
              padding: EdgeInsets.all(20),
              child: Text(
                "${item['display']}",
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.black,
                ),
              ),
            ),
            itemAsString: (item) => "${item['display']}",
          ),
          Obx(() => controller.hiddenButton.isTrue
              ? SizedBox()
              : Padding(
                  padding: const EdgeInsets.only(top: 40),
                  child: ElevatedButton(
                    onPressed: () => controller.ongkosKirim(),
                    child: Text("Cek Ongkos Kirim"),
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(vertical: 20),
                      primary: Colors.red[800],
                    ),
                  ),
                ))
        ],
      ),
    );
  }
}
