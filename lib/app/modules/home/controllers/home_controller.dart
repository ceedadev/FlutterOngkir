import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  var hiddenKotaAsal = true.obs;
  var provIdAsal = 0.obs;
  var cityIdAsal = 0.obs;
  var hiddenKotaTujuan = true.obs;
  var provIdTujuan = 0.obs;
  var cityIdTujuan = 0.obs;

  double berat = 0.0;
  String satuan = 'gram';

  late TextEditingController beratC;

  void convertBerat(String value) {
    berat = double.tryParse(value) ?? 0.0;
    String cekSatuan = satuan;

    switch (cekSatuan) {
      case 'Kilogram':
        berat = berat * 1000;
        break;
      case 'gram':
        berat = berat * 1;
        break;
      case 'lbs':
        berat = berat * 2204.62;
        break;
      default:
        berat = berat;
    }
    print("${berat} gram");
  }

  void ubahSatuan(String value) {
    berat = double.tryParse(beratC.text) ?? 0.0;
    switch (value) {
      case 'Kilogram':
        berat = berat * 1000;
        break;
      case 'gram':
        berat = berat * 1;
        break;
      case 'lbs':
        berat = berat * 2204.62;
        break;
      default:
        berat = berat;
    }
    satuan = value;
    print(value);
  }

  @override
  void onInit() {
    beratC = TextEditingController(text: '$berat');
    super.onInit();
  }

  @override
  void onClose() {
    beratC.dispose();
    super.onClose();
  }
}
