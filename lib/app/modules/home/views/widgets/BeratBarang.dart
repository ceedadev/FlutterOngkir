import 'package:Ongkir/app/modules/home/controllers/home_controller.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

class BeratBarang extends GetView<HomeController> {
  const BeratBarang({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: controller.beratC,
              autocorrect: false,
              keyboardType: TextInputType.numberWithOptions(decimal: true),
              decoration: InputDecoration(
                labelText: "Berat Barang",
                hintText: 'Masukkan Berat Barang',
                border: OutlineInputBorder(),
              ),
              onChanged: (value) => controller.convertBerat(value),
            ),
          ),
          SizedBox(width: 10),
          Container(
            width: 150,
            child: DropdownSearch<String>(
              mode: Mode.BOTTOM_SHEET,
              showSelectedItem: true,
              items: ['Kilogram', 'gram', 'lbs'],
              label: "Satuan",
              selectedItem: 'Kilogram',
              onChanged: (value) => controller.ubahSatuan(value!),
            ),
          )
        ],
      ),
    );
  }
}
