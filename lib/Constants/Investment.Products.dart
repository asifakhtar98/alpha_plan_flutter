class InvestmentProduct {
  final String uidProduct;
  final String productName;
  final String pImageUrl;
  final String longDescription;
  final int productPrice;
  final int dailyIncome;
  final int totalIncome;
  final int maturityTime;
  final int fakeNumber;

  InvestmentProduct({
    required this.longDescription,
    required this.uidProduct,
    required this.productName,
    required this.pImageUrl,
    required this.productPrice,
    required this.dailyIncome,
    required this.totalIncome,
    required this.maturityTime,
    required this.fakeNumber,
  });
}

List<InvestmentProduct> mainInvestmentProductsList = [
  InvestmentProduct(
    uidProduct: "APPINVPLAN1",
    productName: "Stadium1",
    pImageUrl:
    "https://res.cloudinary.com/promisedpayment/image/upload/v1650531051/DreamLightCity/PlanImages/photo-1549923015-badf41b04831_bzzobd.jpg",
    productPrice: 300,
    dailyIncome: 50,
    totalIncome: 1000,
    maturityTime: 20,
    longDescription:
    'Stadium1Stadium1Stadium1Stadium1Stadium1Stadium1Stadium1Stadium1Stadium1Stadium1Stadium1Stadium1Stadium1Stadium1Stadium1Stadium1Stadium1Stadium1Stadium1Stadium1Stadium1Stadium1Stadium1Stadium1Stadium1Stadium1',
    fakeNumber: 571,
  ),
  InvestmentProduct(
      uidProduct: "APPINVPLAN2",
      productName: "Stadium2",
      pImageUrl:
      "https://res.cloudinary.com/promisedpayment/image/upload/v1650530695/DreamLightCity/PlanImages/photo-1489944440615-453fc2b6a9a9_semdle.jpg",
      productPrice: 500,
      totalIncome: 2000,
      dailyIncome: 100,
      maturityTime: 20,
      fakeNumber: 379,
      longDescription:
      'Stadium2Stadium2Stadium2Stadium2Stadium2Stadium2Stadium2Stadium2Stadium2Stadium2Stadium2Stadium2Stadium2Stadium2Stadium2Stadium2Stadium2Stadium2Stadium2Stadium2Stadium2Stadium2Stadium2Stadium2Stadium2Stadium2'),
  InvestmentProduct(
      uidProduct: "APPINVPLAN3",
      productName: "Stadium3",
      pImageUrl:
      "https://res.cloudinary.com/promisedpayment/image/upload/v1650530617/DreamLightCity/PlanImages/photo-1512631737701-737916001362_q5bcct.jpg",
      productPrice: 1000,
      totalIncome: 6000,
      dailyIncome: 300,
      maturityTime: 20,
      fakeNumber: 234,
      longDescription:
      'Stadium3Stadium3Stadium3Stadium3Stadium3Stadium3Stadium3Stadium3Stadium3Stadium3Stadium3Stadium3Stadium3Stadium3Stadium3Stadium3Stadium3Stadium3Stadium3Stadium3Stadium3Stadium3Stadium3Stadium3Stadium3'),
  InvestmentProduct(
      uidProduct: "APPINVPLAN4",
      productName: "Stadium4",
      pImageUrl:
      "https://res.cloudinary.com/promisedpayment/image/upload/v1650567423/DreamLightCity/PlanImages/Moteras-Sardar-Patel-Stadium_jqvyof.jpg",
      productPrice: 1500,
      maturityTime: 20,
      dailyIncome: 500,
      totalIncome: 10000,
      fakeNumber: 126,
      longDescription:
      'Stadium4Stadium4Stadium4Stadium4Stadium4Stadium4Stadium4Stadium4Stadium4Stadium4Stadium4Stadium4Stadium4Stadium4Stadium4Stadium4Stadium4Stadium4Stadium4Stadium4Stadium4Stadium4Stadium4Stadium4Stadium4'),
  InvestmentProduct(
      uidProduct: "APPINVPLAN5",
      productName: "Stadium5",
      pImageUrl:
      "https://res.cloudinary.com/promisedpayment/image/upload/v1650567524/DreamLightCity/PlanImages/5d89f45c7e8a220e5a299894_1569322076480_tzhhkd.jpg",
      productPrice: 2000,
      maturityTime: 20,
      totalIncome: 16000,
      dailyIncome: 800,
      fakeNumber: 138,
      longDescription:
      'Stadium5Stadium5Stadium5Stadium5Stadium5Stadium5Stadium5Stadium5Stadium5Stadium5Stadium5Stadium5Stadium5Stadium5Stadium5Stadium5Stadium5Stadium5Stadium5Stadium5Stadium5Stadium5Stadium5'),
  InvestmentProduct(
      uidProduct: "APPINVPLAN6",
      productName: "Stadium6",
      pImageUrl:
      "https://res.cloudinary.com/promisedpayment/image/upload/v1650530948/DreamLightCity/PlanImages/photo-1511204579483-e5c2b1d69acd_mvllqh.jpg",
      productPrice: 3000,
      maturityTime: 20,
      totalIncome: 20000,
      dailyIncome: 1000,
      fakeNumber: 77,
      longDescription:
      'Stadium6Stadium6Stadium6Stadium6Stadium6Stadium6Stadium6Stadium6Stadium6Stadium6Stadium6Stadium6Stadium6Stadium6Stadium6Stadium6Stadium6Stadium6Stadium6Stadium6Stadium6Stadium6Stadium6Stadium6Stadium6Stadium6Stadium6'),
  InvestmentProduct(
      uidProduct: "APPINVPLAN7",
      productName: "Stadium7",
      pImageUrl:
      "https://res.cloudinary.com/promisedpayment/image/upload/v1650530591/DreamLightCity/PlanImages/photo-1629298011324-1908916d01a7_r3m1d2.jpg",
      productPrice: 5000,
      dailyIncome: 2000,
      totalIncome: 40000,
      maturityTime: 20,
      fakeNumber: 26,
      longDescription:
      'Stadium7Stadium7Stadium7Stadium7Stadium7Stadium7Stadium7Stadium7Stadium7Stadium7Stadium7Stadium7Stadium7Stadium7Stadium7Stadium7Stadium7Stadium7Stadium7Stadium7Stadium7Stadium7Stadium7Stadium7'),
  InvestmentProduct(
      uidProduct: "APPINVPLAN8",
      productName: "Stadium8",
      pImageUrl:
      "https://res.cloudinary.com/promisedpayment/image/upload/v1650567824/DreamLightCity/PlanImages/1024px-Marriott_Center_1-1000x600_mjrw6m.jpg",
      productPrice: 6000,
      totalIncome: 100000,
      dailyIncome: 5000,
      maturityTime: 20,
      fakeNumber: 11,
      longDescription:
      'Stadium8Stadium8Stadium8Stadium8Stadium8Stadium8Stadium8Stadium8Stadium8Stadium8Stadium8Stadium8Stadium8Stadium8Stadium8Stadium8Stadium8Stadium8Stadium8Stadium8Stadium8Stadium8Stadium8Stadium8Stadium8Stadium8'),
  InvestmentProduct(
      uidProduct: "APPINVPLAN9",
      productName: "Stadium9",
      pImageUrl:
      "https://res.cloudinary.com/promisedpayment/image/upload/v1650567875/DreamLightCity/PlanImages/106698727-1599822851881-SoFi_Stadium_est_2020_ynf0a1.jpg",
      productPrice: 7000,
      totalIncome: 100000,
      dailyIncome: 5000,
      maturityTime: 20,
      fakeNumber: 11,
      longDescription:
      'Stadium9Stadium9Stadium9Stadium9Stadium9Stadium9Stadium9Stadium9Stadium9Stadium9Stadium9Stadium9Stadium9Stadium9Stadium9Stadium9Stadium9Stadium9Stadium9Stadium9Stadium9Stadium9Stadium9Stadium9Stadium9Stadium9'),
  InvestmentProduct(
      uidProduct: "APPINVPLAN10",
      productName: "Stadium10",
      pImageUrl:
      "https://res.cloudinary.com/promisedpayment/image/upload/v1650573038/DreamLightCity/PlanImages/foreign_english_2020-08-10_dn122769_image1_h4cace.jpg",
      productPrice: 8000,
      totalIncome: 100000,
      dailyIncome: 5000,
      maturityTime: 20,
      fakeNumber: 11,
      longDescription:
      'Stadium10Stadium10Stadium10Stadium10Stadium10Stadium10Stadium10Stadium10Stadium10Stadium10Stadium10Stadium10Stadium10Stadium10Stadium10Stadium10Stadium10Stadium10Stadium10Stadium10Stadium10Stadium10Stadium10Stadium10'),
  InvestmentProduct(
      uidProduct: "APPINVPLAN11",
      productName: "Stadium11",
      pImageUrl:
      "https://res.cloudinary.com/promisedpayment/image/upload/v1650532147/DreamLightCity/PlanImages/J1A6493_2_LIGHTS-1504x846_m2vhj2.jpg",
      productPrice: 10000,
      totalIncome: 100000,
      dailyIncome: 5000,
      maturityTime: 20,
      fakeNumber: 11,
      longDescription:
      'Stadium11Stadium11Stadium11Stadium11Stadium11Stadium11Stadium11Stadium11Stadium11Stadium11Stadium11Stadium11Stadium11Stadium11Stadium11Stadium11Stadium11Stadium11Stadium11Stadium11Stadium11Stadium11Stadium11'),
  InvestmentProduct(
      uidProduct: "APPINVPLAN12",
      productName: "Stadium12",
      pImageUrl:
      "https://res.cloudinary.com/promisedpayment/image/upload/v1650531431/DreamLightCity/PlanImages/royal_arena_copenhagen_xn62pt.jpg",
      productPrice: 15000,
      totalIncome: 100000,
      dailyIncome: 5000,
      maturityTime: 20,
      fakeNumber: 11,
      longDescription:
      'Stadium12Stadium12Stadium12Stadium12Stadium12Stadium12Stadium12Stadium12Stadium12Stadium12Stadium12Stadium12Stadium12Stadium12Stadium12Stadium12Stadium12Stadium12Stadium12Stadium12Stadium12Stadium12Stadium12'),
  InvestmentProduct(
      uidProduct: "APPINVPLAN13",
      productName: "Stadium13",
      pImageUrl:
      "https://res.cloudinary.com/promisedpayment/image/upload/v1650532117/DreamLightCity/PlanImages/Alienware-Arena-2-1504x846_wdy115.jpg",
      productPrice: 30000,
      totalIncome: 100000,
      dailyIncome: 5000,
      maturityTime: 20,
      fakeNumber: 11,
      longDescription:
      'Stadium13Stadium13Stadium13Stadium13Stadium13Stadium13Stadium13Stadium13Stadium13Stadium13Stadium13Stadium13Stadium13Stadium13Stadium13Stadium13Stadium13Stadium13Stadium13Stadium13Stadium13Stadium13'),
  InvestmentProduct(
      uidProduct: "APPINVPLAN14",
      productName: "Stadium14",
      pImageUrl:
      "https://res.cloudinary.com/promisedpayment/image/upload/v1650531405/DreamLightCity/PlanImages/cska_arena_gpyyca.jpg",
      productPrice: 40000,
      totalIncome: 100000,
      dailyIncome: 5000,
      maturityTime: 20,
      fakeNumber: 11,
      longDescription:
      'Stadium14Stadium14Stadium14Stadium14Stadium14Stadium14Stadium14Stadium14Stadium14Stadium14Stadium14Stadium14Stadium14Stadium14Stadium14Stadium14Stadium14Stadium14Stadium14Stadium14Stadium14Stadium14'),
  InvestmentProduct(
      uidProduct: "APPINVPLAN15",
      productName: "Stadium15",
      pImageUrl:
      "https://res.cloudinary.com/promisedpayment/image/upload/v1650531086/DreamLightCity/PlanImages/photo-1568663469495-b09d5e3c2e07_aepsye.jpg",
      productPrice: 50000,
      totalIncome: 100000,
      dailyIncome: 5000,
      maturityTime: 20,
      fakeNumber: 11,
      longDescription:
      'Stadium15Stadium15Stadium15Stadium15Stadium15Stadium15Stadium15Stadium15Stadium15Stadium15Stadium15Stadium15Stadium15Stadium15Stadium15Stadium15Stadium15Stadium15Stadium15Stadium15Stadium15Stadium15'),
  InvestmentProduct(
      uidProduct: "APPINVPLAN16",
      productName: "Stadium16",
      pImageUrl:
      "https://res.cloudinary.com/promisedpayment/image/upload/v1650531196/DreamLightCity/PlanImages/photo-1585805152588-5beb7808255d_vy0gf4.jpg",
      productPrice: 80000,
      totalIncome: 100000,
      dailyIncome: 5000,
      maturityTime: 20,
      fakeNumber: 11,
      longDescription:
      'Stadium16Stadium16Stadium16Stadium16Stadium16Stadium16Stadium16Stadium16Stadium16Stadium16Stadium16Stadium16Stadium16Stadium16Stadium16Stadium16Stadium16Stadium16Stadium16Stadium16Stadium16Stadium16'),
];
