import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:share/share.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:wallpaper/controller/HomeController.dart';
import 'package:wallpaper/model/RateUs.dart';
import 'package:wallpaper/views/screen/ImagePage.dart';
import 'package:wallpaper/views/utils/AppRoutes.dart';
import 'package:wallpaper/views/utils/ColorUtils.dart';
import 'package:wallpaper/views/utils/ImageUtils.dart';
import 'package:wallpaper/views/utils/ListUtils.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final HomeController controller = Get.put(
      HomeController(),
    );
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(
          "Wallpaper",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: ColorUtils.PrimaryColor,
            fontSize: h * 0.026,
          ),
        ),
        leading: Builder(
          builder: (BuildContext context) {
            return GestureDetector(
              onTap: () {
                Scaffold.of(context).openDrawer();
              },
              child: Container(
                height: h * 0.06,
                width: h * 0.06,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(
                      ImageUtils.ImagePath + ImageUtils.BackArrow,
                    ),
                  ),
                ),
              ),
            );
          },
        ),
        centerTitle: true,
      ),
      drawer: Drawer(
        backgroundColor: Colors.black,
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            SizedBox(
              height: h * 0.1,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: h * 0.06,
                  width: h * 0.06,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(
                        ImageUtils.ImagePath + ImageUtils.AppLogo,
                      ),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                SizedBox(width: w * 0.04),
                Text(
                  'Wallpaper',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: h * 0.03,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: h * 0.06,
            ),
            ListTile(
              leading: Icon(Icons.share, color: ColorUtils.PrimaryColor),
              title: Text('Share', style: TextStyle(color: Colors.white)),
              onTap: () {
                const String appLink =
                    'https://play.google.com/store/apps/details?id=com.wallscape.wallpaper';
                Share.share('Check out this app: $appLink');
              },
            ),
            ListTile(
              leading: Icon(Icons.privacy_tip, color: ColorUtils.PrimaryColor),
              title:
                  Text('Privacy Policy', style: TextStyle(color: Colors.white)),
              onTap: () {
                Get.toNamed(AppRoutes.PRIVACYPOLICY);
              },
            ),
            ListTile(
              leading: Icon(Icons.star, color: ColorUtils.PrimaryColor),
              title: Text('Rate Us', style: TextStyle(color: Colors.white)),
              onTap: () {
                RateUs().forceShowRateDialog(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.apps, color: ColorUtils.PrimaryColor),
              title: Text('Other Best Apps',
                  style: TextStyle(color: Colors.white)),
              onTap: () async {
                const String allAppLink =
                    'https://play.google.com/store/apps/dev?id=9103775981511771133&hl=en-IN';
                if (await canLaunch(allAppLink)) {
                  await launch(allAppLink);
                } else {
                  throw 'Could not launch $allAppLink';
                }
              },
            ),
            ListTile(
              leading: Icon(Icons.info, color: ColorUtils.PrimaryColor),
              title: Text('About Us', style: TextStyle(color: Colors.white)),
              onTap: () {
                Get.toNamed(AppRoutes.ABOUTUS);
              },
            ),
          ],
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(h * 0.02),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: HomeStory.map((story) {
                return Column(
                  children: [
                    GestureDetector(
                      onTap: story['onTap'],
                      child: Container(
                        height: h * 0.06,
                        width: h * 0.06,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage(story['ImagePath']!),
                            fit: BoxFit.fitHeight,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: h * 0.01),
                    Text(
                      story['Name']!,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: h * 0.014,
                      ),
                    ),
                  ],
                );
              }).toList(),
            ),
            SizedBox(
              height: h * 0.02,
            ),
            Expanded(
              child: Obx(() {
                if (controller.isLoading.value &&
                    controller.wallpapers.isEmpty) {
                  return Center(
                    child: CircularProgressIndicator(
                      color: Colors.white,
                    ),
                  );
                }

                return NotificationListener<ScrollNotification>(
                  onNotification: (ScrollNotification scrollInfo) {
                    if (!controller.isLoading.value &&
                        scrollInfo.metrics.pixels ==
                            scrollInfo.metrics.maxScrollExtent) {
                      controller.fetchWallpapers();
                      return true;
                    }
                    return false;
                  },
                  child: MasonryGridView.count(
                    crossAxisCount: 2,
                    mainAxisSpacing: h * 0.02,
                    crossAxisSpacing: h * 0.02,
                    itemCount: controller.wallpapers.length,
                    itemBuilder: (context, index) {
                      var wallpaper = controller.wallpapers[index];
                      if (index == controller.wallpapers.length) {
                        return Center(
                          child: CircularProgressIndicator(
                            color: Colors.white,
                          ),
                        );
                      }
                      return GestureDetector(
                        onTap: () {
                          Get.to(
                            () => FullScreenImagePage(
                              images: controller.wallpapers
                                  .map((wp) =>
                                      'https://hdwalls.wallzapps.com/upload//${wp['image']}')
                                  .toList(),
                              initialIndex: index,
                            ),
                          );
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(h * 0.01),
                            image: DecorationImage(
                              image: NetworkImage(
                                'https://hdwalls.wallzapps.com/upload/custom/' +
                                    wallpaper['image'],
                              ),
                              fit: BoxFit.cover,
                            ),
                          ),
                          height: (index % 2 == 0) ? h * 0.3 : h * 0.25,
                        ),
                      );
                    },
                  ),
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}
