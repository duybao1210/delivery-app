import 'dart:convert';
import 'package:http/http.dart' as http;
import '/Helpers/secure_storage.dart';
import '/Models/ProductCart.dart';
import '/Models/Response/OrderDetailsResponse.dart';
import '/Models/Response/OrdersByStatusResponse.dart';
import '/Models/Response/OrdersClientResponse.dart';
import '/Models/Response/ResponseDefault.dart';
import '/Services/url.dart';


class OrdersController {


  Future<ResponseDefault> addNewOrders(int? uid,int? uidAddress, double? total, String? typePayment, List<ProductCart>? products) async {

    final token = await secureStorage.readToken();

    Map<String, dynamic>? data = {
      "uid" : uid,
      "uidAddress"  : uidAddress,
      "typePayment": typePayment,
      "total"       : total,
      "products"    : products
    };
    Map<String,String> headers = {'Content-Type':'application/json','xx-token' : token!};

    final body = jsonEncode(data);

    print(body);

    final resp = await http.post(Uri.parse('${URLS.URL_API}/add-new-orders'),
        headers: {'Content-Type':'application/json'},
        body: body
    );
    final body1 = jsonDecode((body));
    print(body1);

    return ResponseDefault.fromJson( jsonDecode( resp.body) );

  }


  Future<List<OrdersResponse>?> getOrdersByStatus( String status ) async {

    final token = await secureStorage.readToken();

    final resp = await http.get(Uri.parse('${URLS.URL_API}/get-orders-by-status/'+ status),
      headers: { 'Accept' : 'application/json', 'xx-token' : token! },
    );

    return OrdersByStatusResponse.fromJson( jsonDecode( resp.body ) ).ordersResponse;
  }


  Future<List<DetailsOrder>?> gerOrderDetailsById( String idOrder ) async {

    final token = await secureStorage.readToken();
    print(idOrder);
    final resp = await http.get(Uri.parse('${URLS.URL_API}/get-details-order-by-id/'+ idOrder),
      headers: { 'Accept' : 'application/json', 'xx-token' : token! },
    );

    return OrderDetailsResponse.fromJson( jsonDecode( resp.body ) ).detailsOrder;
  }


  Future<ResponseDefault> updateStatusOrderToDispatched( String idOrder, String idDelivery ) async {

    final token = await secureStorage.readToken();

    final resp = await http.put(Uri.parse('${URLS.URL_API}/update-status-order-dispatched'),
        headers: { 'Accept' : 'application/json', 'xx-token' : token! },
        body: {
          'idDelivery' : idDelivery,
          'idOrder' : idOrder
        }
    );

    return ResponseDefault.fromJson( jsonDecode( resp.body ));
  }


  Future<ResponseDefault> updateOrderStatusOnWay( String idOrder, String latitude, String longitude ) async {

    final token = await secureStorage.readToken();

    final resp = await http.put(Uri.parse('${URLS.URL_API}/update-status-order-on-way/'+ idOrder),
        headers: { 'Accept' : 'application/json', 'xx-token' : token! },
        body: {
          'latitude' : latitude,
          'longitude' : longitude
        }
    );

    return ResponseDefault.fromJson( jsonDecode( resp.body ));
  }


  Future<ResponseDefault> updateOrderStatusDelivered( String idOrder ) async {

    final token = await secureStorage.readToken();

    final resp = await http.put(Uri.parse('${URLS.URL_API}/update-status-order-delivered/'+ idOrder),
      headers: { 'Accept' : 'application/json', 'xx-token' : token! },
    );

    return ResponseDefault.fromJson( jsonDecode( resp.body ));
  }


  Future<List<OrdersClient>?> getListOrdersForClient(int? id) async {

    final token = await secureStorage.readToken();

    final resp = await http.get(Uri.parse('${URLS.URL_API}/get-list-orders-for-client/${id}'),
        headers: { 'Accept' : 'application/json', 'xx-token' : token! }
    );

    return OrdersClientResponse.fromJson( jsonDecode( resp.body ) ).ordersClient;
  }



}

final ordersController = OrdersController();