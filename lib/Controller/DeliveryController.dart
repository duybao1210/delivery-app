import 'dart:convert';
import 'package:http/http.dart' as http;
import '/Helpers/secure_storage.dart';
import '/Models/Response/GetAllDeliveryResponse.dart';
import '/Models/Response/OrdersByStatusResponse.dart';
import '/Services/url.dart';


class DeliveryController {


  Future<List<Delivery>?> getAlldelivery() async {

    final token = await secureStorage.readToken();

    final resp = await http.get(Uri.parse('${URLS.URL_API}/get-all-delivery'),
        headers: { 'Accept' : 'application/json', 'xx-token' : token! }
    );

    return GetAllDeliveryResponse.fromJson( jsonDecode( resp.body ) ).delivery;
  }


  Future<List<OrdersResponse>?> getOrdersForDelivery(String statusOrder) async {

    final token = await secureStorage.readToken();

    final resp = await http.get(Uri.parse('${URLS.URL_API}/get-all-orders-by-delivery/' + statusOrder),
        headers: { 'Accept' : 'application/json', 'xx-token' : token! }
    );

    return OrdersByStatusResponse.fromJson( jsonDecode( resp.body ) ).ordersResponse;

  }



}

final deliveryController = DeliveryController();