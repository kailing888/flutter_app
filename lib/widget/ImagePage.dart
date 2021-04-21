import 'package:flutter/material.dart';
import 'package:flutter_app/widget/BasePage.dart';

//const Image({
//   ...
//   this.width, //图片的宽
//   this.height, //图片高度
//   this.color, //图片的混合色值
//   this.colorBlendMode, //混合模式
//   this.fit,//缩放模式
//   this.alignment = Alignment.center, //对齐方式
//   this.repeat = ImageRepeat.noRepeat, //重复方式
//   ...
// })

//Image缓存
// Flutter框架对加载过的图片是有缓存的（内存），默认最大缓存数量是1000，最大缓存空间为100M。

//在Flutter开发中，iconfont和图片相比有如下优势：
//
// 体积小：可以减小安装包大小。
// 矢量的：iconfont都是矢量图标，放大不会影响其清晰度。
// 可以应用文本样式：可以像文本一样改变字体图标的颜色、大小对齐等。
// 可以通过TextSpan和文本混用。
// #
class ImagePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    String icons = "";
    icons += "\uE914";
    icons += " \uE000";
    icons += " \uE90D";

    return BasePage(
        "image",
        Column(
          children: <Widget>[
            ///加载assets 图片
            Image(image: AssetImage("images/profile_header.png"), width: 100.0),
            Image.asset(
              "images/profile_header.png",
              width: 100.0,
            ),

            ///加载网络图片
            Image(
              image: NetworkImage(
                  "https://avatars2.githubusercontent.com/u/20411648?s=460&v=4"),
              width: 100.0,
            ),
            Image.network(
              "https://avatars2.githubusercontent.com/u/20411648?s=460&v=4",
              width: 100.0,
            ),

            ///icon
            Text(
              icons,
              style: TextStyle(
                  fontFamily: "MaterialIcons",
                  fontSize: 24.0,
                  color: Colors.green),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Icon(
                  Icons.accessible,
                  color: Colors.green,
                ),
                Icon(
                  Icons.error,
                  color: Colors.green,
                ),
                Icon(
                  Icons.fingerprint,
                  color: Colors.green,
                ),
              ],
            )
          ],
        ));
  }
}
