import 'dart:developer';
import 'dart:io';
import 'package:mindflow/config/appConfig.dart';
import 'package:mindflow/model/ArticleModel.dart';
import 'package:mindflow/provider/authCtx.dart';
import 'package:mindflow/services/Storeservices.dart';
import 'package:mindflow/views/pages/steps/Preview.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:stepper_a/stepper_a.dart';
import '../../provider/articleCtx.dart';
import '../pages/steps/SelectedInfoArticle.dart';
import '../pages/steps/Selectedımage.dart';




class WriteArticle extends StatefulWidget {
  const WriteArticle({super.key});

  @override
  State<WriteArticle> createState() => _WriteArticleState();
}

class _WriteArticleState extends State<WriteArticle> {
  final StepperAController controller = StepperAController();
  StorageServices storageServices = StorageServices();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    final articleCtx = Provider.of<ArticleCtx>(context, listen: true);
    final authCtx = Provider.of<AuthCtx>(context, listen: true);

    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).brightness == Brightness.dark
              ? Colors.black
              : Color.fromARGB(255, 243, 242, 242),
          title: Text(
            "Makale Yaz",
            style: TextStyle(
                color: Theme.of(context).brightness == Brightness.dark
                    ? Colors.white
                    : Colors.black,
                fontWeight: FontWeight.bold),
          ),
        ),
        body: StepperA(
          formValidation: true, pageSwipe: false,
          stepperSize: const Size(350, 100),
          //stepperSize: const Size(300, 95),
          borderShape: BorderShape.circle,
          borderType: BorderType.dash,
          stepperAxis: Axis.horizontal,
          lineType: LineType.dotted,
          stepperBackgroundColor: Colors.transparent,
          stepperAController: controller,
          stepHeight: 45,
          stepWidth: 45,
          stepBorder: true,

          customSteps: const [
            CustomSteps(stepsIcon: FontAwesomeIcons.tag, title: "Tanım"),
            CustomSteps(stepsIcon: FontAwesomeIcons.book, title: "Detay"),
            CustomSteps(stepsIcon: FontAwesomeIcons.eye, title: "Önizleme"),
            //  CustomSteps(image: Image.asset("assets/pic/pay.png", color: Colors.white), title: "Payment"),
          ],
          step: StepA(
              currentStepColor: Theme.of(context).brightness == Brightness.dark
                  ? Colors.black
                  : Colors.black,
              completeStepColor: Colors.orange,
              inactiveStepColor: Color.fromARGB(115, 113, 113, 113),
              // loadingWidget: CircularProgressIndicator(color: Colors.green,),
              margin: EdgeInsets.all(5)),

          previousButton: (int index) => StepperAButton(
            margin: EdgeInsets.only(
              bottom: 50,
              left: 20,
              top: 10,
            ),
            width: 170,
            height: 50,
            onTap: (int currentIndex) {},
            buttonWidget: Text('Geri',
                style: TextStyle(fontSize: 14, color: Colors.white)),
          ),
          forwardButton: (index) => StepperAButton(
            margin: EdgeInsets.only(
              right: index == 0 ? 50 : 20,
              bottom: 50,
              left: 5,
              top: 10,
            ),
            width: index == 0 ? 300 : 170,
            height: 50,
            onTap: (int currentIndex) async {},
            onComplete: () async {
              debugPrint("Forward Button click complete step call back!");
              log("ee");

              log("son index");
              String mediaUrl = "";
              if (articleCtx.articleImage != null) {
                EasyLoading.show(status: 'Makale Paylaşılıyor..');

                String mediaUrl = await storageServices
                    .uploadMedia(File(articleCtx.articleImage!.path));
                log("mediaUrl* * * $mediaUrl");
                ArticleModel userModel = ArticleModel(
                  title: articleCtx.titleCtx.text,
                  detail: articleCtx.detailArticle,
                  articleImage: mediaUrl,
                  categoryId: articleCtx.selectedCategory!,
                  userId: authCtx.getUserModel!.id,
                  date: DateTime.now().toString(),
                  likesCount: 0,
                  readCount: 0,
                  readTime: articleCtx.selectedReadTime.toString(),
                  source: articleCtx.sourcheCtx.text ?? "",
                  id: '',
                );
                log("userModel* * * ${userModel}");
                articleCtx.sendArticle(userModel, context);
              }
            },
            buttonWidget: Text(index == 2 ? "Yayınla" : 'İleri',
                style: TextStyle(fontSize: 14, color: Colors.white)),
          ),
          stepperBodyWidget: [
            // StepOne(controller: controller),
            SelectedInfoArticle(),

            Container(child: SelectedImage()),
            Preview()
          ],
        ));
  }
}
