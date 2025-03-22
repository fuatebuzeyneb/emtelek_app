// import 'package:flutter/material.dart';

// class CustomLoadingIndicator extends StatefulWidget {
//   const CustomLoadingIndicator({super.key});

//   @override
//   _CustomLoadingIndicatorState createState() => _CustomLoadingIndicatorState();
// }

// class _CustomLoadingIndicatorState extends State<CustomLoadingIndicator>
//     with TickerProviderStateMixin {
//   late AnimationController _controller;
//   late Animation<Offset> _offsetAnimation;
//   late int _iconIndex;

//   final List<Widget> _icons = [
//     Icon(Icons.directions_car, size: 40, color: Colors.blue),
//     Icon(Icons.house, size: 40, color: Colors.blue),
//     Icon(Icons.business, size: 40, color: Colors.blue),
//     Icon(Icons.map, size: 40, color: Colors.blue),
//   ];

//   @override
//   void initState() {
//     super.initState();
//     _iconIndex = 0;

//     _controller = AnimationController(
//       vsync: this,
//       duration:
//           const Duration(milliseconds: 500), // تقليل الوقت لجعل الحركة أسرع
//     );

//     _offsetAnimation = Tween<Offset>(
//       begin: const Offset(1.0, 0.0), // تظهر من جهة اليمين
//       end: const Offset(-1.0, 0.0), // ثم تتحرك إلى اليسار
//     ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));

//     // تغيير الأيقونة كل 2 ثانية مع حركة
//     Future.delayed(Duration(seconds: 1), _changeIcon);
//   }

//   void _changeIcon() {
//     setState(() {
//       _iconIndex = (_iconIndex + 1) % _icons.length;
//     });

//     _controller.forward(from: 0.0); // بدء الحركة
//     Future.delayed(
//         Duration(milliseconds: 650), _changeIcon); // استمر في التغيير
//   }

//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Center(
//       child: ClipOval(
//         child: Container(
//           width: 100,
//           height: 100,
//           color: Colors.black, // لون الدائرة الأبيض
//           child: Stack(
//             children: [
//               SlideTransition(
//                 position: _offsetAnimation,
//                 child: Center(
//                   child: AnimatedSwitcher(
//                     duration: const Duration(milliseconds: 500),
//                     child: _icons[_iconIndex],
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
