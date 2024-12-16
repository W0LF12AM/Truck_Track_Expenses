// import 'package:flutter/material.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:note_app_vtwo/Page/Landing_Page.dart';
// import 'package:note_app_vtwo/Page/Laporan_Detil_Permobil_Page.dart';
// import 'package:note_app_vtwo/Page/Laporan_Permobil_Menu_Page.dart';
// import 'package:note_app_vtwo/Page/Set_Budget_Page.dart';
// import 'package:note_app_vtwo/settings/screen_utils.dart';
// import 'package:note_app_vtwo/settings/style_and_colors_utils.dart';

// class Drawermenu extends StatelessWidget {
//   const Drawermenu({super.key});

//   @override
//   Widget build(BuildContext context) {
//     double ukuranWidget1 = ScreenUtils.getUkuranWidget(context, baseSize: 80);
//     double ukuranWidget2 = ScreenUtils.getUkuranWidget(context, baseSize: 50);
//     double ukuranSizedBox1 =
//         ScreenUtils.getUkuranWidget(context, baseSize: 400);

//     final List<Map<String, dynamic>> iconItems = [
//       {
//         'icon': 'assets/home button.svg',
//         'label': 'Home',
//         'screen': const LandingPage()
//       },
//       {
//         'icon': 'assets/report icon.svg',
//         'label': 'Report',
//         'screen': const LaporanPermobilMenuPage()
//       },
//       {
//         'icon': 'assets/setting icon.svg',
//         'label': 'Settings',
//         'screen': const SetBudgetPage()
//       },
//       {
//         'icon': 'assets/expense icon.svg',
//         'label': 'Expenses',
//         'screen': const LaporanDetilPermobilPage()
//       },
//     ];

//     return Container(
//       decoration: const BoxDecoration(color: secondaryColor),
//       child: Padding(
//         padding: const EdgeInsets.all(20),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//           children: [
//             GestureDetector(
//               onTap: () {},
//               child: SvgPicture.asset(
//                 'assets/Note Logo.svg',
//                 width: ukuranWidget1,
//                 height: ukuranWidget1,
//               ),
//             ),
//             SizedBox(
//               height: ukuranSizedBox1,
//             ),
//             Column(
//                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                 children: iconItems.map((item) {
//                   return Column(
//                     children: [
//                       GestureDetector(
//                         onTap: () {
//                           Navigator.push(
//                               context,
//                               MaterialPageRoute(
//                                   builder: (context) => item['screen']));
//                         },
//                         child: SvgPicture.asset(
//                           item['icon']!,
//                           color: mainColor,
//                           width: ukuranWidget2,
//                           height: ukuranWidget2,
//                         ),
//                       ),
//                       const SizedBox(
//                         height: 40,
//                       )
//                     ],
//                   );
//                 }).toList()),
//             SizedBox(
//               height: 280,
//             ),
//             GestureDetector(
//               onTap: () {},
//               child: SvgPicture.asset(
//                 'assets/exit icon.svg',
//                 color: mainColor,
//                 width: ukuranWidget2,
//                 height: ukuranWidget2,
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'package:note_app_vtwo/settings/style_and_colors_utils.dart';

class Drawermenu extends StatelessWidget {
  Drawermenu(
      {super.key, required this.selectedIndex, required this.onItemTapped});

  final int selectedIndex;
  final Function(int) onItemTapped;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      width: 100,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
        color: secondaryColor,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GestureDetector(
              onTap: () {},
              child: SvgPicture.asset(
                'assets/Note Logo.svg',
                width: 60,
                height: 60,
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ListTile(
                  leading: SvgPicture.asset(
                    'assets/home button.svg',
                    color: mainColor,
                  ),
                  onTap: () {
                    onItemTapped(0);
                    Navigator.pop(context);
                  },
                ),
                SizedBox(
                  height: 40,
                ),
                ListTile(
                  leading: SvgPicture.asset(
                    'assets/home button.svg',
                    color: mainColor,
                  ),
                  onTap: () {
                    onItemTapped;
                    Navigator.pop(context);
                  },
                ),
                SizedBox(
                  height: 40,
                ),
                ListTile(
                  leading: SvgPicture.asset(
                    'assets/home button.svg',
                    color: mainColor,
                  ),
                  onTap: () {
                    onItemTapped;
                    Navigator.pop(context);
                  },
                ),
                SizedBox(
                  height: 40,
                ),
                ListTile(
                  leading: SvgPicture.asset(
                    'assets/home button.svg',
                    color: mainColor,
                  ),
                  onTap: () {
                    onItemTapped(3);
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
            GestureDetector(
              onTap: () {},
              child: SvgPicture.asset(
                'assets/exit icon.svg',
                color: mainColor,
                width: 30,
                height: 30,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
