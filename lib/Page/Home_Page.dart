import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:note_app_vtwo/Page/Kelola_Mobil_Page.dart';
import 'package:note_app_vtwo/Page/Landing_Page.dart';
import 'package:note_app_vtwo/Page/Laporan_Detil_Permobil_Page.dart';
import 'package:note_app_vtwo/Page/Laporan_Permobil_Menu_Page.dart';
import 'package:note_app_vtwo/Page/Set_Budget_Page.dart';
import 'package:note_app_vtwo/settings/style_and_colors_utils.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          // Sidebar
          Container(
            width: 100, // Lebar sidebar
            color: secondaryColor,
            child: Padding(
              padding:
                  const EdgeInsets.only(top: 20, bottom: 20, left: 5, right: 5),
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
                  // Menu Items
                  Column(
                    children: [
                      GestureDetector(
                        child: Container(
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                              color: _selectedIndex == 0
                                  ? mainColor
                                  : secondaryColor,
                              borderRadius: BorderRadius.circular(5)),
                          child: SvgPicture.asset(
                            'assets/home button.svg',
                            color: _selectedIndex == 0
                                ? secondaryColor
                                : mainColor,
                          ),
                        ),
                        onTap: () {
                          _onItemTapped(0);
                        },
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      GestureDetector(
                        child: Container(
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                              color: _selectedIndex == 1
                                  ? mainColor
                                  : secondaryColor,
                              borderRadius: BorderRadius.circular(5)),
                          child: SvgPicture.asset(
                            'assets/car icon.svg',
                            height: 40,
                            width: 40,
                            color: _selectedIndex == 1
                                ? secondaryColor
                                : mainColor,
                          ),
                        ),
                        onTap: () {
                          _onItemTapped(1);
                        },
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      GestureDetector(
                        child: Container(
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                              color: _selectedIndex == 2
                                  ? mainColor
                                  : secondaryColor,
                              borderRadius: BorderRadius.circular(5)),
                          child: SvgPicture.asset(
                            'assets/report icon.svg',
                            color: _selectedIndex == 2
                                ? secondaryColor
                                : mainColor,
                          ),
                        ),
                        onTap: () {
                          _onItemTapped(2);
                        },
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      GestureDetector(
                        child: Container(
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                              color: _selectedIndex == 3
                                  ? mainColor
                                  : secondaryColor,
                              borderRadius: BorderRadius.circular(5)),
                          child: SvgPicture.asset(
                            'assets/setting icon.svg',
                            color: _selectedIndex == 3
                                ? secondaryColor
                                : mainColor,
                          ),
                        ),
                        onTap: () {
                          _onItemTapped(3);
                        },
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      GestureDetector(
                        child: SvgPicture.asset(
                          'assets/expense icon.svg',
                          color: _selectedIndex == 4 ? mainColor : Colors.black,
                        ),
                        onTap: () {
                          _onItemTapped(4);
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
          ),

          // Body
          Expanded(
              child: IndexedStack(index: _selectedIndex, children: [
            LandingPage(
              onItemTapped: _onItemTapped,
            ),
            const KelolaMobilPage(),
            const LaporanPermobilMenuPage(),
            const SetBudgetPage(),
            const LaporanDetilPermobilPage(),
          ])),
        ],
      ),
    );
  }
}
