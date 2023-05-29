import 'package:camera/camera.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:msquare_market/v2/core/constants/AppColor.dart';
import 'package:msquare_market/v2/core/constants/style.dart';
import 'package:msquare_market/v2/ui/screens/super_save/transfer_registration/upload_profile_screen.dart';
import 'dart:io';

import '../../../../core/models/super_save/request_model.dart';
import '../../../../core/models/super_save/transaction_register_model.dart';
import '../../../../core/services/API/super_save_api_service.dart';
import '../../../widgets/custom_button.dart';
import '../../../widgets/password_snackbar.dart';

class UploadIDScreen extends StatefulWidget {
  const UploadIDScreen({Key? key}) : super(key: key);

  @override
  State<UploadIDScreen> createState() => _UploadIDScreenState();
}

class _UploadIDScreenState extends State<UploadIDScreen> {
  List<CameraDescription> cameras = [];
  CameraController? cameraController;
  bool isLoaded = false;
  bool hasImage = false;
  XFile? imageFile;

  init() async {
    cameras = await availableCameras();
    cameraController = CameraController(cameras[0], ResolutionPreset.max);
    cameraController!.initialize().then((_) {
      if (!mounted) {
        return;
      }
      setState(() {});
    }).catchError((Object e) {
      if (e is CameraException) {
        print(e.code);
        switch (e.code) {
          case 'CameraAccessDenied':
            // Handle access errors here.
            break;
          default:
            // Handle other errors here.
            break;
        }
      }
    });
    isLoaded = true;
    setState(() {});
  }

  clear() async {
    await cameraController!.dispose();
  }

  @override
  void initState() {
    init();
    super.initState();
  }

  @override
  void dispose() {
    clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.greyColor70,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppColor.greyColor70,
        automaticallyImplyLeading: false,
        actions: [
          TextButton(
            onPressed: () {
              Get.back();
            },
            child: Text(
              "취소",
              style:
                  poppinsTextStyle(16, FontWeight.w600, AppColor.primaryColor0),
            ),
          )
        ],
      ),
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        children: [
          Text(
            hasImage ? "\n" : "신분증을 영역안에 맞추면 \n 자동으로 촬영됩니다.",
            style: poppinsTextStyle(
              20,
              FontWeight.w600,
              AppColor.primaryColor0,
            ),
            textAlign: TextAlign.center,
          ),
          Container(
              margin: EdgeInsets.symmetric(vertical: 40, horizontal: 20),
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.25,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.white)),
              child: isLoaded
                  ? ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: hasImage
                          ? Image.file(File(imageFile!.path), fit: BoxFit.fill)
                          : CameraPreview(cameraController!),
                    )
                  : Center(
                      child: CircularProgressIndicator(),
                    )),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 20),
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * 0.25,
            decoration: BoxDecoration(
              color: AppColor.greyColor60,
              borderRadius: BorderRadius.circular(10),
            ),
            child: DottedBorder(
                borderType: BorderType.RRect,
                radius: Radius.circular(10),
                color: AppColor.greyColor30,
                child: Center(
                  child: Text(
                    "신분증에 빛이 반사되지 않도록 \n 영역안에 맞춰주세요.",
                    style: poppinsTextStyle(
                      16,
                      FontWeight.w600,
                      AppColor.primaryColor0,
                    ),
                    textAlign: TextAlign.center,
                  ),
                )),
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 20, vertical: 40),
            child: hasImage
                ? Row(
                    children: [
                      Expanded(
                        child: CustomMaterialButton(
                          title: "다시찍기",
                          btnColor: Colors.white,
                          textColor: AppColor.greyColor100,
                          onPressed: () {
                            setState(() {
                              hasImage = false;
                            });
                          },
                          radius: 100,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: CustomMaterialButton(
                          title: "다음",
                          btnColor: AppColor.primaryColor100,
                          textColor: Colors.white,
                          onPressed: () async {
                            setState(() {
                              isLoaded = false;
                            });
                            var result = await SuperSaveAPIService()
                                .uploadImage(path: imageFile!.path);
                            setState(() {
                              isLoaded = true;
                            });
                            if (result['error']) {
                              showCustomSnackBar('ID Image Upload',
                                  result['data'], AppColor.dangerColor10);
                            } else {
                              showCustomSnackBar('ID Image Upload',
                                  "Image uploaded", AppColor.successColor30);
                              final args = ModalRoute.of(context)!
                                  .settings
                                  .arguments as TransactionRegisterModel;
                              args.addImagesURL("0", result['data']);
                              await cameraController!.dispose();
                              Get.to(() => UploadProfileScreen(),
                                  arguments: args);
                            }
                          },
                          radius: 100,
                        ),
                      )
                    ],
                  )
                : CustomMaterialButton(
                    onPressed: () async {
                      setState(() {
                        isLoaded = false;
                      });
                      imageFile = await cameraController!.takePicture();
                      hasImage = true;
                      isLoaded = true;
                      setState(() {});

                      // Get.back();
                    },
                    radius: 100,
                    title: "사진찍기",
                    btnColor: AppColor.primaryColor100,
                    textColor: Colors.white,
                  ),
          ),
        ],
      ),
    );
  }
}
