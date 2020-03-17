import 'package:cached_network_image/cached_network_image.dart';
import 'package:flukit/flukit.dart';
import 'package:flutter/material.dart';
import 'package:provide/provide.dart';
import 'package:rxdart/rxdart.dart';
import 'package:wanandroid_flutter/base/widget/base_page.dart';
import 'package:wanandroid_flutter/data/home/banner/banner_notifier.dart';

import '../common/object_util.dart';
import '../data/home/banner/banner_model.dart';

class HomePage extends BasePage {
  @override
  BasePageState createState() {
    return _HomeState();
  }
}

class _HomeState extends BasePageState<HomePage> {
  Widget buildBanner(BuildContext context, List<BannerModel> list) {
    if (ObjectUtil.isEmpty(list)) {
      return Container(height: 0.0);
    }
    return AspectRatio(
      aspectRatio: 16 / 9,
      child: Swiper(
        children: list.map((banner) {
          return new CachedNetworkImage(imageUrl: banner.imagePath);
        }).toList(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Observable.just(1).delay(Duration(milliseconds: 100)).listen((_) {
      Provide.value<BannerNotifier>(context).getBanner();
    });
    return Scaffold(
      appBar: AppBar(
        title: Text('首页'),
      ),
      body: ListView(
        children: <Widget>[
          Provide<BannerNotifier>(
            builder: (context, child, bannerNotifier) {
              return buildBanner(context, bannerNotifier?.response?.data);
            },
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(onPressed: () {
        Provide.value<BannerNotifier>(context).getBanner();
      }),
    );
  }
}
