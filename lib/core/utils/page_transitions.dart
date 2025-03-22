import 'package:flutter/material.dart';

void pageTransition(BuildContext context,
    {required Widget page, Duration? duration, Offset? begin}) {
  Navigator.of(context).push(PageRouteBuilder(
    transitionDuration: duration ??
        const Duration(milliseconds: 1000), // تحديد مدة الانتقال هنا
    pageBuilder: (context, animation, secondaryAnimation) => page,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      begin = begin ?? const Offset(-1.0, 0.0); // يبدأ من اليمين
      const end = Offset.zero;
      const curve = Curves.ease;

      var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
      var offsetAnimation = animation.drive(tween);

      return SlideTransition(
        position: offsetAnimation,
        child: child,
      );
    },
  ));
}
//*