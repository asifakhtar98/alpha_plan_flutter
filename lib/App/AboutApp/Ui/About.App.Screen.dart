import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:powerbank/Constants/Colors.dart';
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
                  physics: const BouncingScrollPhysics(),
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
                            Icon(FontAwesomeIcons.amazon),
                            Icon(FontAwesomeIcons.planeDeparture),
                            Icon(FontAwesomeIcons.avianex),
                            Icon(FontAwesomeIcons.fedex),
                            Icon(FontAwesomeIcons.telegram),
                            Icon(FontAwesomeIcons.unity),
                            Icon(FontAwesomeIcons.hooli),
                            Icon(FontAwesomeIcons.firefoxBrowser),
                            Icon(FontAwesomeIcons.code),
                            Icon(FontAwesomeIcons.ccJcb),
                            Icon(FontAwesomeIcons.paypal),
                            Icon(FontAwesomeIcons.earlybirds),
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
                                  "2016",
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
                                  "Server Rooms",
                                  style: TextStyle(
                                      color: colorWhite.withOpacity(0.7),
                                      fontSize: 14),
                                ),
                                const Text(
                                  "5",
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
                                  "Servers",
                                  style: TextStyle(
                                      color: colorWhite.withOpacity(0.7),
                                      fontSize: 14),
                                ),
                                const Text(
                                  "215,000+",
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
                                  "510,000+",
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
                        "Copyright © 2016-2022\nEco-Power Corporation All Right Reserved",
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
          "https://res.cloudinary.com/earnindia/image/upload/v1645811487/AlphaPlan2/Documents/ygcqllvwgtgtuywkwdls.jpg",
      headline: "WHAT ARE WE ALPHA?",
      description:
          "Established in July 2016, Alpha Microelectronics Corporation is an IC design house specializing in the design, research, development, application and marketing of integrated circuits. Alpha's common stocks are listed on the Gre-Tai Securities Market (OTC) since September 2018."),
  DescriptionModel(
      imageUrl:
          "https://res.cloudinary.com/earnindia/image/upload/v1645811487/AlphaPlan2/Documents/maoqozzvtc8jxnhn0tfa.jpg",
      headline: "OUR PRODUCTS VALUES",
      description:
          "Currently, the total registered capital is NT \$451.60 million. Alpha's product range covers voice ICs, voice integrated MCUS and IC recording products. These products are primarily used in consumer products such as sound equipment, personal electronics, home appliances, toys, gifts and interactive consumer items."),
  DescriptionModel(
      imageUrl:
          "https://res.cloudinary.com/earnindia/image/upload/v1645811487/AlphaPlan2/Documents/r12wveihth0oz7kgdbxy.jpg",
      headline: "WHAT WE ARE UPTO?",
      description:
          "Alpha's Plan is a profitable and sustainable cloud computing server project which has been developed and managed by the Innovation department of Alpha Microelectronics Corp for already 3 years. With the rapid development of the Internet, we have noticed that a large number of users leave the terminal resources on the network idly, causing a huge waste of resources."),
  DescriptionModel(
      imageUrl:
          "https://res.cloudinary.com/earnindia/image/upload/v1645811487/AlphaPlan2/Documents/tfdtxqphafmffileyk60.jpg",
      headline: "WHO DO WE HELP?",
      description:
          "To reduce waste and recycle, we hereby established a laboratory for product development and progressed an innovative cloud computing server product. The product utilizes the latest cloud technology and the function of \"The Internet of Things\" to improve the operational efficiency of idle resources, creating new revenue streams through digital transformation. It will help We Media content creators to get traffic, to connect different IT equipment at any time and any place, to achieve data access and calculation, and to create value"),
  DescriptionModel(
      imageUrl:
          "https://res.cloudinary.com/earnindia/image/upload/v1645811488/AlphaPlan2/Documents/g7wkb40cwrceywqpquhz.jpg",
      headline: "OUR DATA PROCESSING AT",
      description:
          "At present, This project involves 2 self-built server rooms and 100,000 cloud computing servers, which can independently provide Internet infrastructure services such as computing, storage, online backup, hosting, and bandwidth. Also, we have cooperated with more than a dozen well-known cloud server companies at home and abroad with their leasing services to meet the growing business volume in the future. The cooperating companies include Amazon Cloud, IBM Cloud, Google Cloud, Huawei Cloud, etc."),
  DescriptionModel(
      imageUrl:
          "https://res.cloudinary.com/earnindia/image/upload/v1645811487/AlphaPlan2/Documents/cof3n6sy0587pvxzjqxl.jpg",
      headline: "SOME MORE INFORMATION",
      description:
          "In the three years of the trial run, the cloud computing server project has been operating very well. By serving the We Media content creators and advertisers, we have also obtained corresponding revenue. To serve more content creators and advertisers, we decide to expand the range of operations and aggregate social financing."),
  DescriptionModel(
      imageUrl:
          "https://res.cloudinary.com/earnindia/image/upload/v1645811488/AlphaPlan2/Documents/tuuv6fyx7h0iujkn97bp.jpg",
      headline: "OUR FINANCIAL PLAN",
      description:
          "The financing plan is referred to as \"Alpha's Plan\". We have deployed a large number of cloud computing servers around the world. Through P distributed computing, while making full use of idle resources, we also need more funds to pay the end-users who offer those idle resources. Certainly, we will pay back our investors with a considerable investment return."),
];
