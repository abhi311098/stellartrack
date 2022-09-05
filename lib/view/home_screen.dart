import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:stellartrack/view/product_detail.dart';
import 'package:stellartrack/view_model/product_list_view_model.dart';
import 'package:stellartrack/widget/cached_image.dart';
import 'package:stellartrack/widget/shimmer_loader.dart';
import 'package:stellartrack/widget/text_design.dart';
import 'package:provider/provider.dart';

import '../utils/const/color_const.dart';
import '../utils/const/text_const.dart';
import '../widget/space.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ProductListViewModel productListViewModel =
        context.watch<ProductListViewModel>();
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {}, icon: const Icon(CupertinoIcons.text_justify)),
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.notifications)),
          IconButton(
              onPressed: () {}, icon: const Icon(Icons.shopping_cart_outlined)),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            _ui(productListViewModel),
          ],
        ),
      ),
    );
  }

  _ui(ProductListViewModel productListViewModel) {
    if (productListViewModel.loading) {
      return const ShimmerLoader();
    } else if (productListViewModel.userError != null) {
      return Center(
        child:
            Text(productListViewModel.userError?.message.toString() ?? "Error"),
      );
    }
    return _listDesign(productListViewModel);
  }

  ///Product List
  _listDesign(ProductListViewModel productListViewModel) {
    return ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) => GestureDetector(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => ProductDetail(
                          id: productListViewModel.productListModel[index].id,
                        )));
              },
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(width: 0.9, color: colorGrey),
                ),
                child: _productListDesign(productListViewModel, index),
              ),
            ),
        separatorBuilder: (context, index) => Space(
              height: 10,
            ),
        itemCount: productListViewModel.productListModel.length);
  }

  ///Product List Container Design
  _productListDesign(ProductListViewModel productListViewModel, int index) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CachedImage(
          imageUrl: productListViewModel.productListModel[index].image,
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextDesign(
                    maxLines: 2,
                    text: productListViewModel.productListModel[index].title,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
                Space(
                  height: 5,
                ),
                Row(
                  children: [
                    RatingBarIndicator(
                      rating: productListViewModel
                          .productListModel[index].rating!.rate!
                          .toDouble(),
                      itemBuilder: (context, index) => const Icon(
                        Icons.star,
                        color: Colors.amber,
                      ),
                      itemCount: 5,
                      itemSize: 20.0,
                      direction: Axis.horizontal,
                    ),
                    TextDesign(
                        maxLines: 2,
                        text:
                            " (${productListViewModel.productListModel[index].rating?.count})",
                        fontSize: 18,
                        fontWeight: FontWeight.normal),
                  ],
                ),
                Space(
                  height: 5,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextDesign(
                        maxLines: 2,
                        text:
                            "\$${productListViewModel.productListModel[index].price}",
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(),
                      onPressed: () {},
                      child: TextDesign(
                          maxLines: 1,
                          text: ADD_TO_CART,
                          fontSize: 16,
                          color: colorWhite,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
