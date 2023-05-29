import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/constants/colors.dart';
import '../../../core/constants/style.dart';
import '../../../core/models/order_model.dart';
import '../../screens/p2p/p2p_provider.dart';
import '../buttons/custom_cancel_button.dart';
import '../dialogues/custom_alert_dialog.dart';
import '../password_snackbar.dart';
import 'custom_circular_indicator.dart';
import 'empty_listing_widget.dart';
import 'order_widget.dart';

/// A [StatelessWidget] that displays list of Token Orders that can
/// either be bought or sold.

class OrderListWidget extends StatelessWidget {
  /// [Constructor] that initializes the widget.
  const OrderListWidget({
    Key? key,
    this.orderList,
    required this.scrollController,
    required this.orderFetched,
    this.model,
  }) : super(key: key);

  /// [List] variable that holds all the orders
  final orderList;

  /// [ScrollController] variable that stores scroll controller
  final ScrollController scrollController;

  /// A [boolean] flag that let us know to whether fetch new orders and display them or not.
  final bool orderFetched;

  /// Variable that holds the current models values
  final model;

  @override
  Widget build(BuildContext context) {
    // check if orderList is empty show specific widget
    return orderList.length == 0
        ? EmptyListingWidget()
        : Expanded(
            child: ListView.builder(
                controller: scrollController,
                shrinkWrap: true,
                padding: EdgeInsets.zero,
                // item Count is greater to show Spinner for new loading
                itemCount: orderList.length + 1,
                physics: ScrollPhysics(),
                itemBuilder: (context, index) {
                  if (index < orderList.length) {
                    // P2P Order Widget
                    return P2PScreenOrderWidget(
                      order: orderList[index],
                      onPressed: () {
                        // confirmation alert box
                        confirmationDialogue(context, model, orderList[index]);
                      },
                    );
                  } else if ((index >= 2 && index >= orderList.length) &&
                      !orderFetched) {
                    return CustomCircularIndicator();
                  } else {
                    return Text("");
                  }
                }),
          );
  }

  /// [Function] that accepts:
  /// - [context] which is current [BuildContext]
  /// - [model] which is a [P2PProvider] model
  /// - [ordersData] which is orderList
  confirmationDialogue(context, P2PProvider model, OrdersData ordersData) {
    // Boolean flag to check whether the button has been
    // done or not.
    bool isFetched = false;
    return showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        // Custom Alert Dialog
        builder: (context, setState) => CustomAlertDialog(
            // Alert Dialog title
            title: "you_sure",
            // Alert Dialog Message
            message: "really_sure",
            // Alert Dialog Alignment
            align:
                !isFetched ? MainAxisAlignment.end : MainAxisAlignment.center,
            // Alert Dialog actions for whether to show buttons or spinner
            actions: !isFetched
                ? <Widget>[
                    // cancel button
                    CustomCancelButton(),
                    TextButton(
                      onPressed: () async {
                        setState(() {
                          isFetched = !isFetched;
                        });
                        // complete buy and sell order
                        final result = await model.apiServices.completedOrders(
                          orderId: ordersData.id,
                          email: ordersData.createdBy,
                          currency: ordersData.currency,
                          amount: ordersData.amount,
                        );
                        // if completed show completed snackbar and
                        // re-fetch all orders
                        if (result == true) {
                          model.showSuccessfulSnackBar(context);
                          await model.reset();
                          await model.fetchAllOrdersData();
                          Get.back();
                        }
                        // otherwise go back and show th error
                        else {
                          Get.back();
                          showCustomSnackBar("P2P Buy",
                              jsonDecode(result)["message"], dangerColor10);
                        }

                        setState(() {
                          isFetched = !isFetched;
                        });
                      },
                      child: Text("i_sure".tr,
                          style: poppinsTextStyle(
                              14, FontWeight.w500, primaryColor70)),
                    )
                  ]
                : [CircularProgressIndicator()]),
      ),
    );
  }
}
