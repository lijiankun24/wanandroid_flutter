import 'package:flutter/material.dart';
import 'package:wanandroid_flutter/data/list/list_item_model.dart';
import 'package:wanandroid_flutter/utils/object_utils.dart';

class ArticleItem extends StatelessWidget {
  final ListItemModel articleModel;
  final ValueChanged<ListItemModel> valueChanged;

  ArticleItem({Key key, this.articleModel, this.valueChanged})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    double titleBottomPadding =
        ObjectUtil.isEmpty(articleModel.desc) ? 16.5 : 10;
    String publishTime = ObjectUtil.timeToDate(articleModel.publishTime);
    return InkWell(
      onTap: () => valueChanged(articleModel),
      child: Container(
          alignment: Alignment.centerLeft,
          padding: EdgeInsets.only(
            left: 20,
            right: 20,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                padding: EdgeInsets.only(
                  top: 16.5,
                  bottom: titleBottomPadding,
                ),
                child: Text(
                  articleModel.title,
                  style: TextStyle(color: Color(0xff222333), fontSize: 16),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Visibility(
                visible: !ObjectUtil.isEmpty(articleModel.desc),
                child: Container(
                  padding: EdgeInsets.only(
                    bottom: 16.5,
                  ),
                  child: Text(
                    articleModel.desc,
                    style: TextStyle(color: Color(0xff8d8d98), fontSize: 12),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
              Row(
                children: <Widget>[
                  Visibility(
                    visible: !ObjectUtil.isEmpty(articleModel.author),
                    child: Container(
                      padding: EdgeInsets.only(
                        right: 5,
                        bottom: 16.5,
                      ),
                      child: Text(
                        articleModel.author,
                        style:
                            TextStyle(color: Color(0xff8d8d98), fontSize: 12),
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(
                      bottom: 16.5,
                    ),
                    child: Text(
                      publishTime,
                      style: TextStyle(color: Color(0xff8d8d98), fontSize: 12),
                    ),
                  ),
                ],
              ),
              Container(
                height: 0.5,
                color: new Color(0xffe3e3e3),
              ),
            ],
          )),
    );
  }
}
