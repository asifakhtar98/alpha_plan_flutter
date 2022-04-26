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
    productName: "Australia ANZ\nStadium",
    pImageUrl:
        "https://res.cloudinary.com/promisedpayment/image/upload/v1650531051/DreamLightCity/PlanImages/photo-1549923015-badf41b04831_bzzobd.jpg",
    productPrice: 300,
    dailyIncome: 30,
    totalIncome: 600,
    maturityTime: 20,
    longDescription:
        '''The newly rebranded Accor Stadium, previously known as Stadium Australia and ANZ Stadium, is a 83,500-capacity stadium located in Sydney, Australia. Built to be the centrepiece of the Sydney 2000 Olympic Games, it now serves primarily as a rectangular sports and entertainment venue.Stadium Australia was set to receive a major \$810 redevelopment to convert the Olympic stadium into a world-class 70,000-capacity rectangular stadium, commencing in mid-2020 - however it was announced on May 31 that the NSW Government has pulled the pin on the project.''',
    fakeNumber: 1300,
  ),
  InvestmentProduct(
      uidProduct: "APPINVPLAN2",
      productName: "London Wembley\nStadium",
      pImageUrl:
          "https://res.cloudinary.com/promisedpayment/image/upload/v1650530695/DreamLightCity/PlanImages/photo-1489944440615-453fc2b6a9a9_semdle.jpg",
      productPrice: 500,
      totalIncome: 1000,
      dailyIncome: 50,
      maturityTime: 20,
      fakeNumber: 770,
      longDescription: '''
         Wembley Stadium, stadium in the borough of Brent in northwestern London, England, built as a replacement for an older structure of the same name on the same site. The new Wembley was the largest stadium in Great Britain at the time of its opening in 2007, with a seating capacity of 90,000.Wembley Stadium has hosted the Football Association Cup Final every year since the year of its completion. It is also the home of England’s national football team. During the London 2012 Olympic Games, the stadium was a venue for football, including the final (gold medal) match.
         '''),
  InvestmentProduct(
      uidProduct: "APPINVPLAN3",
      productName: "FNB Johannesburg\nStadium",
      pImageUrl:
          "https://res.cloudinary.com/promisedpayment/image/upload/v1650530617/DreamLightCity/PlanImages/photo-1512631737701-737916001362_q5bcct.jpg",
      productPrice: 1000,
      totalIncome: 2000,
      dailyIncome: 100,
      maturityTime: 20,
      fakeNumber: 450,
      longDescription:
          '''First National Bank Stadium or simply FNB Stadium, also known as Soccer City and The Calabash, is an association football (soccer) and Rugby union stadium located in Nasrec, bordering the Soweto area of Johannesburg, South Africa.It was the site of Nelson Mandela's first speech in Johannesburg after his release from prison in 1990, and served as the venue for a memorial service to him on 10 December 2013.It was also the site of Chris Hani's funeral.The World Cup closing ceremony on the day of the final saw the final public appearance of Mandela.
          '''),
  InvestmentProduct(
      uidProduct: "APPINVPLAN4",
      productName: "Narendra Modi\nStadium",
      pImageUrl:
          "https://res.cloudinary.com/promisedpayment/image/upload/v1650567423/DreamLightCity/PlanImages/Moteras-Sardar-Patel-Stadium_jqvyof.jpg",
      productPrice: 1500,
      maturityTime: 20,
      dailyIncome: 150,
      totalIncome: 3000,
      fakeNumber: 300,
      longDescription:
          '''The Narendra Modi Stadium is a cricket stadium situated inside the Sardar Vallabhbhai Patel Sports Enclave in Ahmedabad, India. As of 2022, it is the largest stadium in the world, with a seating capacity of 132,000 spectators.It is owned by the Gujarat Cricket Association and is a venue for Test, ODI, and T20I cricket matches.After starting demolition work at the end of 2015, the Gujarat Cricket Association issued a request for tender on 1 January 2016 in The Times of India and The Indian Express. Nine bidders showed interest and purchased the tender documents, out of which three submitted Technical and Financial bids on time; they were the Shapoorji Pallonji Group, Nagarjuna Construction Company, and Larsen & Toubro.'''),
  ///////////////////////////////////////////////////
  InvestmentProduct(
      uidProduct: "APPINVPLAN5",
      productName: "Salt Lake City\nStadium",
      pImageUrl:
          "https://res.cloudinary.com/promisedpayment/image/upload/v1650567524/DreamLightCity/PlanImages/5d89f45c7e8a220e5a299894_1569322076480_tzhhkd.jpg",
      productPrice: 2000,
      maturityTime: 15,
      totalIncome: 4000,
      dailyIncome: 267,
      fakeNumber: 280,
      longDescription:
          '''The Vivekananda Yuba Bharati Krirangan Stadium is situated in Salt Lake City, Kolkata and is named after Swami Vivekananda who was probably the most influential Indian philosopher of the last 200 years.His birthdate is also celebrated as Youth Day in India. Roughly translated from Bengali, the Vivekananda Yuba Bharati Krirangan name means the Vivekananda Indian Youth Stadium.The stadium covers an area of 76.40 acres (309,200 m2). It was inaugurated in January 1984, with the Jawaharlal Nehru International Gold Cup Soccer Tournament.'''),
  InvestmentProduct(
      uidProduct: "APPINVPLAN6",
      productName: "Beaver US\nStadium",
      pImageUrl:
          "https://res.cloudinary.com/promisedpayment/image/upload/v1650530948/DreamLightCity/PlanImages/photo-1511204579483-e5c2b1d69acd_mvllqh.jpg",
      productPrice: 3000,
      maturityTime: 15,
      totalIncome: 6000,
      dailyIncome: 400,
      fakeNumber: 230,
      longDescription: '''
          Beaver Stadium is an outdoor college football stadium in the eastern United States, located on the campus of Pennsylvania State University in University Park, Pennsylvania. It has been home to the Penn State Nittany Lions of the Big Ten Conference since 1960, though some parts of the stadium date back to 1909.Beaver Stadium is widely known as one of the toughest venues for opposing teams in collegiate athletics. In 2008, it was recognized as having the best student section in the country for the second consecutive year. In 2019, it was named student section of the year by a committee of ESPN broadcasters and writers.
          '''),
  InvestmentProduct(
      uidProduct: "APPINVPLAN7",
      productName: "Bank of America\nStadium",
      pImageUrl:
          "https://res.cloudinary.com/promisedpayment/image/upload/v1650530591/DreamLightCity/PlanImages/photo-1629298011324-1908916d01a7_r3m1d2.jpg",
      productPrice: 5000,
      dailyIncome: 667,
      totalIncome: 10000,
      maturityTime: 15,
      fakeNumber: 177,
      longDescription: '''
    Bank of America Stadium is a 74,867-seat football stadium located on 33 acres (13 ha) in uptown Charlotte, North Carolina, United States. It is the home facility and headquarters of the Carolina Panthers of the National Football League and Charlotte FC of Major League Soccer.In addition to hosting every Panthers home game since 1996, Bank of America Stadium has hosted seven playoff games.A popular option was to locate the facility near Carowinds amusement park, with the 50 yard line being on the state border of North Carolina and South Carolina.Carolina has also had over 150 consecutive sellouts at the stadium starting with the 2002 season.
    '''),
  InvestmentProduct(
      uidProduct: "APPINVPLAN8",
      productName: "Marriott Center\nArena",
      pImageUrl:
          "https://res.cloudinary.com/promisedpayment/image/upload/v1650567824/DreamLightCity/PlanImages/1024px-Marriott_Center_1-1000x600_mjrw6m.jpg",
      productPrice: 6000,
      totalIncome: 12000,
      dailyIncome: 800,
      maturityTime: 15,
      fakeNumber: 156,
      longDescription: '''
          The Marriott Center is a multi-purpose arena in the western United States, located on the campus of Brigham Young University in Provo, Utah. It is home to the BYU Cougars men's and women's basketball teams. The seating capacity for basketball games at the Marriott Center is officially 18,987.The largest basketball arena in the West Coast Conference (in which BYU competes for most sports, except football), it is among the largest on-campus basketball arenas in the nation. In addition to basketball, the Marriott Center is used for weekly devotionals and forums. The elevation of the court is approximately 4,650 feet (1,420 m) above sea level.'''),
  ////////////////////////////////////////////////////////
  InvestmentProduct(
      uidProduct: "APPINVPLAN9",
      productName: "Texas Football\nStadium",
      pImageUrl:
          "https://res.cloudinary.com/promisedpayment/image/upload/v1650567875/DreamLightCity/PlanImages/106698727-1599822851881-SoFi_Stadium_est_2020_ynf0a1.jpg",
      productPrice: 7000,
      totalIncome: 10000,
      dailyIncome: 1000,
      maturityTime: 10,
      fakeNumber: 130,
      longDescription:
          '''Texas Stadium was an American football stadium located in Irving, Texas, a suburb west of Dallas. Opened on October 24, 1971, it was known for its distinctive hole in the roof, the result of abandoned plans to construct a retractable roof.Texas Stadium has hosted five NFC Championship Games. The 1973 Pro Bowl was held at Texas Stadium in front of 47,879 spectators.
The stadium hosted neutral-site college football games and was the home field of the SMU Mustangs for eight seasons, from 1979 through 1986. After the school returned from an NCAA-imposed suspension in 1988, school officials moved games back to the school's on-campus Ownby Stadium to signify a clean start for the football program (since replaced by Gerald J. Ford Stadium in 2000). The 2001 Big 12 Championship Game was held at the site.'''),
  InvestmentProduct(
      uidProduct: "APPINVPLAN10",
      productName: "Rungrado May Day\nStadium",
      pImageUrl:
          "https://res.cloudinary.com/promisedpayment/image/upload/v1650573038/DreamLightCity/PlanImages/foreign_english_2020-08-10_dn122769_image1_h4cace.jpg",
      productPrice: 8000,
      totalIncome: 12000,
      dailyIncome: 1200,
      maturityTime: 10,
      fakeNumber: 98,
      longDescription:
          '''The Rŭngrado May First Stadium, or May Day Stadium, is a multi-purpose stadium in Pyongyang, North Korea, completed on May 1, 1989.
The stadium was built as a main stadium for the 13th World Festival of Youth and Students in 1989. It is currently used for football matches, a few athletics matches, but most often for Arirang performances (also known as the Mass Games). The stadium can seat 150,000,[1] which is the largest stadium in the world that is not used for auto racing.'''),
  InvestmentProduct(
      uidProduct: "APPINVPLAN11",
      productName: "Arlington ESport\nArena",
      pImageUrl:
          "https://res.cloudinary.com/promisedpayment/image/upload/v1650532147/DreamLightCity/PlanImages/J1A6493_2_LIGHTS-1504x846_m2vhj2.jpg",
      productPrice: 10000,
      totalIncome: 15000,
      dailyIncome: 1500,
      maturityTime: 10,
      fakeNumber: 77,
      longDescription:
          '''Arlington ESport Stadium really stands out from the crowd as the only facility designed specifically for eSports on this list. It opened its doors in 2018 and welcomed its first international-level competition right off the bat. It was the final stage of the Esports Championship Series by FACEIT for CS:GO, where Astralis grabbed the biggest part of a \$750K prize pool. The following year, Astralis returned to the spot to win again in the \$500K worth contest. Along with premier competitions, the venue serves smaller events, including Madden NFL, Fortnite, Valorant, and some other tournaments.'''),
  InvestmentProduct(
      uidProduct: "APPINVPLAN12",
      productName: "Copenhagen Royal\nArena",
      pImageUrl:
          "https://res.cloudinary.com/promisedpayment/image/upload/v1650531431/DreamLightCity/PlanImages/royal_arena_copenhagen_xn62pt.jpg",
      productPrice: 15000,
      totalIncome: 22000,
      dailyIncome: 2200,
      maturityTime: 10,
      fakeNumber: 56,
      longDescription:
          '''Royal Arena is Copenhagen's new 16,000 capacity venue for music and sporting events in Ørestad. Hosting 60-80 events per year, the 37,000 m² arena aims to strengthen Copenhagen's international profile and attract tourists, international sporting and cultural events, and foreign investment. The building is designed with great flexibility - the interior spaces can be adjusted for different kinds of events to create amazing experiences for its visitors.'''),
  InvestmentProduct(
      uidProduct: "APPINVPLAN13",
      productName: "Fortress Melbourne\nArena",
      pImageUrl:
          "https://res.cloudinary.com/promisedpayment/image/upload/v1650532117/DreamLightCity/PlanImages/Alienware-Arena-2-1504x846_wdy115.jpg",
      productPrice: 30000,
      totalIncome: 40000,
      dailyIncome: 5000,
      maturityTime: 8,
      fakeNumber: 42,
      longDescription:
          '''Fortress Melbourne will have a purpose-built esports arena, 160 top of the range esports-ready gaming PCs, a dedicated LAN lounge and a high performance esports bootcamp room. 10+ screens across both floors broadcasting live tournaments and international playoffs year round. Everything primed for the ultimate esports experience! Fortress we love games and we want to share that love with Australia. Beginning in 2020 we're opening up venues around the country in the ultimate celebration of gaming culture. From hardcore esports fanatics to casual gamers, from PC players to console to table top - we're building welcoming homes away from home for all gamers.'''),
  InvestmentProduct(
      uidProduct: "APPINVPLAN14",
      productName: "Moscow CSKA\nArena",
      pImageUrl:
          "https://res.cloudinary.com/promisedpayment/image/upload/v1650531405/DreamLightCity/PlanImages/cska_arena_gpyyca.jpg",
      productPrice: 40000,
      totalIncome: 55000,
      dailyIncome: 6875,
      maturityTime: 8,
      fakeNumber: 35,
      longDescription:
          '''CSKA Arena is a part of the Park of Legends big renovation project, on the site of the former ZiL auto plant. It includes the Arena, the Russian Hockey Museum with the Russian Hockey Hall of Glory, Watersport Arena, and Apartments Complex. It is located nearby the ZIL MCC and Avtozavodskaya Metro station.The large arena has a seating capacity of 12,100 viewers for ice hockey and figure skating, 13,000 for basketball and 14,000 for wrestling, boxing, MMA, and concerts. The large arena also has 80 VIP luxury box suites.'''),
  InvestmentProduct(
      uidProduct: "APPINVPLAN15",
      productName: "NY Arthur Ashe\nStadium",
      pImageUrl:
          "https://res.cloudinary.com/promisedpayment/image/upload/v1650531086/DreamLightCity/PlanImages/photo-1568663469495-b09d5e3c2e07_aepsye.jpg",
      productPrice: 50000,
      totalIncome: 70000,
      dailyIncome: 8750,
      maturityTime: 8,
      fakeNumber: 22,
      longDescription:
          '''Arthur Ashe Stadium is a tennis stadium at Flushing Meadows–Corona Park in Queens, New York City. Part of the USTA Billie Jean King National Tennis Center, it is the main stadium of the US Open tennis tournament and has a capacity of 23,771 making it the largest tennis stadium in the world. The stadium is named after Arthur Ashe, winner of the inaugural 1968 US Open, the first in which professionals could compete.[4] The original stadium design, completed in 1997, had not included a roof. After suffering successive years of event delays from inclement weather, a new lightweight retractable roof was completed in 2016.'''),
  InvestmentProduct(
      uidProduct: "APPINVPLAN16",
      productName: "Russia ZSKA\nArena",
      pImageUrl:
          "https://res.cloudinary.com/promisedpayment/image/upload/v1650531196/DreamLightCity/PlanImages/photo-1585805152588-5beb7808255d_vy0gf4.jpg",
      productPrice: 80000,
      totalIncome: 110000,
      dailyIncome: 13750,
      maturityTime: 8,
      fakeNumber: 15,
      longDescription:
          '''The building complex with a total of three ice rinks is part of the Park of Legends , a comprehensive new building project on the site of the former automobile factory ZiL . Further buildings are being planned, which will house a water sports arena, an ice hockey museum including the Russian Ice Hockey Hall of Fame, a hotel and apartments.The name sponsor of the arena was the bank VTB until 2018 . Since August 2018, the building has been called the CSKA Arena .'''),
];
