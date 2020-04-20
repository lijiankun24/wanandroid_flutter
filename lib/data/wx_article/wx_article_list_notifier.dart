import 'package:wanandroid_flutter/common/common_import.dart';
import 'wx_article_list_model.dart';

class WxArticleListNotifier with ChangeNotifier {
  WxArticleListModelResponse _response;

  WxArticleListModelResponse get response => _response;

  Future<WxArticleListModelResponse> getWxArticleList(int id) {
    return Application.netManager
        .get(sprintf(Api.WX_ARTICLE_LIST, [id]))
        .then<WxArticleListModelResponse>((res) {
      _response = WxArticleListModelResponse.fromJson(res.data);
      notifyListeners();
      return Future.value(_response);
    });
  }
}
