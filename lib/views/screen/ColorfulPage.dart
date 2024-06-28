import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wallpaper/GoogleAdHelper.dart';
import 'package:wallpaper/controller/ColorfulController.dart';
import 'package:wallpaper/views/utils/AppRoutes.dart';
import 'package:wallpaper/views/utils/ColorUtils.dart';

class ColorfulPage extends StatelessWidget {
  final ColorfulController colorfulController = Get.put(ColorfulController());

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
        ),
        title: Text(
          "Colorful",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: ColorUtils.PrimaryColor,
            fontSize: h * 0.026,
          ),
        ),
        centerTitle: true,
      ),
      backgroundColor: Colors.black,
      body: Padding(
        padding: EdgeInsets.all(h * 0.02),
        child: Obx(() {
          if (colorfulController.colors.isEmpty) {
            return Center(
              child: CircularProgressIndicator(
                color: Colors.white,
              ),
            );
          } else {
            return GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: h * 0.02,
                crossAxisSpacing: h * 0.02,
              ),
              itemCount: colorfulController.colors.length,
              itemBuilder: (context, index) {
                var colorInfo = colorfulController.colors[index];
                return GestureDetector(
                  onTap: () {
                    Get.toNamed(
                      AppRoutes.COLORFULLIST,
                      arguments: {
                        'cid': colorInfo['cid'].toString(),
                        'color': colorInfo['color'],
                      },
                    );
                    GoogleAdsHelper.googleAdsHelper.interstitialAd!.show();
                    GoogleAdsHelper.googleAdsHelper.showInterstitialAd();

                  },
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(h * 0.02),
                      image: DecorationImage(
                        image: NetworkImage(colorInfo['image']),
                        fit: BoxFit.cover,
                      ),
                    ),
                    child: Center(
                      child: Text(
                        colorInfo['color'].toUpperCase(),
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontSize: h * 0.024,
                        ),
                      ),
                    ),
                  ),
                );
              },
            );
          }
        }),
      ),
    );
  }
}
