import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:powerbank/Constants/Colors.dart';
import 'package:powerbank/Constants/strings.dart';
import 'package:powerbank/HelperClasses/Widgets.dart';

class AboutAppScreen extends StatelessWidget {
  const AboutAppScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          CustomerSupport.whatsappSupportAdmin1();
        },
        backgroundColor: color3,
        child: const Icon(
          FontAwesomeIcons.headset,
          color: color4,
        ),
      ),
      backgroundColor: color1,
      body: SafeArea(
        child: Container(
          color: color2,
          child: Column(
            children: [
              Container(
                color: color1,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      SizedBox(
                        height: 20,
                      ),
                      SizedBox(width: 50, height: 50, child: AppIconWidget()),
                      SizedBox(
                        height: 12,
                      ),
                      Text(
                        "ABOUT",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 30,
                            color: color4,
                            fontWeight: FontWeight.bold),
                      ),
                      Text(
                        "DREAM LIGHT CITY",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 30,
                            color: colorWhite,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      for (DescriptionModel oDescription in descriptionList)
                        Column(
                          children: [
                            const SizedBox(
                              height: 8,
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: ClipRRect(
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(15)),
                                child: CachedNetworkImage(
                                  imageUrl: oDescription.imageUrl,
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            Stack(
                              alignment: AlignmentDirectional.center,
                              children: [
                                CachedNetworkImage(
                                  fit: BoxFit.fill,
                                  width: MediaQuery.of(context).size.width - 20,
                                  height: 70,
                                  imageUrl:
                                      "https://res.cloudinary.com/asifakhtarcloudinary/image/upload/v1636911933/PowerBankImages/AppAssets/RedGoldenRibbon.png",
                                ),
                                Column(
                                  children: [
                                    Text(
                                      oDescription.headline,
                                      style: const TextStyle(
                                          fontSize: 16,
                                          color: colorWhite,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    const SizedBox(
                                      height: 8,
                                    ),
                                  ],
                                )
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                oDescription.description,
                                textAlign: TextAlign.center,
                                style: const TextStyle(color: colorWhite),
                              ),
                            ),
                            const SizedBox(
                              height: 4,
                            ),
                            Container(
                              height: 5,
                              width: MediaQuery.of(context).size.width - 20,
                              decoration: const BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10)),
                                  gradient:
                                      LinearGradient(colors: [color3, color4])),
                            ),
                            const SizedBox(
                              height: 4,
                            ),
                          ],
                        ),
                      const SizedBox(
                        height: 12,
                      ),
                      const Text(
                        "New Partnership With",
                        style: TextStyle(
                            color: Colors.amber,
                            fontWeight: FontWeight.bold,
                            fontSize: 20),
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Wrap(
                          alignment: WrapAlignment.center,
                          spacing: 15,
                          runSpacing: 15,
                          children: const [
                            Icon(FontAwesomeIcons.volleyball),
                            Icon(FontAwesomeIcons.medal),
                            Icon(FontAwesomeIcons.paypal),
                            Icon(FontAwesomeIcons.earlybirds),
                            Icon(FontAwesomeIcons.avianex),
                            Icon(FontAwesomeIcons.ccJcb),
                            Icon(FontAwesomeIcons.personBiking),
                            Icon(FontAwesomeIcons.unity),
                            Icon(FontAwesomeIcons.dumbbell),
                            Icon(FontAwesomeIcons.planeDeparture),
                            Icon(FontAwesomeIcons.amazon),
                            Icon(FontAwesomeIcons.spa),
                            Icon(FontAwesomeIcons.fedex),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Wrap(
                          alignment: WrapAlignment.center,
                          spacing: 15,
                          runSpacing: 15,
                          children: [
                            Column(
                              children: [
                                Text(
                                  "Established",
                                  style: TextStyle(
                                      color: colorWhite.withOpacity(0.7),
                                      fontSize: 14),
                                ),
                                const Text(
                                  "2018",
                                  style: TextStyle(
                                      color: colorWhite,
                                      fontSize: 22,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                            Column(
                              children: [
                                Text(
                                  "Nations Covered",
                                  style: TextStyle(
                                      color: colorWhite.withOpacity(0.7),
                                      fontSize: 14),
                                ),
                                const Text(
                                  "12",
                                  style: TextStyle(
                                      color: colorWhite,
                                      fontSize: 22,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                            Column(
                              children: [
                                Text(
                                  "Architectures",
                                  style: TextStyle(
                                      color: colorWhite.withOpacity(0.7),
                                      fontSize: 14),
                                ),
                                const Text(
                                  "18,500+",
                                  style: TextStyle(
                                      color: colorWhite,
                                      fontSize: 22,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                            Column(
                              children: [
                                Text(
                                  "Investors",
                                  style: TextStyle(
                                      color: colorWhite.withOpacity(0.7),
                                      fontSize: 14),
                                ),
                                const Text(
                                  "412,080+",
                                  style: TextStyle(
                                      color: colorWhite,
                                      fontSize: 22,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 60,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: const [
                          SizedBox(
                              width: 25, height: 25, child: AppIconWidget()),
                          SizedBox(
                            width: 12,
                          ),
                          Text(
                            "DREAM LIGHT CITY",
                            style: TextStyle(
                                color: colorWhite,
                                fontSize: 18,
                                fontWeight: FontWeight.w900),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Text(
                        "Copyright © 2018-2022\n$companyName Corporation All Right Reserved",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: colorWhite.withOpacity(0.7), fontSize: 12),
                      ),
                      const SizedBox(
                        height: 100,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class DescriptionModel {
  final String imageUrl;
  final String headline;
  final String description;

  DescriptionModel(
      {required this.imageUrl,
      required this.headline,
      required this.description});
}

List<DescriptionModel> descriptionList = [
  DescriptionModel(
      imageUrl:
          "https://res.cloudinary.com/promisedpayment/image/upload/v1651170428/DreamLightCity/AppAssets/822c91e2-5ead-11e8-9334-2218e7146b04_nynemx.jpg",
      headline: "WHAT ARE WE ECO POWER GROUP?",
      description:
          "Eco Power Corporation is a combining six major world corporations namely International Golf Federation, World Archery Federation, International Cricket Council, Union Internationale Motonautique, International Masters Games Association founded in 2018 to oversee international competition among the national associations of Belgium, Denmark, France, Germany, the Netherlands, Spain, Sweden, India and Switzerland. Headquartered in Zürich, Switzerland, its membership now comprises 211 national associations. The need for a single body to oversee association football became apparent at the beginning of the 20th century with the increasing popularity of international fixtures."),
];
