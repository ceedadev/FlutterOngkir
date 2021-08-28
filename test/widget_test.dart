import 'package:http/http.dart' as http;

void main() async {
  Uri url = Uri.parse("https://api.rajaongkir.com/starter/province");
  final response =
      await http.get(url, headers: {"key": "fd1816b4ba35f38e256ad2c271fadef3"});

  print(response.body);
}
