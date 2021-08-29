import 'package:http/http.dart' as http;

// void main() async {
//   Uri url = Uri.parse("https://api.rajaongkir.com/starter/province");
//   final response =
//       await http.get(url, headers: {"key": "fd1816b4ba35f38e256ad2c271fadef3"});

//   print(response.body);
// }

void main() async {
  Uri url = Uri.parse("https://api.rajaongkir.com/starter/cost");
  final response = await http.post(
    url,
    headers: {
      "key": "fd1816b4ba35f38e256ad2c271fadef3",
    },
    body: {
      "origin": "501",
      "destination": "114",
      "weight": "1200",
      "courier": "jne",
    },
  );

  print(response.body);
}
