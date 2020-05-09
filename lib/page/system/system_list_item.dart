import 'package:flutter/material.dart';
import 'package:wanandroid_flutter/common/common_import.dart';

class SystemListItem extends StatelessWidget {
  final ListItemModel itemModel;
  final ValueChanged<ListItemModel> valueChanged;

  SystemListItem({Key key, this.itemModel, this.valueChanged})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => valueChanged(itemModel),
      child: Container(
        alignment: Alignment.centerLeft,
        padding: const EdgeInsets.only(
          left: 20,
          right: 20,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(
                top: 16.5,
              ),
            ),
            Text(
              itemModel.title,
              style: TextStyle(
                color: Color(0xff222333),
                fontSize: 16,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            Padding(
              padding: const EdgeInsets.only(
                top: 10.0,
              ),
            ),
            Visibility(
              visible: !ObjectUtil.isEmpty(itemModel.desc),
              child: Container(
                constraints: BoxConstraints(
                  minHeight: 60,
                ),
                child: Text(
                  itemModel.desc,
                  style: TextStyle(
                    color: Color(0xff8d8d98),
                    fontSize: 12,
                  ),
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                top: 10.0,
              ),
            ),
            Container(
              height: 0.5,
              color: Color(0xffe3e3e3),
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> buildTag(List<CatModel> childTag) {
    return childTag.map(
      (model) {
        return Container(
          child: Text(
            model.name,
            style: TextStyle(
              color: Color(0xff8d8d98),
              fontSize: 12,
            ),
          ),
        );
      },
    ).toList();
  }
}
