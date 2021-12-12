// import 'dart:math';

// import 'package:flutter/material.dart';
// import 'package:todo_app/color.dart';

// //floating animation button

// class Circlefloatingbtn extends StatefulWidget {
//   const Circlefloatingbtn({Key? key}) : super(key: key);

//   @override
//   _CirclefloatingbtnState createState() => _CirclefloatingbtnState();
// }

// class _CirclefloatingbtnState extends State<Circlefloatingbtn>
//     with SingleTickerProviderStateMixin {
//   late AnimationController controller;

//   @override
//   void initState() {
//     super.initState();
//     controller = AnimationController(
//       duration: Duration(milliseconds: 200),
//       vsync: this,
//     );
//   }

//   @override
//   void dispose() {
//     controller.dispose();
//     super.dispose();
//   }

//   double btnsize = 65;
//   @override
//   Widget build(BuildContext context) {
//     return Flow(
//       delegate: FlowMenuDelegate(controller: controller),
//       children: <IconData>[
//         Icons.settings,
//         Icons.edit,
//         Icons.delete,
//         Icons.add,
//         Icons.menu,
//       ].map<Widget>(buildFab).toList(),
//     );
//   }

//   Widget buildFab(IconData icon) => SizedBox(
//         width: btnsize,
//         height: btnsize,
//         child: FloatingActionButton(
//             elevation: 0,
//             splashColor: splashcolor,
//             child: Icon(
//               icon,
//               color: white,
//               size: 45,
//             ),
//             onPressed: () {
//               if (controller.status == AnimationStatus.completed) {
//                 controller.reverse();
//               } else {
//                 controller.forward();
//               }
//             }),
//       );
// }

// class FlowMenuDelegate extends FlowDelegate {
//   final Animation<double> controller;
//   const FlowMenuDelegate({required this.controller})
//       : super(repaint: controller);
//   @override
//   void paintChildren(FlowPaintingContext context) {
//     final size = context.size;
//     final xstart = size.width - 65;
//     final ystart = size.height - 65;
//     final n = context.childCount;
//     for (var i = 0; i < n; i++) {
//       final isLastItem = i == context.childCount - 1;
//       final setValue = (value) => isLastItem ? 0.0 : value;
//       final radius = 180 * controller.value;
//       final theta = i * pi * 0.5 / (n - 2);
//       final x =xstart- setValue(radius * cos(theta));
//       final y =ystart- setValue(radius * sin(theta));
//       context.paintChild(i,
//           transform: Matrix4.identity()
//             ..translate(x, y, 0)
//             ..translate(65 / 2, 65 / 2)
//             ..rotateZ(
//                 isLastItem ? 0.0 : 180 * (1 - controller.value) * pi / 180)
//             ..scale(isLastItem ? 1.0 : max(controller.value, 0.5))
//             ..translate(-65 / 2, -65 / 2));
//     }
//   }

//   @override
//   bool shouldRepaint(FlowMenuDelegate oldDelegate) => false;
// }

// void showdeletedialog(BuildContext context) => showDialog(
//       context: context,
//       builder: (BuildContext context) => CupertinoAlertDialog(
//         title: Text("Delete"),
//         content: Text("Are You sure to Delete"),
//         actions: [
//           CupertinoDialogAction(
//             child: TextButton(
//               onPressed: () {},
//               child: Text("No"),
//             ),
//           ),
//           CupertinoDialogAction(
//             child: TextButton(
//               onPressed: () {
//                 Navigator.pop(context);
//               },
//               child: Text("yes"),
//             ),
//           ),
//         ],
//       ),
//     );