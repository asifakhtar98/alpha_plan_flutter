const int passwordDialogTimer = 30;
const String referCodePrefix = "dreamcity";
const int referCodeLength = 20;
const int minPasswordSize = 6;
const String pCC = "+91";

const String cloudinaryTag =
    "https://res.cloudinary.com/earnindia/image/upload/v1644340110/AlphaPlan2";
const String appealFormLink = "https://airtable.com/shrJZYFFw1okelsBE";
const String contactFormLink = "https://airtable.com/shr91bZ61OohavhQ7";

const String demoMobileNo = "0987654321";
const String demoPassword = "654321";

const kIfttApiKey1 = "bfSAEnWasrTOOwlUxqHWEY";

const String oneSignalAppId = "1ab853e9-d7ee-461a-ba71-64986656a70e";
const String appPrivacyPolicyLink =
    "https://dreamlightcity.tech/privacy_policy.html";
// const String razorPayStagingApiKey = "rzp_test_XqovTPpGzbsJFE";
const String appWebsiteLink = "https://dreamlightcity.tech";
const String referLinkPrefix = "https://dreamlightcity.tech?refcode=";
const String referMsgPrefix =
    "Invest in $appName Plans get 1.5X return in very short period of 20 days. Install the app and enter the following referral code to get your signup bonus between Rs. 50 to Rs 200 ";
const String appName = "Dream Light City";
const String appNameShort = "DLC";
const String companyName = "EcoPower";
//TODO: release hive box id: HB2745643636
const String hiveBoxName = "HB635252633";

class FireString {
  static const String globalPermit = "GlobalPermit";
  static const String appRegEnabled = "AppRegEnabled";
  static const String blockFullAccess = "BlockFullAccess";
  static const String accessDisableNotice = "AccessDisableNotice";
  static const String appVersionCode = "AppVersionCode";
  static const String isForceAppUpdate = "IsForceAppUpdate";
  static const String appLink = "AppLink";
  static const String isReferCodeCompulsory = "IsReferCodeCompulsory";
  ////////////////////////////////
  static const String accounts = "Accounts";
  static const String globalSystem = "System";
  static const String document1 = "Document1";
  static const String document2 = "Document2";
/////////////////////////
  static const String mobileNo = "MobileNo";
  static const String password = "Password";
  static const String countryCode = "CountryCode";
  static const String canLogin = "CanLogin";
  //////////////////////////////////////
  static const String walletBalance = "WalletBalance";
  static const String depositCoin = "DepositCoin";
  static const String lifetimeDeposit = "LifetimeDeposit";
  static const String withdrawableCoin = "WithdrawableCoin";
  static const String investReturn = "InvestReturn";
  static const String referralIncome = "ReferralIncome";
  static const String totalWithdrawal = "TotalWithdrawal";
  static const String upcomingIncome = "UpcomingIncome";
  /////////////////////////////
  static const String personalInfo = "PersonalInfo";
  static const String primaryEmail = "PrimaryEmail";
  static const String fullName = "FullName";
  static const String address = "Address";
  static const String alternateNumber = "AlternateNumber";
  static const String zipCode = "ZipCode";
  static const String nomineeName = "NomineeName";
  static const String nomineeNumber = "NomineeNumber";
  //////////////////////
  static const String bankInfo = "BankInfo";
  static const String payeeName = "PayeeName";
  static const String bankName = "BankName";
  static const String bankAcNumber = "AccountNumber";
  static const String bankIfsc = "Ifsc";
  static const String payeeEmail = "PayeeEmail";
  static const String payeeUpiLink = "UpiLink";
  //////////////
  static const String canWithdraw = "CanWithdraw";
  static const String noOfInvestment = "NoOfInvestment";
  static const String noOfWithdraw = "NoOfWithdraw";
  static const String lastWithdrawStatus = "LastWithdrawStatus";
  ///////////
  static const String walletPermissions = "WalletPermissions";
  static const String withdrawEnabled = "WithdrawEnabled";
  static const String withdrawPeriod = "WithdrawPeriod";
  static const String withdrawProcessingTime = "WithdrawProcessingTime";
  static const String withdrawServiceTax = "WithdrawServiceTax";
  static const String minimumWithdrawAmount = "MinimumWithdrawAmount";
  static const String maximumWithdrawAmount = "MaximumWithdrawAmount";
  static const String minReferIncomeToConvert = "MinReferIncomeToConvert";
  static const String allowWithdrawOnPrevProcessing =
      "AllowWithdrawOnPrevProcessing";
  static const String noOfFreeWithdrawalWithoutInvestment =
      "NoOfFreeWithdrawalWithoutInvestment";
  static const String unlimitedWithdrawAfterInvestmentOf =
      "UnlimitedWithdrawAfterInvestmentOf";
  ////////////////////////
  static const String myWithdrawals = "MyWithdrawals";
  static const String allWithdrawals = "AllWithdrawals";
  static const String withdrawalAmount = "WithdrawalAmount";
  static const String withdrawDateTime = "WithdrawDateTime";
  static const String withdrawStatus = "WithdrawStatus";
  static const String withdrawBankInfo = "WithdrawBankInfo";
  static const String userDeviceName = "UserDeviceName";
  static const String processing = "Processing";
  static const String success = "Success";
  static const String failedRefunded = "Failed&Refunded";
  //////////////////////
  static const String allDeposits = "AllDeposits";
  static const String myDeposits = "MyDeposits";
  static const String depositInfo = "DepositInfo";
  static const String depositAmount = "DepositAmount";
  static const String depositDateTime = "DepositDateTime";
  static const String lastRechargeRefNo = "LastRechargeRefNo";
  static const String depositCoinBefore = "DepositCoinBefore";
  //////////////////////////////
  static const String appRechargePermissions = "AppRechargePermissions";
  static const String maxCustomAmount = "MaxCustomAmount";
  static const String cashfreeEnabled = "CashfreeEnabled";
  static const String directUpiEnabled = "DirectUpiEnabled";
  static const String manualMethodEnabled = "ManualMethodEnabled";
  static const String razorpayEnabled = "RazorpayEnabled";
  static const String adminUpi = "AdminUpi";
  static const String cashfreeKeys = "CashfreeKeys";
  static const String appId = "AppId";
  static const String secretKey = "SecretKey";
  static const String razorPayKeys = "RazorPayKeys";
  /////////////////////////////InvestmentPlans
  static const String investmentPlans = "InvestmentPlans";
  static const String checkoutPrice = "CheckoutPrice";
  static const String docID = "DocID";
  /////////////////////
  static const String myInvestments = "MyInvestments";
  static const String isCompleted = "IsCompleted";
  static const String returnedAmount = "ReturnedAmount";
  static const String planUid = "PlanUid";
  static const String servedDays = "ServedDays";
  static const String planCapturedAt = "PlanCapturedAt";
  static const String planCapturedDate = "PlanCapturedDate";

  ///////////////////
  static const String allAppInvestments = "AllAppInvestments";
///////////////////////
  static const String fast2SmsData = "Fast2SmsData";
  static const String authKey = "AuthKey";
  static const String senderId = "SenderId";
  //////////////////////////////
  static const String notifications = "Notifications";
  static const String launchUrl = "LaunchUrl";
  static const String noticeText = "NoticeText";
  static const String visibility = "Visibility";
  ///////////////////////////////////////ServerStats
  static const String stats = "Stats";
  static const String totalGlobalInvestments = "TotalGlobalInvestments";
  static const String totalGlobalRecharge = "TotalGlobalRecharge";
  static const String totalGlobalTriedWithdrawal = "TotalGlobalTriedWithdrawal";
  static const String totalGlobalUsers = "TotalGlobalUsers";
  ///////////////////////////////
  static const String refMobMapping = "RefMobMapping";
  static const String myReferData = "MyReferData";
  static const String userReferCodes = "UserReferCodes";
  static const String registeredOn = "RegisteredOn";
  static const String userReferredBy = "UserReferredBy";
  static const String canGetCommission = "CanGetCommission";
  static const String commissionLevel = "CommissionLevel";
  static const String levelTotalRecharge = "LevelTotalRecharge";
  static const String levelTotalCommission = "LevelTotalCommission";
  static const String recordHistory = "RecordHistory";
  static const String commissionAmount = "CommissionAmount";
  static const String lastCommissionOn = "LastCommissionOn";
  //////////////////////////////////////
  static const String globalReferData = "GlobalReferData";
  static const String level1CommissionPercent = "Level1CommissionPercent";
  static const String level2CommissionPercent = "Level2CommissionPercent";
  static const String level3CommissionPercent = "Level3CommissionPercent";
  ////////////////////////////////////
  static const String customerSupport = "CustomerSupport";
  static const String admin1No = "Admin1No";
  static const String admin2No = "Admin2No";
  static const String telegramChannelLink = "TelegramChannelLink";
  static const String developerSite = "DeveloperSite";
  /////////////////////////
  static const String myActivities = "MyActivities";
  //////////////////////
  static const String atSpecialEvents = "AtSpecialEvents";
  static const String signUpBonus = "SignUpBonus";
  ///////////////////////
  static const String usersDirectRefers = "UsersDirectRefers";
}
