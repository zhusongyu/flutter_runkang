// 网络结果数据
class ResultData {
  var data;
  bool result;
  int code;
  var headers;

  ResultData(this.data, this.result, this.code, {this.headers});
}

// 网络结果数据
class DataResult {
  var data;
  bool result;

  DataResult(this.data, this.result);
}