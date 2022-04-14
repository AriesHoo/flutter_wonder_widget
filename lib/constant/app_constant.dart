import 'package:flutter_wonder_widget/widget/button.dart';
import 'package:flutter_wonder_widget/widget/edit_text.dart';

///应用常量
class AppConstant {
  static bool get isTest => _environment != Environment.production;

  ///输入框最小高度
  static double get editTextMinHeight => 46.0;

  ///[EditText]及[Button] 默认圆角
  static double get defaultRadius => 10.0;

  ///当前环境
  static Environment _environment = Environment.production;

  ///上传文件到七牛云
  static String get fileUploadPath => 'http://upload.qiniup.com/';

  ///检查是否联网url
  static String get checkNetworkPath => 'https://www.qiniu.com/';

  ///备案号url
  static String get recordNoPath => 'https://beian.miit.gov.cn/';

  ///生产环境参数
  static final Map<String, dynamic> _paramsProduction = {
    'appTitle': '惊奇组件',
    'jPushKey': '32d020e13b082bf1ee5c549d',
    'jPushChannel': 'BloodBelfry',
    'apiUrl': 'http://www.xxxx.com/api/s3/',
    'fileUrl': 'http://res.xxx.com/',
    'agreementUrl': 'http://www.xxxxx.com/agreement.html',
  };

  ///测试环境参数
  static final Map<String, dynamic> _paramsTest = {
    'appTitle': '惊奇组件Test',
    'jPushKey': '32d020e13b082bf1ee5c549d',
    'jPushChannel': 'BloodBelfryTest',
    'apiUrl': 'http://www.xxxx.com/api/s3/',
    'fileUrl': 'http://res.xxx.com/',
    'agreementUrl': 'http://www.xxxxx.com/agreement.html',
  };

  ///设置当前环境
  static setEnvironment(Environment environment) {
    _environment = environment;
  }

  ///获取当前环境参数
  static Map<String, dynamic> getEnvironmentParams() {
    Map<String, dynamic> params = {};
    switch (_environment) {
      case Environment.production:
        params = _paramsProduction;
        break;
      case Environment.test:
        params = _paramsTest;
        break;
    }
    return params;
  }

  ///根据key获取环境存放value
  static dynamic getEnvironmentValue(String key) {
    dynamic result = '';
    getEnvironmentParams().forEach((k, value) {
      if (k == key) {
        result = value;
      }
    });
    return result;
  }

  ///获取main设置title
  static String get appTitle => getEnvironmentValue('appTitle');

  ///极光key(统计/推送)
  static String get jPushKey => getEnvironmentValue('jPushKey');

  ///极光渠道(统计/推送)
  static String get jPushChannel => getEnvironmentValue('jPushChannel');

  ///获取请求基地址
  static String get apiUrl => getEnvironmentValue('apiUrl');

  ///获取七牛云文件url
  static String get fileUrl => getEnvironmentValue('fileUrl');

}

///环境区分
enum Environment {
  production,
  test,
}
