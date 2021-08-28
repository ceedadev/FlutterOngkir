import 'package:flutter/material.dart';
import 'package:get/get.dart';

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
          ],
        ));
  }
}
