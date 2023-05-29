import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../core/constants/AppColor.dart';
import '../../../core/constants/style.dart';
import '../../screens/super_save/settings_participation_history/settings_particpation_detail.dart';
import '../divider_widget.dart';
import 'package:get/get.dart';

class DailyParticipationListTile extends StatelessWidget {
  const DailyParticipationListTile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        ListTile(
          leading: Text(
            "12:00",
            style: poppinsTextStyle(14, FontWeight.w500, AppColor.greyColor50),
          ),
          title: Text(
            "10,000MSQ",
            style: poppinsTextStyle(16, FontWeight.w600, AppColor.greyColor100),
          ),
          subtitle: Text(
            "(전송일시 01-03 09:00)",
            style: poppinsTextStyle(14, FontWeight.w500, AppColor.greyColor50),
          ),
          trailing: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              GestureDetector(
                onTap: () {
                  Get.to(() => SettingsParticipationDetailScreen());
                },
                child: Icon(CupertinoIcons.doc_plaintext,
                    color: AppColor.greyColor50),
              ),
              Text(
                "200,000원",
                style: poppinsTextStyle(
                    14, FontWeight.w600, AppColor.primaryColor100),
              ),
            ],
          ),
        ),
        DividerWidget(),
      ],
    );
  }
}
