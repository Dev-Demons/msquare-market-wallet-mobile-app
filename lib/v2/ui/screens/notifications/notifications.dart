import 'package:msquare_market/v2/core/constants/borders.dart';
import 'package:msquare_market/v2/core/constants/colors.dart';
import 'package:msquare_market/v2/core/constants/style.dart';
import 'package:msquare_market/v2/ui/screens/notifications/notification_provider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:msquare_market/v2/ui/widgets/divider_widget.dart';
import 'package:provider/provider.dart';

import '../../../core/constants/AppColor.dart';
import '../../../core/enums/view_state.dart';
import '../../../core/models/notification_model.dart';

/// A [Screen]/[View[ that shows us the [User]'s notification
/// currently not [implemented]
class NotificationScreen extends StatefulWidget {
  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => NotificationProvider(),
      child: Consumer<NotificationProvider>(
        builder: (context, model, child) {
          return Scaffold(
            // appbar
            appBar: AppBar(
              title: Text("announcement".tr),
            ),
            backgroundColor: AppColor.greyColor0,
            // show empty notification widget
            body: model.state == ViewState.busy
                ? Center(
                    child: CircularProgressIndicator(
                        color: AppColor.primaryColor70),
                  )
                : model.notifications.isEmpty
                    ? firstUserWidget()
                    : ListView.separated(
                        padding:
                            EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                        itemBuilder: (context, index) {
                          var item = model.notifications[index];
                          return AnnouncementCardWidget(data: item);
                        },
                        separatorBuilder: (context, index) {
                          return SizedBox(height: 8);
                        },
                        itemCount: model.notifications.length),
          );
        },
      ),
    );
  }

  /// [Widget] that shows the empty [Notification] screen
  Widget firstUserWidget() {
    return Container(
      color: greyColor10,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(child: SizedBox()),
          Center(
              child: Image.asset(
            "assets/my_icons/emptynotification.png",
            height: 98,
            width: 98,
          )),
          SizedBox(
            height: 32,
          ),
          Center(child: Text("nothing_to_show".tr)),
          Expanded(child: SizedBox()),
        ],
      ),
    );
  }
}

class AnnouncementCardWidget extends StatelessWidget {
  const AnnouncementCardWidget({Key? key, required this.data})
      : super(key: key);
  final NotificationResponse data;
  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      elevation: 0,
      shape: commonRoundedRectangularBorder(),
      margin: EdgeInsets.only(bottom: 8),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            ListTile(
              leading: CircleAvatar(
                radius: 12,
                backgroundColor: data.status == "success"
                    ? AppColor.successColor30
                    : AppColor.dangerColor10,
                child: Icon(
                    data.status == "success" ? Icons.check : Icons.close,
                    color: Colors.white,
                    size: 16),
              ),
              minLeadingWidth: 0,
              minVerticalPadding: 0,
              horizontalTitleGap: 8,
              contentPadding: EdgeInsets.zero,
              title: Text(
                data.status!.substring(0, 1).toUpperCase() +
                    data.status!.substring(1),
                style: poppinsTextStyle(
                    16, FontWeight.w500, AppColor.greyColor100),
              ),
              trailing: Text(
                "10분전",
                style:
                    poppinsTextStyle(13, FontWeight.w500, AppColor.greyColor50),
              ),
            ),
            Text(
              "Your super save participation request has been ${data.status!}",
              style:
                  poppinsTextStyle(14, FontWeight.w500, AppColor.greyColor50),
            ),
            SuperSaveDividerWidget(vertical: 12),
            Row(
              children: [
                Text(
                  "Amount in KRW: ",
                  style: poppinsTextStyle(
                      14, FontWeight.w500, AppColor.greyColor100),
                ),
                Text(
                  data.amountMsq!,
                  style: poppinsTextStyle(
                      14, FontWeight.w500, AppColor.greyColor50),
                )
              ],
            ),
            SizedBox(height: 8),
            Row(
              children: [
                Text(
                  "Amount in MSQ: ",
                  style: poppinsTextStyle(
                      14, FontWeight.w500, AppColor.greyColor100),
                ),
                Text(
                  data.amountMsq!,
                  style: poppinsTextStyle(
                      14, FontWeight.w500, AppColor.greyColor50),
                )
              ],
            ),
            SizedBox(height: 8),
            Row(
              children: [
                Text(
                  "Tx: ",
                  style: poppinsTextStyle(
                      14, FontWeight.w500, AppColor.greyColor100),
                ),
                Expanded(
                  child: Text(
                    data.txId!,
                    overflow: TextOverflow.ellipsis,
                    style: poppinsTextStyle(
                        14, FontWeight.w500, AppColor.greyColor50),
                  ),
                ),
                Spacer(),
              ],
            ),
            SizedBox(height: 8),
            Row(
              children: [
                Text(
                  "Comment: ",
                  style: poppinsTextStyle(
                      14, FontWeight.w500, AppColor.greyColor100),
                ),
                Expanded(
                  child: Text(
                    data.comment!,
                    overflow: TextOverflow.ellipsis,
                    style: poppinsTextStyle(
                        14, FontWeight.w500, AppColor.greyColor50),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
