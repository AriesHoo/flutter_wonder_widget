import 'dart:convert';

import 'package:flutter/widgets.dart';
import 'package:flutter_wonder_widget/constant/app_constant.dart';
import 'package:flutter_wonder_widget/util/fast_platform_util.dart';
import 'package:janalytics/janalytics.dart';

///统计帮助类
class AnalyticsHelper {
  static AnalyticsHelper? _instance;

  factory AnalyticsHelper.getInstance() => _getInstance();
  static late Janalytics _analytics;
  static AnalyticsRouteObserver? _analyticsRouteObserver;

  ///是否上传
  static bool _upload = false;

  static bool get upload => _upload;

  ///设备品牌
  static String _brand = '';

  ///设备型号
  static String _model = '';

  ///系统名称
  static String _systemName = '';

  ///Android只是的abi架构
  static String _supportedAbi = '';

  ///是否统计页面
  static const bool _startPage = false;

  /// 获取单例内部方法
  static _getInstance() {
    /// 只能有一个实例
    if (_instance == null) {
      _instance = AnalyticsHelper._internal();
      _analytics = Janalytics();

      ///设置debug模式
      _analytics.setDebugMode(false);

      ///先停止上传Crash
      _analytics.stopCrashHandler();

      ///获取系统相关
      FastPlatformUtil.getBrand().then((value) => _brand = value.toUpperCase());
      FastPlatformUtil.getModel().then((value) => _model = value.toUpperCase());
      FastPlatformUtil.getSystemVersion().then((value) => _systemName = value);
      FastPlatformUtil.getSupportedAbi().then((value) => _supportedAbi =
          jsonEncode(value)
              .replaceAll('[', '')
              .replaceAll(']', '')
              .replaceAll(',', '&'));

      ///物理机-真机才进行统计上报
      FastPlatformUtil.isPhysicalDevice().then((value) {
        ///真机才上报信息
        _upload = value;

        ///真机
        if (value) {
          ///设置debug模式
          _analytics.setDebugMode(AppConstant.isTest);

          ///开启错误日志上报
          _analytics.initCrashHandler();

          ///真机才进行初始化
          ///有极光key才进行初始化
          if (AppConstant.jPushKey.isNotEmpty) {
            _analytics.setup(
              appKey: AppConstant.jPushKey,
              channel: AppConstant.jPushChannel,
            );
          }
        }
      });
    }
    return _instance;
  }

  ///构造函数私有化，防止被误创建
  AnalyticsHelper._internal();

  ///路由监听
  AnalyticsRouteObserver? getAnalyticsRouteObserver() {
    _analyticsRouteObserver ??= AnalyticsRouteObserver();
    return _analyticsRouteObserver;
  }

  ///设置debug模式
  AnalyticsHelper? setDebugMode({bool debugMode = false}) {
    _analytics.setDebugMode(debugMode);
    return _instance;
  }

  ///进入页面
  AnalyticsHelper? onPageStart(String? pageName) {
    if (upload && _startPage && pageName != null) {
      _analytics.onPageStart(pageName);
    }
    return _instance;
  }

  ///离开页面
  AnalyticsHelper? onPageEnd(String? pageName) {
    if (upload && _startPage && pageName != null) {
      _analytics.onPageEnd(pageName);
    }
    return _instance;
  }

  ///错误日志
  AnalyticsHelper? reportError(
    String error, {
    int? errorCode,
    Map<String, String>? extMap,
  }) {
    if (error.isEmpty || !upload) {
      return _instance;
    }
    extMap = _addAnalyticsExtMap(extMap: extMap);
    extMap.putIfAbsent('error', () => error);
    String eventId =
        errorCode != null ? 'errorReport_$errorCode' : 'errorReport';
    _analytics.onCountEvent(
      eventId,
      extMap: extMap,
    );
    return _instance;
  }

  ///浏览事件
  AnalyticsHelper? onBrowseEvent({
    String? browseId,
    String? browseName,
    String? browseType,
    int? browseDuration,
    Map<String, String>? extMap,
  }) {
    if (!upload) {
      return _instance;
    }
    extMap = _addAnalyticsExtMap(extMap: extMap);
    _analytics.onBrowseEvent(
      browseId!,
      browseName!,
      browseType!,
      browseDuration!,
      extMap: extMap,
    );
    return _instance;
  }

  ///增加统计额外信息--用户信息-设备信息
  Map<String, String> _addAnalyticsExtMap({
    Map<String, String>? extMap,
    bool systemInfo = true,
    bool operatingSystem = true,
  }) {
    extMap = extMap ?? {};

    ///系统信息
    if (systemInfo) {
      if (!extMap.containsKey('brand') && _brand.isNotEmpty) {
        extMap.putIfAbsent('brand', () => _brand);
      }
      if (!extMap.containsKey('model') && _model.isNotEmpty) {
        extMap.putIfAbsent('model', () => _model);
      }
      if (!extMap.containsKey('systemName') && _systemName.isNotEmpty) {
        extMap.putIfAbsent('systemName', () => _systemName);
      }
      if (!extMap.containsKey('supportedAbi') && !_supportedAbi.isNotEmpty) {
        extMap.putIfAbsent('supportedAbi', () => _supportedAbi);
      }

      ///所在系统
      if (operatingSystem) {
        if (!extMap.containsKey('operatingSystem')) {
          extMap.putIfAbsent(
              'operatingSystem', () => FastPlatformUtil.operatingSystem);
        }
      }
    }
    return extMap;
  }
}

///应用路由监听
class AnalyticsRouteObserver<R extends Route<dynamic>>
    extends RouteObserver<R> {
  @override
  void didPush(Route route, Route? previousRoute) {
    super.didPush(route, previousRoute);
    AnalyticsHelper.getInstance().onPageStart(route.settings.name);
    AnalyticsHelper.getInstance().onPageEnd(previousRoute?.settings.name);
  }

  @override
  void didPop(Route route, Route? previousRoute) {
    super.didPop(route, previousRoute);
    AnalyticsHelper.getInstance().onPageEnd(route.settings.name);
    AnalyticsHelper.getInstance().onPageStart(previousRoute!.settings.name);
  }

  @override
  void didReplace({Route? newRoute, Route? oldRoute}) {
    super.didReplace(newRoute: newRoute, oldRoute: oldRoute);
    AnalyticsHelper.getInstance().onPageStart(newRoute!.settings.name);
    AnalyticsHelper.getInstance().onPageEnd(oldRoute!.settings.name);
  }
}
