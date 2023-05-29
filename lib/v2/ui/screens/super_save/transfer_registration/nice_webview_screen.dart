import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import './nice_webview_provider.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:flutter/services.dart';
import 'dart:convert';
import '../../../../core/constants/AppColor.dart';
import '../../../components/custom_snackbar.dart';
import 'package:msquare_market/v2/core/enums/view_state.dart';

class NiceWebViewScreen extends StatefulWidget {
  const NiceWebViewScreen({Key? key}) : super(key: key);

  @override
  State<NiceWebViewScreen> createState() => _NiceWebViewScreenState();
}

class _NiceWebViewScreenState extends State<NiceWebViewScreen> {
  int progress = 0;

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as Map;
    return ChangeNotifierProvider(
        create: (context) => NiceWebViewProvider(args),
        child: Consumer<NiceWebViewProvider>(builder: (context, model, child) {
          return Scaffold(
            appBar: AppBar(),
            body: model.state == ViewState.busy
                ? Center(
                    child: CircularProgressIndicator(
                      color: AppColor.primaryColor100,
                    ),
                  )
                : Stack(
                    children: [
                      WebView(
                        initialUrl: "about:blank",
                        javascriptMode: JavascriptMode.unrestricted,
                        onWebViewCreated: (webViewController) async {
                          String fileText = await rootBundle
                              .loadString('assets/super_save/html/index.html');
                          webViewController.loadUrl(Uri.dataFromString(fileText,
                                  mimeType: 'text/html',
                                  encoding: Encoding.getByName('utf-8'))
                              .toString()
                              .replaceAll(
                                  'PHONE_AUTH_TOKEN', '\"${model.token}\"'));
                        },
                        onProgress: (a) {
                          setState(() {
                            progress = a;
                          });
                        },
                        onWebResourceError: (error) {
                          print(
                              "${error.description}, ${error.domain}, ${error.errorCode}, ${error.errorType}");
                          customSnackBar(
                            context,
                            "${error.description}",
                            duration: Duration(seconds: 1),
                          );
                        },
                      ),
                      if (progress < 100)
                        LinearProgressIndicator(
                          minHeight: 5,
                          value: progress / 100.0,
                          color: AppColor.primaryColor100,
                        ),
                    ],
                  ),
          );
        }));
  }
}
