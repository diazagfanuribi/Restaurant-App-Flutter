import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:restaurant_app/data/restaurant.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  test('Check json parse from API work', () async {
    final response = await rootBundle.loadString('assets/list_restauran.json');
    Result output = Result.fromJson(json.decode(response));

    var id = [
      "rqdv5juczeskfw1e867",
      "s1knt6za9kkfw1e867",
      "w9pga3s2tubkfw1e867",
      "uewq1zg2zlskfw1e867",
      "ygewwl55ktckfw1e867",
      "fnfn8mytkpmkfw1e867",
      "dwg2wt3is19kfw1e867",
      "6u9lf7okjh9kfw1e867",
      "zvf11c0sukfw1e867",
      "ughslf146iqkfw1e867",
      "w7jca3irwykfw1e867",
      "8maika7giinkfw1e867",
      "e1elb86snf8kfw1e867",
      "69ahsy71a5gkfw1e867",
      "ateyf7m737ekfw1e867",
      "02hfwn4bh8uzkfw1e867",
      "p06p0wr8eedkfw1e867",
      "uqzwm2m981kfw1e867",
      "dy62fuwe6w8kfw1e867",
      "vfsqv0t48jkfw1e867"
    ];

    for (var json in output.restaurants) {
      print(id.contains(json.id));
      expect(true, id.contains(json.id));
    } // Skenario pengujian dituliskan di sini
  });
}
