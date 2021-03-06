
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '/Bloc/Delivery/delivery_bloc.dart';
import '/Bloc/Orders/orders_bloc.dart';
import '/Bloc/Products/products_bloc.dart';
import '/Controller/CategoryController.dart';
import '/Controller/DeliveryController.dart';
import '/Models/Response/CategoryAllResponse.dart';
import '/Models/Response/GetAllDeliveryResponse.dart';
import '/Services/url.dart';
import '/Themes/ColorsFrave.dart';
import '/Widgets/Widgets.dart';
import 'package:url_launcher/url_launcher.dart';

part 'navigator_route_fade_in.dart';
part 'modal_loading.dart';
part 'modal_picture.dart';
part 'modal_success.dart';
part 'ModalSelectionCategory.dart';
part 'modalActiveProduct.dart';
part 'modal_delete_product.dart';
part 'ModalSelectDelivery.dart';
part 'custom_markert.dart';
part 'modal_info.dart';
part 'url_lancher_frave.dart';
part 'modal_payment.dart';
part 'error_message.dart';
part 'modal_delete.dart';