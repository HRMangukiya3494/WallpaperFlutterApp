import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:share/share.dart';
import 'package:wallpaper/views/utils/ColorUtils.dart';
import 'package:wallpaper/views/utils/ImageUtils.dart';
import 'package:wallpaper/views/utils/ListUtils.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
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
        actions: [
          Container(
            height: h * 0.06,
            width: h * 0.06,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(
                  ImageUtils.ImagePath + ImageUtils.SearchArrow,
                ),
              ),
            ),
          ),
        ],
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
                      image: AssetImage(ImageUtils.ImagePath + ImageUtils.AppLogo,),
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
                Share.share('https://play.google.com/store/apps/details?id=com.brainartit.wallpaper&pcampaignid=web_share');
              },
            ),
            ListTile(
              leading: Icon(Icons.privacy_tip, color: ColorUtils.PrimaryColor),
              title: Text('Privacy Policy', style: TextStyle(color: Colors.white)),
              onTap: () {
                // Handle the privacy policy action
              },
            ),
            ListTile(
              leading: Icon(Icons.star, color: ColorUtils.PrimaryColor),
              title: Text('Rate Us', style: TextStyle(color: Colors.white)),
              onTap: () {
                // Handle the rate us action
              },
            ),
            ListTile(
              leading: Icon(Icons.apps, color: ColorUtils.PrimaryColor),
              title: Text('Other Best Apps', style: TextStyle(color: Colors.white)),
              onTap: () {
                // Handle other best apps action
              },
            ),
            ListTile(
              leading: Icon(Icons.info, color: ColorUtils.PrimaryColor),
              title: Text('About Us', style: TextStyle(color: Colors.white)),
              onTap: () {
                // Handle about us action
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
                    Container(
                      height: h * 0.06,
                      width: h * 0.06,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage(story['ImagePath']!),
                          fit: BoxFit.fitHeight,
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
              child: MasonryGridView.count(
                crossAxisCount: 2,
                mainAxisSpacing: h * 0.02,
                crossAxisSpacing: h * 0.02,
                itemCount: 10,
                itemBuilder: (context, index) {
                  return Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      image: DecorationImage(
                        image: AssetImage(
                          ImageUtils.ImagePath +
                              'HomeWallpaper${index + 1}.jpg',
                        ),
                        fit: BoxFit.cover,
                      ),
                    ),
                    height: (index % 2 == 0) ? h * 0.3 : h * 0.25,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
