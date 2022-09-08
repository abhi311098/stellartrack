import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:readmore/readmore.dart';
import 'package:stellartrack/view_model/product_detail_view_model.dart';
import 'package:stellartrack/widget/cached_image.dart';
import 'package:stellartrack/widget/circular_loader.dart';
import 'package:stellartrack/widget/text_design.dart';

import '../model/product_detail_model.dart';
import '../utils/const/color_const.dart';
import '../utils/const/text_const.dart';
import '../widget/space.dart';

class ProductDetail extends StatelessWidget {
  int? id;

  ProductDetail({Key? key, this.id}) : super(key: key);

  ///Bottom Navigation Design(Add to cart and buy now)
  _bottomNav(BuildContext context) {
    return Consumer<ProductDetailViewModel>(
      builder: (_, data, __) {
        if (data.loading) {
          return Space(height: 71,);
        } else if (data.userError != null) {
          return Space(height: 71,);
        }
        double width = MediaQuery.of(context).size.width;
        return Space(
        height: 71,
        child: Column(
          children: [
            Container(
              width: double.infinity,
              height: 1,
              color: Colors.grey,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  width: width * 0.5,
                  padding: EdgeInsets.symmetric(
                    horizontal: width * 0.02,
                  ),
                  height: 70,
                  alignment: Alignment.center,
                  child: FittedBox(
                    child: TextDesign(
                      text: ADD_TO_CART,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Container(
                  width: width * 0.5,
                  padding: EdgeInsets.symmetric(
                    horizontal: width * 0.02,
                  ),
                  height: 70,
                  color: Colors.orange,
                  alignment: Alignment.center,
                  child: FittedBox(
                    child: TextDesign(
                      text: BUY_NOW,
                      color: colorWhite,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      );}
    );
  }

  late ProductDetailViewModel productDetailViewModel;

  @override
  Widget build(BuildContext context) {
    productDetailViewModel =
        Provider.of<ProductDetailViewModel>(context, listen: false);
    productDetailViewModel.getProductDetail(id!);
    return Scaffold(
      bottomNavigationBar: _bottomNav(context),
      body: SafeArea(
        child: Consumer<ProductDetailViewModel>(
          builder: (_, data, __) {
            if (data.loading) {
              return const CircularLoader();
            } else if (data.userError != null) {
              return Center(
                child: Text(
                    data.userError?.message.toString() ??
                        "Error"),
              );
            }
            return _ui(data.productDetailModel!, context);
          },
        ),
      ),
    );
  }

  ///Image, Title, Rating, Price
  _ui(ProductDetailModel productDetailModel, BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Stack(
          children: [
            CachedImage(
              width: double.infinity,
              heigth: 250,
              imageUrl: productDetailModel.image,
            ),
            Positioned(
              left: 10,
              top: 10,
              child: Container(
                decoration: const BoxDecoration(
                    color: colorBlack12, shape: BoxShape.circle),
                child: IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(Icons.arrow_back_outlined)),
              ),
            ),
          ],
        ),
        Container(
          width: double.infinity,
          color: colorWhite,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextDesign(
                text: productDetailModel.title,
                fontWeight: FontWeight.bold,
                fontSize: 24,
              ),
              Space(
                height: 5,
              ),
              Row(
                children: [
                  RatingBarIndicator(
                    rating: productDetailModel.rating!.rate!
                        .toDouble(),
                    itemBuilder: (context, index) => const Icon(
                      Icons.star,
                      color: Colors.amber,
                    ),
                    itemCount: 5,
                    itemSize: 22.0,
                    direction: Axis.horizontal,
                  ),
                  TextDesign(
                      maxLines: 2,
                      text:
                          " (${productDetailModel.rating?.count})",
                      fontSize: 20,
                      fontWeight: FontWeight.normal),
                ],
              ),
              Space(
                height: 15,
              ),
              TextDesign(
                  maxLines: 2,
                  text: "\$${productDetailModel.price}",
                  fontSize: 25,
                  fontWeight: FontWeight.bold),
            ],
          ),
        ),
        productDetailModel.description == "" ||
                productDetailModel.description == null
            ? Container()
            : _description(
                productDetailModel.description),
      ],
    );
  }

  ///Description
  _description(
    String? description,
  ) {
    return Container(
      width: double.infinity,
      color: colorWhite,
      margin: const EdgeInsets.only(top: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: TextDesign(
              text: DESCRIPTION,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const Divider(
            thickness: 1,
            color: Colors.grey,
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 8),
            child: ReadMoreText(
              description ?? "",
              trimLines: 7,
              colorClickableText: Colors.pink,
              trimMode: TrimMode.Line,
              trimCollapsedText: SHOW_MORE,
              trimExpandedText: SHOW_LESS,
              style:
                  GoogleFonts.lato(fontSize: 18, fontWeight: FontWeight.w500),
              moreStyle:
                  GoogleFonts.lato(fontSize: 20, fontWeight: FontWeight.bold),
              lessStyle:
                  GoogleFonts.lato(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }
}
