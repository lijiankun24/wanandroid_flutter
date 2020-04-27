import 'package:flutter/material.dart';
import 'package:wanandroid_flutter/base/base_page.dart';
import 'package:wanandroid_flutter/common/common_import.dart';
import 'package:wanandroid_flutter/data/list/system/system_cat_notifier.dart';
import 'package:wanandroid_flutter/page/system/system_item.dart';

class SystemPage extends BasePage {
  @override
  BasePageState createState() {
    return _SystemState();
  }
}

class _SystemState extends BasePageState<SystemPage> {
  @override
  Widget build(BuildContext context) {
    _refreshWxArticleCat(context);
    return Scaffold(
      body: RefreshIndicator(
        child: ListView(
          children: <Widget>[
            Provide<SystemCatNotifier>(
              builder: (context, child, snapshot) {
                return buildItem(snapshot?.response?.data);
              },
            ),
          ],
        ),
        onRefresh: () {
          return _refreshWxArticleCat(context);
        },
      ),
    );
  }

  Future<CatModelResponse> _refreshWxArticleCat(BuildContext context) {
    return Provide.value<SystemCatNotifier>(context).getSystemCat();
  }

  Widget buildItem(List<CatModel> list) {
    if (ObjectUtil.isEmpty(list)) {
      return Container(
        height: 0,
      );
    }
    List<Widget> listItem = list.map((model) {
      return SystemItem(
        catModel: model,
        valueChanged: (data) {},
      );
    }).toList();
    return Column(
      children: listItem,
    );
  }
}