class MenuOrder {
  MenuOrder(
      {this.menuOrderId,
      this.menuOrderType,
      this.menuOrderPrice,
      this.menuOrderDuration});
  String menuOrderId;
  String menuOrderType;
  int menuOrderPrice;
  String menuOrderDuration;

  String get getMenuOrderId {
    return menuOrderId;
  }

  String get getMenuOrderType {
    return menuOrderType;
  }

  int get getMenuOrderPrice {
    return menuOrderPrice;
  }

  String get getMenuOrderDuration {
    return menuOrderDuration;
  }

  set setMenuOrderId(String newMenuOrderId) {
    menuOrderId = newMenuOrderId;
  }

  set setMenuOrderType(String newMenuOrderType) {
    menuOrderType = newMenuOrderType;
  }

  set setMenuOrderPrice(int newMenuOrderPrice) {
    menuOrderPrice = newMenuOrderPrice;
  }

  set setMenuOrderDuration(String newMenuOrderDuration) {
    menuOrderDuration = newMenuOrderDuration;
  }
}
