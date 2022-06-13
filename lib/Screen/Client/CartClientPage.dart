import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '/Bloc/Cart/cart_bloc.dart';
import '/Screen/Client/CheckOutPage.dart';
import '/Screen/Client/ClientHomePage.dart';
import '/Services/url.dart';
import '/Themes/ColorsFrave.dart';
import '/Widgets/AnimationRoute.dart';
import '/Widgets/Widgets.dart';


class CartClientPage extends StatelessWidget {

  @override
  Widget build(BuildContext context)
  {
    final cartBloc = BlocProvider.of<CartBloc>(context);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: TextFrave(text: 'My Cart', fontSize: 20, fontWeight: FontWeight.w500 ),
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        leadingWidth: 80,
        leading: IconButton(
          icon: Row(
            children: [
              Icon(Icons.arrow_back_ios_new_rounded, color: ColorsFrave.primaryColor, size: 19),
              TextFrave(text: 'Back', fontSize: 16, color: ColorsFrave.primaryColor )
            ],
          ),
          onPressed: () => Navigator.pushAndRemoveUntil(context, routeFrave(page: ClientHomePage()), (route) => false),
        ),
        actions: [
          Center(
            child: BlocBuilder<CartBloc, CartState>(
              builder: (context, state) 
                => TextFrave(text: '${state.quantityCart} Items', fontSize: 17 )
            )
          ),
          SizedBox(width: 10.0)
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: BlocBuilder<CartBloc, CartState>(
                builder: (context, state) 
                  => (state.quantityCart != 0 ) 
                    ? ListView.builder(
                        padding: EdgeInsets.symmetric(horizontal: 20.0),
                        itemCount: state.quantityCart,
                        itemBuilder: (_, i) 
                          => Dismissible(
                            key: Key(state.products![i].uidProduct),
                            direction: DismissDirection.endToStart,
                            background: Container(),
                            secondaryBackground: Container(
                              padding: EdgeInsets.only(right: 35.0),
                              margin: EdgeInsets.only(bottom: 15.0),
                              alignment: Alignment.centerRight,
                              decoration: BoxDecoration(
                                color: Colors.red,
                                borderRadius: BorderRadius.only(topRight: Radius.circular(20.0), bottomRight: Radius.circular(20.0))
                              ),
                              child: Icon(Icons.delete_sweep_rounded, color: Colors.white, size: 40),
                            ),
                            onDismissed: (direccion) => cartBloc.add(OnDeleteProductToCartEvent(i)),
                            child: Container(
                                height: 90,
                                alignment: Alignment.center,
                                margin: EdgeInsets.only(bottom: 15.0),
                                decoration: BoxDecoration(
                                  color: Colors.grey[100],
                                  borderRadius: BorderRadius.circular(10.0)
                                ),
                                child: Row(
                                  children: [
                                    Container(
                                      width: 100,
                                      padding: EdgeInsets.all(15.0),
                                      decoration: BoxDecoration(
                                        image: DecorationImage(
                                          scale: 8,
                                          image: NetworkImage( URLS.BASE_URL + state.products![i].imageProduct)
                                        )
                                      ),
                                    ),
                                    Container(
                                      width: 120,
                                      padding: EdgeInsets.all(10.0),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          TextFrave(text: state.products![i].nameProduct, fontWeight: FontWeight.w500, fontSize: 20),
                                          SizedBox(height: 10.0),
                                          TextFrave(text: '\$ ${state.products![i].price * state.products![i].quantity}', color: ColorsFrave.primaryColor )
                                        ],
                                      ),
                                    ),
                                    Expanded(
                                      child: Container(
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            Container(
                                              alignment: Alignment.center,
                                              padding: EdgeInsets.all(0.0),
                                              decoration: BoxDecoration(
                                                color: ColorsFrave.primaryColor,
                                                shape: BoxShape.circle
                                              ),
                                              child: InkWell(
                                                child: Icon(Icons.remove, color: Colors.white ),
                                                onTap: (){ 
                                                  if( state.products![i].quantity < 2 ) {
                                                    cartBloc.add(OnDeleteProductToCartEvent(i));
                                                  }
                                                  else cartBloc.add((OnDecreaseProductQuantityToCartEvent(i)));
                                                },
                                              )
                                            ),
                                            SizedBox(width: 5.0),
                                            TextFrave(text: '${state.products![i].quantity}', color: ColorsFrave.primaryColor ),
                                            SizedBox(width: 5.0),
                                            Container(
                                              alignment: Alignment.center,
                                              padding: EdgeInsets.all(2.0),
                                              decoration: BoxDecoration(
                                                color: ColorsFrave.primaryColor,
                                                shape: BoxShape.circle
                                              ),
                                              child: InkWell(
                                                child: Icon(Icons.add, color: Colors.white ),
                                                onTap: () => cartBloc.add(OnIncreaseQuantityProductToCartEvent(i))
                                              )
                                            ),
                                            SizedBox(width: 12.0),
                                            Container(
                                                alignment: Alignment.center,
                                                child: InkWell(
                                                    child: Icon(Icons.delete_forever_rounded, color: Colors.red ),
                                                    onTap: () => cartBloc.add(OnDeleteProductToCartEvent(i))
                                                )
                                            )
                                          ],
                                        ),
                                      ),
                                    )
                                  ],
                                )
                            ),
                          )
                    )
                    : _WithOutProducts()
              ),
            ),
            Container(
              height: 200,
              padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
              color: Colors.white,
              child: Container(
                width: MediaQuery.of(context).size.width,
                padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                decoration: BoxDecoration(
                  color: Colors.grey[50],
                  borderRadius: BorderRadius.circular(10.0)
                ),
                child: BlocBuilder<CartBloc, CartState>(
                  builder: (context, state) 
                    => Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          TextFrave(text: 'Total'),
                          TextFrave(text: '${state.total}'),
                        ],
                      ),
                      SizedBox(height: 20.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          TextFrave(text: 'Sub Total'),
                          TextFrave(text: '${state.total}'),
                        ],
                      ),
                      SizedBox(height: 20.0),
                      BtnFrave(
                        text: 'Checkout',
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                        color: (state.quantityCart != 0) ? ColorsFrave.primaryColor : ColorsFrave.secundaryColor,
                        onPressed: (){
                          if ( state.quantityCart != 0 ){
                            Navigator.push(context, routeFrave(page: CheckOutPage()));
                          }
                        },
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _WithOutProducts extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          SvgPicture.asset('Assets/empty-cart.svg', height: 450),
          TextFrave(text: 'Without products', fontSize: 21, fontWeight: FontWeight.w500, color: ColorsFrave.primaryColor,)
        ],
      ),
    );
  }
}