class PointerRepository {
  /// 私有构造函数
  PointerRepository._internal();

  /// 单例对象
  static final PointerRepository _singleton = PointerRepository._internal();

  /// 工厂方法
  static PointerRepository get instance => _singleton;

  bool _isEnable = true;

  bool get isEnable => _isEnable;

  void setEnable(bool isEnable) => _isEnable = isEnable;
}