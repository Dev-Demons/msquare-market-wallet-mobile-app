import 'package:camera/camera.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:msquare_market/v2/core/constants/AppColor.dart';
import 'package:msquare_market/v2/core/models/super_save/request_model.dart';
import 'package:msquare_market/v2/core/services/API/super_save_api_service.dart';
import 'package:msquare_market/v2/ui/screens/super_save/bank_integration/connect_bank_account.dart';
import 'package:msquare_market/v2/ui/widgets/custom_button.dart';
import 'package:msquare_market/v2/ui/widgets/password_snackbar.dart';
import 'dart:io';
import '../../../../core/constants/style.dart';
import '../../../../core/models/super_save/transaction_register_model.dart';
import 'upload_id_screen.dart';

class UploadProfileScreen extends StatefulWidget {
  const UploadProfileScreen({Key? key}) : super(key: key);

  @override
  State<UploadProfileScreen> createState() => _UploadProfileScreenState();
}

class _UploadProfileScreenState extends State<UploadProfileScreen> {
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
            hasImage ? "\n" : "얼굴과 신분증을 영역안에 맞추면\n자동으로 촬영됩니다.",
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
                    "신분증을 얼굴 밑에 두고\n영역에 맞춰 촬영하세요.\n신분증에 빛이 반사되지 않도록\n주의해주세요.",
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
                              showCustomSnackBar('Profile Image Upload',
                                  result['data'], AppColor.dangerColor10);
                            } else {
                              showCustomSnackBar('Profile Image Upload',
                                  "Image uploaded", AppColor.successColor30);
                              final args = ModalRoute.of(context)!
                                  .settings
                                  .arguments as TransactionRegisterModel;
                              args.addImagesURL(result['data'], args.idImage!);
                              await cameraController!.dispose();
                              Get.to(() => ConnectBankAccount(),
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
