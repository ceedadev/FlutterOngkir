import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../cost_model.dart';

class HomeController extends GetxController {
  var hiddenKotaAsal = true.obs;
  var provIdAsal = 0.obs;
  var cityIdAsal = 0.obs;
  var hiddenKotaTujuan = true.obs;
  var provIdTujuan = 0.obs;
  var cityIdTujuan = 0.obs;
  var kurir = "".obs;
  var hiddenButton = true.obs;

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

  void showButton() {
    if (cityIdAsal != 0 && cityIdTujuan != 0 && berat > 0 && kurir != "") {
      hiddenButton.value = false;
    } else {
      hiddenButton.value = true;
    }
  }

  void ongkosKirim() async {
    Uri url = Uri.parse("https://api.rajaongkir.com/starter/cost");
    try {
      final response = await http.post(
        url,
        headers: {
          "key": "fd1816b4ba35f38e256ad2c271fadef3",
        },
        body: {
          "origin": "$cityIdAsal",
          "destination": "$cityIdTujuan",
          "weight": "$berat",
          "courier": "$kurir",
        },
      );

      var data = json.decode(response.body) as Map<String, dynamic>;
      var results = data["rajaongkir"]["results"];

      var listAllResult = Cost.fromJsonList(results);
      var cost1 = listAllResult[0];

      Get.defaultDialog(
        title: cost1.name.toString(),
        content: Column(
          children: cost1.costs!
              .map((i) => ListTile(
                    title: Text("${i.service}"),
                    subtitle: Text("Rp ${i.cost![0].value}"),
                    trailing: Text(cost1.code == 'pos'
                        ? "${i.cost![0].etd}"
                        : "${i.cost![0].etd} Hari"),
                  ))
              .toList(),
        ),
      );
    } catch (err) {
      print(err);
      Get.defaultDialog(
        title: "Terjadi Kesalahan",
        middleText: err.toString(),
      );
    }
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
