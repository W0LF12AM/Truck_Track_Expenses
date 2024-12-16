import 'package:flutter/material.dart';

import 'package:note_app_vtwo/settings/style_and_colors_utils.dart';

import 'package:note_app_vtwo/widget/setBudgetForm.dart';
import 'package:note_app_vtwo/widget/userHeader_custom_without_searchbar.dart';

class SetBudgetPage extends StatelessWidget {
  const SetBudgetPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: bgColor,
      body: Row(
        children: [
          Expanded(
            child: Column(
              children: [
                UserheaderCustomWithoutSearchbar(
                  iconHeader: 'assets/setting icon.svg',
                  titlePage: 'Kelola Budget',
                ),
                Setbudgetform()
              ],
            ),
          )
        ],
      ),
    );
  }
}
