import 'package:flutter_test/flutter_test.dart';
import 'package:restaurant_app/data/api/api_service..dart';
import 'package:restaurant_app/provider/restaurant_provider.dart';

void main() {
  test('Check detail restaurant by id json parse from API', () async {
    var provider = RestaurantProvider(apiService: ApiService());

    var ids = [
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

    for (var id in ids) {
      await provider.fetchDetailRestaurant(id);
      var result = provider.detail.restaurant.id == id;
      print(result);
      expect(true, result);
    } // Skenario pengujian dituliskan di sini
  });
}
