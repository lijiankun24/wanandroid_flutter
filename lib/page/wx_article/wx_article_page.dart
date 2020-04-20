import 'package:flutter/material.dart';
import 'package:wanandroid_flutter/base/base_page.dart';
import 'package:wanandroid_flutter/common/common_import.dart';
import 'package:wanandroid_flutter/data/wx_article/wx_article_cat_notifier.dart';
import 'package:wanandroid_flutter/data/wx_article/wx_article_cat_model.dart';
import 'package:wanandroid_flutter/data/wx_article/wx_article_list_notifier.dart';
import 'package:wanandroid_flutter/data/wx_article/wx_article_list_model.dart';
import 'package:wanandroid_flutter/widgets/tab_layout.dart';
import 'wx_article_item.dart';

class WxArticlePage extends BasePage {
  @override
  BasePageState createState() {
    return _WxArticleState();
  }
}

class _WxArticleState extends BasePageState<WxArticlePage> {
  List<WxArticleCatModel> wxArticleCatList;
  int curWxArticleCatId = 408;
  Function _dismissLoadingFun;

  @override
  Widget build(BuildContext context) {
    _refreshWxArticleCat(context);
    return Provide<WxArticleCatNotifier>(
      builder: (context, child, snapshot) {
        return DefaultTabController(
          length: snapshot?.response?.data?.length,
          child: Scaffold(
            appBar: AppBar(
              title: TabLayout<WxArticleCatModel>(
                wxArticleCatList,
                (model) {
                  _showLoading();
                  _refreshWxArticleList(context, id: model.id);
                },
              ),
            ),
            body: RefreshIndicator(
              child: ListView(
                children: <Widget>[
                  Provide<WxArticleListNotifier>(
                    builder: (context, child, snapshot) {
                      if (_dismissLoadingFun != null) {
                        _dismissLoadingFun();
                        _dismissLoadingFun = null;
                      }
                      return buildListItem(snapshot?.response?.data?.datas);
                    },
                  ),
                ],
              ),
              onRefresh: () {
                return _refreshWxArticleList(context);
              },
            ),
          ),
        );
      },
    );
  }

  void _refreshWxArticleCat(BuildContext context) {
    Provide.value<WxArticleCatNotifier>(context)
        .getWxArticleCat()
        .then((response) {
      wxArticleCatList = response.data;
      if (!ObjectUtil.isEmpty(wxArticleCatList)) {
        _refreshWxArticleList(context, id: wxArticleCatList[0].id);
      }
    });
  }

  Future<WxArticleListModelResponse> _refreshWxArticleList(BuildContext context,
      {int id}) {
    if (id != null) {
      curWxArticleCatId = id;
    }
    return Provide.value<WxArticleListNotifier>(context)
        .getWxArticleList(curWxArticleCatId);
  }

  _showLoading() {
    showDialog(
      context: context,
      builder: (context) {
        return new LoadingDialog(
          dismissLoading: _dismissLoading,
          outsideDismiss: false,
        );
      },
    );
  }

  _dismissLoading(Function dismissLoadingFun) {
    _dismissLoadingFun = dismissLoadingFun;
  }

  Widget buildListItem(List<WxArticleModel> list) {
    if (ObjectUtil.isEmpty(list)) {
      return Container(height: 0);
    }
    List<Widget> itemList = list.map((model) {
      return WxArticleItem(model);
    }).toList();
    return Column(
      children: itemList,
    );
  }
}
