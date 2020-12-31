import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:restaurant_app/data/api/api_service..dart';
import 'package:restaurant_app/data/restaurant.dart';
import 'package:restaurant_app/provider/restaurant_provider.dart';

class MockAoiService extends Mock implements ApiService {}

void main() {
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

  final response = {
    "error": false,
    "message": "success",
    "count": 20,
    "restaurants": [
      {
        "id": "rqdv5juczeskfw1e867",
        "name": "Melting Pot",
        "description":
            "Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. Aenean massa. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Donec quam felis, ultricies nec, pellentesque eu, pretium quis, sem. Nulla consequat massa quis enim. Donec pede justo, fringilla vel, aliquet nec, vulputate eget, arcu. In enim justo, rhoncus ut, imperdiet a, venenatis vitae, justo. Nullam dictum felis eu pede mollis pretium. Integer tincidunt. Cras dapibus. Vivamus elementum semper nisi. Aenean vulputate eleifend tellus. Aenean leo ligula, porttitor eu, consequat vitae, eleifend ac, enim. Aliquam lorem ante, dapibus in, viverra quis, feugiat a, tellus. Phasellus viverra nulla ut metus varius laoreet.",
        "pictureId": "14",
        "city": "Medan",
        "rating": 4.2
      },
      {
        "id": "s1knt6za9kkfw1e867",
        "name": "Kafe Kita",
        "description":
            "Quisque rutrum. Aenean imperdiet. Etiam ultricies nisi vel augue. Curabitur ullamcorper ultricies nisi. Nam eget dui. Etiam rhoncus. Maecenas tempus, tellus eget condimentum rhoncus, sem quam semper libero, sit amet adipiscing sem neque sed ipsum. Nam quam nunc, blandit vel, luctus pulvinar, hendrerit id, lorem. Maecenas nec odio et ante tincidunt tempus. Donec vitae sapien ut libero venenatis faucibus. Nullam quis ante. Etiam sit amet orci eget eros faucibus tincidunt. Duis leo. Sed fringilla mauris sit amet nibh. Donec sodales sagittis magna. Sed consequat, leo eget bibendum sodales, augue velit cursus nunc,",
        "pictureId": "25",
        "city": "Gorontalo",
        "rating": 4
      }
    ]
  };

  group("Provider Tests", () {
    ApiService apiService;
    RestaurantProvider provider;

    setUp(() {
      apiService = MockAoiService();
      provider = RestaurantProvider(apiService: apiService);
    });

    test('Check json parse from API work', () async {
      when(apiService.getListRestaurant())
          .thenAnswer((_) async => Result.fromJson(response));
      print("restaurant");
      await provider.fetchAllRestaurant();

      var result = provider.result;
      print(result);
      for (var json in result.restaurants) {
        print(id.contains(json.id));
        expect(true, id.contains(json.id));
      }
    });
  });
}
