import 'package:mindflow/provider/authCtx.dart';
import 'package:mindflow/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class PrivacyPolicyPage extends StatefulWidget {
  PrivacyPolicyPage({super.key});

  @override
  State<PrivacyPolicyPage> createState() => _PrivacyPolicyPageState();
}

class _PrivacyPolicyPageState extends State<PrivacyPolicyPage> {
  AuthServices authServices = AuthServices();

  @override
  Widget build(BuildContext context) {
    final authCtx = Provider.of<AuthCtx>(context, listen: true);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          "MindFlow Gizlilik Sözleşmesi",
          style: GoogleFonts.signika(
              color: Colors.black, fontSize: 20, fontWeight: FontWeight.w600),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 15, right: 15, bottom: 20, top: 8),
        child: SingleChildScrollView(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    "Son Güncelleme Tarihi: 28 Eylül 2023",
                    style: GoogleFonts.signika(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.w400),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  "Hoş geldiniz MindFlow'a!\MindFlow'ı kullanarak, aşağıda belirtilen şartları ve koşulları kabul etmiş olursunuz.\n\nBu Gizlilik Sözleşmesi, MindFlow uygulamasının kullanımınızla ilgili sizin ve MindFlow arasındaki anlaşmanın bir parçasıdır.",
                  style: GoogleFonts.signika(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.w200),
                ),
                SizedBox(
                  height: 10,
                ),
                Align(
                  alignment: Alignment.topCenter,
                  child: Text(
                    "1. Kullanıcı Bilgileri",
                    style: GoogleFonts.signika(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.w600),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  "1.1. Kişisel Bilgiler:",
                  style: GoogleFonts.signika(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.w600),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  "MindFlow uygulamasına Google hesabınızla giriş yaptığınızda, Google'dan aldığımız temel bilgiler (örneğin, adınız ve e-posta adresiniz) bu uygulamayı kullanmanızı sağlamak için kullanılır. Bu bilgiler, uygulamanın düzgün çalışması ve kullanıcı deneyiminin iyileştirilmesi için gereklidir.",
                  style: GoogleFonts.signika(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.w300),
                ),
                SizedBox(
                  height: 10,
                ),
                Align(
                  alignment: Alignment.topCenter,
                  child: Text(
                    "2. Makale Paylaşımları",
                    style: GoogleFonts.signika(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.w600),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  "2.1. Telif Hakları:",
                  style: GoogleFonts.signika(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.w600),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  " MindFlow'da paylaştığınız makalelerin telif hakları tamamen sizin sorumluluğunuzdadır. Uygulamada paylaşılan makalelerin içeriği veya telif hakları konusunda 'MindFlow' herhangi bir sorumluluk kabul etmez.\nİlgili telif hakkı ihlali veya yasal sorumluluklar Makaleleri paylaşan Kullanıcılara aittir.",
                  style: GoogleFonts.signika(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.w300),
                ),
                SizedBox(
                  height: 10,
                ),
                Align(
                  alignment: Alignment.topCenter,
                  child: Text(
                    "3. Gizlilik ve Güvenlik",
                    style: GoogleFonts.signika(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.w600),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  "3.1. Veri Güvenliği:",
                  style: GoogleFonts.signika(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.w600),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  "MindFlow, kullanıcıların kişisel bilgilerini korumak için uygun güvenlik önlemlerini alır.",
                  style: GoogleFonts.signika(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.w300),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  "3.2. Üçüncü Taraf Bağlantıları:",
                  style: GoogleFonts.signika(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.w600),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  "MindFlow uygulaması, üçüncü taraf web sitelerine veya hizmetlere bağlantılar içermez ve kullanıcıları uygulama içinde tutar. Bu nedenle, uygulama içeriğinin dışına çıkmazsınız ve başka sitelere veya hizmetlere erişim sağlanmaz.",
                  style: GoogleFonts.signika(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.w300),
                ),
                SizedBox(
                  height: 10,
                ),
                Align(
                  alignment: Alignment.topCenter,
                  child: Text(
                    "4. Gizlilik Sözleşmesi Kabulü",
                    style: GoogleFonts.signika(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.w600),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  """4.1. MindFlow uygulamasını kullanarak, bu Gizlilik Sözleşmesi'ni kabul etmiş sayılırsınız. Gizlilik Sözleşmesi'nde değişiklik yapılması durumunda, güncellenmiş sürümü kullanmaya devam ettiğinizde bu değişiklikleri kabul etmiş olursunuz.

Lütfen MindFlow'ı kullanmadan önce bu Gizlilik Sözleşmesi'ni dikkatlice okuyun. Eğer bu sözleşmeyi kabul etmiyorsanız, MindFlow'ı kullanmamalısınız.

Herhangi bir soru veya endişeniz varsa, lütfen İletişim MindFlowInfo@gmail.com adresinden bize ulaşın.""",
                  style: GoogleFonts.signika(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.w300),
                ),
                SizedBox(
                  height: 30,
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: InkWell(
                    onTap: () {
                      setState(() {});
                      
                      authServices.signInWithGoogle(context: context, isPrivacyPolicyAccepted:true);
                    },
                    child: Container(
                      width: 300,
                      height: 50,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: Colors.blue),
                      child: Center(
                        child: Text(
                          "Kabul Et",
                          style: GoogleFonts.signika(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                    ),
                  ),
                )
              ]),
        ),
      ),
    );
  }
}
