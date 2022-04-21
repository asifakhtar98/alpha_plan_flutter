
const planImageCloudPrefix =
    "https://res.cloudinary.com/promisedpayment/image/upload/v1649487545/DreamLightCity/PlanImages";

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
    productName: "HongKong",
    pImageUrl:
        "$planImageCloudPrefix/POP_98_1683_00_1683_WembleyStadium_Exterior_Night2_Hufton_Crow_ov1thd.jpg",
    productPrice: 500,
    dailyIncome: 50,
    totalIncome: 1000,
    maturityTime: 20,
    longDescription:
        '"Hong Kong" is one of the cloud-computing server management full hosting plans Alpha\'s Plan provides to the holders. When you purchase this plan at the price of 500 for one piece, please check your "Order" page for confirmation. You will be holding a contract of obtaining the next 20 days of net income of this plan for one share.You receive income daily at the result of 50 per day generated and by Alpha\'s Plan\'s top-notch customized management on this certain server room, which will be distributed',
    fakeNumber: 571,
  ),
  InvestmentProduct(
      uidProduct: "APPINVPLAN2",
      productName: "Dubai",
      pImageUrl:
          "$planImageCloudPrefix/POP_98_1683_00_1683_WembleyStadium_Exterior_Night2_Hufton_Crow_ov1thd.jpg",
      productPrice: 1000,
      totalIncome: 2000,
      dailyIncome: 100,
      maturityTime: 20,
      fakeNumber: 379,
      longDescription:
          '"Dubai" is one of the cloud-computing server management full hosting plans Alpha\'s Plan provides to the holders.When you purchase this plan at the price of 1000 for one piece, please check your "Order" page for confirmation. You will be holding a contract of obtaining the next 20 days of net income of this plan for one share.You receive income daily at the result of 100 per day generated and by Alpha\'s Plan\'s top-notch customized management on this certain server room, which will be distributed'),
  InvestmentProduct(
      uidProduct: "APPINVPLAN3",
      productName: "London",
      pImageUrl:
          "$planImageCloudPrefix/POP_98_1683_00_1683_WembleyStadium_Exterior_Night2_Hufton_Crow_ov1thd.jpg",
      productPrice: 3000,
      totalIncome: 6000,
      dailyIncome: 300,
      maturityTime: 20,
      fakeNumber: 234,
      longDescription:
          '"London" is one of the cloud-computing server management full hosting plans Alpha\'s Plan provides to the holders.When you purchase this plan at the price of 3000 for one piece, please check your "Order" page for comfirmation. You will be holding a contract of obtaining the next 20 days of net income of this plan for one share.You receive income on a daily basis at the result of 300 per day generated and by Alpha\'s Plan\'s top notch customized management on this certain server room, which will be distributed'),
  InvestmentProduct(
      uidProduct: "APPINVPLAN4",
      productName: "Beijing",
      pImageUrl:
          "$planImageCloudPrefix/POP_98_1683_00_1683_WembleyStadium_Exterior_Night2_Hufton_Crow_ov1thd.jpg",
      productPrice: 5000,
      maturityTime: 20,
      dailyIncome: 500,
      totalIncome: 10000,
      fakeNumber: 126,
      longDescription:
          '"Beijing" is one of the cloud-computing server management full hosting plans Alpha\'s Plan provides to the holders. When you purchase this plan at the price of 5000 for one piece, please check your "Order" page for confirmation. You will be holding a contract of obtaining the next 20 days of net income of this plan for one share. You receive income daily at the result of 500 per day generated and by Alpha\'s Plan\'s top-notch customized management on this certain server room, which will be distributed'),
  InvestmentProduct(
      uidProduct: "APPINVPLAN5",
      productName: "Tokyo",
      pImageUrl:
          "$planImageCloudPrefix/POP_98_1683_00_1683_WembleyStadium_Exterior_Night2_Hufton_Crow_ov1thd.jpg",
      productPrice: 8000,
      maturityTime: 20,
      totalIncome: 16000,
      dailyIncome: 800,
      fakeNumber: 138,
      longDescription:
          '"Tokyo" is one of the cloud-computing server management full hosting plans Alpha\'s Plan provides to the holders. When you purchase this plan at the price of 8000 for one piece, please check your "Order" page for confirmation. You will be holding a contract of obtaining the next 20 days of net income of this plan for one share. You receive income daily at the result of 800 per day generated and by Alpha\'s Plan\'s top-notch customized management on this certain server room, which will be distributed'),
  InvestmentProduct(
      uidProduct: "APPINVPLAN6",
      productName: "Moscow",
      pImageUrl:
          "$planImageCloudPrefix/POP_98_1683_00_1683_WembleyStadium_Exterior_Night2_Hufton_Crow_ov1thd.jpg",
      productPrice: 10000,
      maturityTime: 20,
      totalIncome: 20000,
      dailyIncome: 1000,
      fakeNumber: 77,
      longDescription:
          '"Moscow" is one of the cloud-computing server management full hosting plans Alpha\'s Plan provides to the holders. When you purchase this plan at the price of 10000 for one piece, please check your "Order" page for confirmation. You will be holding a contract of obtaining the next 20 days of net income of this plan for one share. You receive income daily at the result of 1000 per day generated and by Alpha\'s Plan\'s top-notch customized management on this certain server room, which will be distributed'),
  InvestmentProduct(
      uidProduct: "APPINVPLAN7",
      productName: "NewYork",
      pImageUrl:
          "$planImageCloudPrefix/POP_98_1683_00_1683_WembleyStadium_Exterior_Night2_Hufton_Crow_ov1thd.jpg",
      productPrice: 20000,
      dailyIncome: 2000,
      totalIncome: 40000,
      maturityTime: 20,
      fakeNumber: 26,
      longDescription:
          '"New York" is one of the cloud-computing server management full hosting plans Alpha\'s Plan provides to the holders. When you purchase this plan at the price of 20000 for one piece, please check your "Order" page for confirmation. You will be holding a contract of obtaining the next 20 days of net income of this plan for one share.You receive income daily at the result of 2000 per day generated and by Alpha\'s Plan\'s top-notch customized management on this certain server room, which will be distributed'),
  InvestmentProduct(
      uidProduct: "APPINVPLAN8",
      productName: "Shenzhen",
      pImageUrl:
          "$planImageCloudPrefix/POP_98_1683_00_1683_WembleyStadium_Exterior_Night2_Hufton_Crow_ov1thd.jpg",
      productPrice: 50000,
      totalIncome: 100000,
      dailyIncome: 5000,
      maturityTime: 20,
      fakeNumber: 11,
      longDescription:
          '"Shenzhen" is one of the cloud-computing server management full hosting plans Alpha\'s Plan provides to the holders. When you purchase this plan at the price of 50000 for one piece, please check your "Order" page for confirmation. You will be holding a contract of obtaining the next 20 days of net income of this plan for one share.You receive income daily at the result of 5000 per day generated and by Alpha\'s Plan\'s top-notch customized management on this certain server room, which will be distributed'),
];
