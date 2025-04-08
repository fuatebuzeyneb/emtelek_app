class IconHelper {
  static const Map<int, String> _iconsMap = {
    1: 'assets/icons/car.png',
    2: 'assets/icons/exit.png',
  };

  static String getIconPath(int id) {
    return _iconsMap[id] ?? 'assets/icons/whatsapp.png';
  }
}
