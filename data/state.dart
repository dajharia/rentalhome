import 'package:cloud_firestore/cloud_firestore.dart';

/// Define StateData class
class StateData {
  final String id; // राज्य का यूनिक आईडी
  final String name; // राज्य का नाम
  final List<String> districts; // ज़िलों की सूची

  StateData({required this.id, required this.name, required this.districts});

  /// Convert StateData object to Map (for Firestore or JSON)
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'districts': districts,
    };
  }

  /// Create a StateData object from a Firestore document
  factory StateData.fromDocument(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return StateData(
      id: data['id'] ?? '',
      name: data['name'] ?? '',
      districts: List<String>.from(data['districts'] ?? []),
    );
  }
}
// list Start

List<StateData> getAllStates() {
  return [
    StateData(id: 'AP', name: 'Andhra Pradesh', districts: [
      "Anantapur",      "Chittoor",      "East Godavari",      "Guntur",      "Krishna",
      "Kurnool",      "Prakasam",      "Sri Potti Sriramulu Nellore",      "Srikakulam",
      "Visakhapatnam",      "Vizianagaram",      "West Godavari",      "Y.S.R."    ]),

    StateData(
      id: 'AR', name: 'Arunachal Pradesh',
      districts: [
        "Anjaw",        "Changlang",        "Dibang Valley",        "East Kameng",
        "East Siang",        "Kra Daadi",        "Kurung Kumey",        "Lohit",
        "Lower Dibang Valley",        "Lower Siang",        "Lower Subansiri",        "Namsai",
        "Papum Pare",        "Siang",        "Tawang",        "Tirap",        "Upper Siang",
        "Upper Subansiri",        "West Kameng",        "West Siang"
      ], // Added districts
    ),
    StateData(
      id: 'AS',
      name: 'Assam',
      districts: [
        "Baksa",        "Barpeta",        "Biswanath",        "Bongaigaon",        "Cachar",
        "Charaideo",        "Chirang",        "Darrang",        "Dhemaji",        "Dhubri",
        "Dibrugarh",        "Dima Hasao",        "Goalpara",        "Golaghat",        "Hailakandi",
        "Hojai",        "Jorhat",        "Kamrup",        "Kamrup Metropolitan",        "Karbi Anglong",
        "Karimganj",        "Kokrajhar",        "Lakhimpur",        "Majuli",        "Morigaon",        "Nagaon",
        "Nalbari",        "Sivasagar",        "Sonitpur",        "South Salamara-Mankachar",        "Tinsukia",
        "Udalguri",        "West Karbi Anglong"
      ], // Added districts
    ),

    StateData(
      id: 'BR',
      name: 'Bihar',
      districts: [
        "Araria",        "Arwal",        "Aurangabad",        "Banka",        "Begusarai",
        "Bhagalpur",        "Bhojpur",        "Buxar",        "Darbhanga",        "Gaya",        "Gopalganj",
        "Jamui",        "Jehanabad",        "Kaimur (Bhabua)",        "Katihar",        "Khagaria",        "Kishanganj",
        "Lakhisarai",        "Madhepura",        "Madhubani",        "Munger",        "Muzaffarpur",
        "Nalanda",        "Nawada",        "Pashchim Champaran",        "Patna",        "Purbi Champaran",
        "Purnia",        "Rohtas",        "Saharsa",        "Samastipur",        "Saran",        "Sheikhpura",
        "Sheohar",        "Sitamarhi",        "Siwan",        "Supaul",        "Vaishali"
      ], // Added districts
    ),

    StateData(
      id: 'CG',
      name: 'Chhattisgarh ',
      districts: [
        "Balod",        "Baloda Bazar",        "Balrampur",        "Bastar",        "Bemetara",
        "Bijapur",        "Bilaspur",        "Dakshin Bastar Dantewada",        "Dhamtari",        "Durg",
        "Gariyaband",        "Janjgir - Champa",        "Jashpur",        "Kabeerdham",        "Kondagaon",
        "Korba",        "Koriya",        "Mahasamund",        "Mungeli",        "Narayanpur",        "Raigarh",
        "Raipur",        "Rajnandgaon",        "Sukma",        "Surajpur",        "Surguja", "Uttar Bastar Kanker"
      ],
    ),

    StateData(
      id: 'DL',
      name: 'Delhi',
      districts: [
        "Central",        "East",        "New Delhi",        "North",        "North East",        "North West",
        "Shahdara",        "South",        "South East Delhi",        "South West",        "West"
      ],
    ),

    StateData(
      id: 'GA',
      name: 'Goa',
      districts: ["North Goa", "South Goa"],
    ),
    StateData(
      id: 'GJ',
      name: 'Gujrat',
      districts: [
        "Ahmadabad",        "Amreli",        "Anand",        "Arvalli",        "Banas Kantha",
        "Bharuch",        "Bhavnagar",        "Botad",        "Chhota Udepur",        "Devbhoomi Dwarka",
        "Dohad",        "Gandhinagar",        "Gir Somnath",        "Jamnagar",        "Junagadh",
        "Kachchh",        "Kheda",        "Mahesana",        "Mahisagar",        "Morbi",        "Narmada",
        "Navsari",        "Panch Mahals",        "Patan",        "Porbandar",        "Rajkot",        "Sabar Kantha",
        "Surat",        "Surendranagar",        "Tapi",        "The Dangs",        "Vadodara",        "Valsad"
      ],
    ),

    StateData(id: 'HR', name: 'Haryana', districts: [
      "Ambala",      "Bhiwani",      "Charkhi Dadri",      "Faridabad",      "Fatehabad",      "Gurgaon",
      "Hisar",      "Jhajjar",      "Jind",      "Kaithal",      "Karnal",      "Kurukshetra",      "Mahendragarh",
      "Mewat",      "Palwal",      "Panchkula",      "Panipat",      "Rewari",      "Rohtak",      "Sirsa",
      "Sonipat",      "Yamunanagar"
    ]),

    StateData(id: 'HP', name: 'Himachal Pradesh', districts: [
      "Bilaspur",      "Chamba",      "Hamirpur",      "Kangra",      "Kinnaur",      "Kullu",
      "Lahul Spiti",      "Mandi",      "Shimla",      "Sirmaur",      "Solan",      "Una"
    ]),
    StateData(id: 'JH', name: 'Jharkhand', districts: [
      "Bokaro",      "Chatra",      "Deoghar",      "Dhanbad",      "Dumka",      "Garhwa",      "Giridih",
      "Godda",      "Gumla",      "Hazaribagh",      "Jamtara",      "Khunti",      "Kodarma",      "Latehar",
      "Lohardaga",      "Pakur",      "Palamu",      "Pashchimi Singhbhum",      "Purbi Singhbhum",      "Ramgarh",
      "Ranchi",      "Sahibganj",      "Saraikela-Kharsawan",      "Simdega"
    ]),

    StateData(id: 'KA', name: 'Karnataka', districts: [
      "Bagalkot",      "Bangalore",      "Bangalore Rural",      "Belgaum",      "Bellary",      "Bidar",
      "Bijapur",      "Chamarajanagar",      "Chikkaballapura",      "Chikmagalur",      "Chitradurga",
      "Dakshina Kannada",      "Davanagere",      "Dharwad",      "Gadag",      "Gulbarga",      "Hassan",
      "Haveri",      "Kodagu",      "Kolar",      "Koppal",      "Mandya",      "Mysore",      "Raichur",
      "Ramanagara",      "Shimoga",      "Tumkur",      "Udupi",      "Uttara Kannada",      "Yadgir"
    ]),

    StateData(id: 'KL', name: 'Kerala', districts: [
      "Alappuzha",
      "Ernakulam",
      "Idukki",
      "Kannur",
      "Kasaragod",
      "Kollam",
      "Kottayam",
      "Kozhikode",
      "Malappuram",
      "Palakkad",
      "Pathanamthitta",
      "Thiruvananthapuram",
      "Thrissur",
      "Wayanad"
    ]),

    StateData(id: 'MP', name: 'Madhya Pradesh', districts: [
      "Agar Malwa",
      "Alirajpur",
      "Anuppur",
      "Ashoknagar",
      "Balaghat",
      "Barwani",
      "Betul",
      "Bhind",
      "Bhopal",
      "Burhanpur",
      "Chhatarpur",
      "Chhindwara",
      "Damoh",
      "Datia",
      "Dewas",
      "Dhar",
      "Dindori",
      "Guna",
      "Gwalior",
      "Harda",
      "Hoshangabad",
      "Indore",
      "Jabalpur",
      "Jhabua",
      "Katni",
      "Khandwa (East Nimar)",
      "Khargone (West Nimar)",
      "Mandla",
      "Mandsaur",
      "Morena",
      "Narsimhapur",
      "Neemuch",
      "Panna",
      "Raisen",
      "Rajgarh",
      "Ratlam",
      "Rewa",
      "Sagar",
      "Satna",
      "Sehore",
      "Seoni",
      "Shahdol",
      "Shajapur",
      "Sheopur",
      "Shivpuri",
      "Sidhi",
      "Singrauli",
      "Tikamgarh",
      "Ujjain",
      "Umaria",
      "Vidisha"
    ]),

    StateData(id: 'MH', name: 'Maharashtra', districts: [
      "Ahmadnagar",
      "Akola",
      "Amravati",
      "Aurangabad",
      "Bhandara",
      "Bid",
      "Buldana",
      "Chandrapur",
      "Dhule",
      "Gadchiroli",
      "Gondiya",
      "Hingoli",
      "Jalgaon",
      "Jalna",
      "Kolhapur",
      "Latur",
      "Mumbai",
      "Mumbai Suburban",
      "Nagpur",
      "Nanded",
      "Nandurbar",
      "Nashik",
      "Osmanabad",
      "Palghar",
      "Parbhani",
      "Pune",
      "Raigarh",
      "Ratnagiri",
      "Sangli",
      "Satara",
      "Sindhudurg",
      "Solapur",
      "Thane",
      "Wardha",
      "Washim",
      "Yavatmal"
    ]),

    StateData(id: 'MN', name: 'Manipur', districts: [
      "Bishnupur",
      "Chandel",
      "Churachandpur",
      "Imphal East",
      "Imphal West",
      "Jiribam",
      "Kakching",
      "Kamjong",
      "Kangpokpi",
      "Noney",
      "Pherzawl",
      "Senapati",
      "Tamenglong",
      "Tengnoupal",
      "Thoubal",
      "Ukhrul"
    ]),

    StateData(id: 'ML', name: 'Meghalaya', districts: [
      "East Garo Hills",
      "East Jaintia Hills",
      "East Khasi Hills",
      "Jaintia Hills",
      "North Garo Hills",
      "Ribhoi",
      "South Garo Hills",
      "South West Garo Hills",
      "South West Khasi Hills",
      "West Garo Hills",
      "West Jaintia Hills",
      "West Khasi Hills"
    ]),

    StateData(id: 'MZ', name: 'Mizoram', districts: [
      "Aizawl",
      "Champhai",
      "Kolasib",
      "Lawngtlai",
      "Lunglei",
      "Mamit",
      "Saiha",
      "Serchhip"
    ]),

    StateData(id: 'NL', name: 'Nagaland', districts: [
      "Dimapur",
      "Kiphire",
      "Kohima",
      "Longleng",
      "Mokokchung",
      "Mon",
      "Peren",
      "Phek",
      "Tuensang",
      "Wokha",
      "Zunheboto"
    ]),

    StateData(id: 'OD', name: 'Odisha', districts: [
      "Anugul",
      "Balangir",
      "Baleshwar",
      "Bargarh",
      "Baudh",
      "Bhadrak",
      "Cuttack",
      "Debagarh",
      "Dhenkanal",
      "Gajapati",
      "Ganjam",
      "Jagatsinghapur",
      "Jajapur",
      "Jharsuguda",
      "Kalahandi",
      "Kandhamal",
      "Kendrapara",
      "Kendujhar",
      "Khordha",
      "Koraput",
      "Malkangiri",
      "Mayurbhanj",
      "Nabarangapur",
      "Nayagarh",
      "Nuapada",
      "Puri",
      "Rayagada",
      "Sambalpur",
      "Subarnapur",
      "Sundargarh"
    ]),

    StateData(id: 'PB', name: 'Punjab', districts: [
      "Amritsar",
      "Barnala",
      "Bathinda",
      "Faridkot",
      "Fatehgarh Sahib",
      "Fazilka",
      "Firozpur",
      "Gurdaspur",
      "Hoshiarpur",
      "Jalandhar",
      "Kapurthala",
      "Ludhiana",
      "Mansa",
      "Moga",
      "Muktsar",
      "Pathankot",
      "Patiala",
      "Rupnagar",
      "Sahibzada Ajit Singh Nagar",
      "Sangrur",
      "Shahid Bhagat Singh Nagar",
      "Tarn Taran"
    ]),

    StateData(id: 'RJ', name: 'Rajasthan', districts: [
      "Ajmer",
      "Alwar",
      "Banswara",
      "Baran",
      "Barmer",
      "Bharatpur",
      "Bhilwara",
      "Bikaner",
      "Bundi",
      "Chittaurgarh",
      "Churu",
      "Dausa",
      "Dhaulpur",
      "Dungarpur",
      "Hanumangarh",
      "Jaipur",
      "Jaisalmer",
      "Jalor",
      "Jhalawar",
      "Jhunjhunun",
      "Jodhpur",
      "Karauli",
      "Kota",
      "Nagaur",
      "Pali",
      "Pratapgarh",
      "Rajsamand",
      "Sawai Madhopur",
      "Sikar",
      "Sirohi",
      "Sri Ganganagar",
      "Tonk",
      "Udaipur"
    ]),

    StateData(id: 'SK', name: 'Sikkim', districts: [
      "East District",
      "North  District",
      "South District",
      "West District",
    ]),

    StateData(id: 'TN', name: 'Tamil Nadu', districts: [
      "Ariyalur",
      "Chennai",
      "Coimbatore",
      "Cuddalore",
      "Dharmapuri",
      "Dindigul",
      "Erode",
      "Kancheepuram",
      "Kanniyakumari",
      "Karur",
      "Krishnagiri",
      "Madurai",
      "Nagapattinam",
      "Namakkal",
      "Perambalur",
      "Pudukkottai",
      "Ramanathapuram",
      "Salem",
      "Sivaganga",
      "Thanjavur",
      "The Nilgiris",
      "Theni",
      "Thiruvallur",
      "Thiruvarur",
      "Thoothukkudi",
      "Tiruchirappalli",
      "Tirunelveli",
      "Tiruppur",
      "Tiruvannamalai",
      "Vellore",
      "Viluppuram",
      "Virudhunagar"
    ]),

    StateData(id: 'TG', name: 'Telangana', districts: [
      "Adilabad",
      "Bhadradri",
      "Hyderabad",
      "Jagtial",
      "Jangaon",
      "Jayashankar",
      "Jogulamba",
      "Kamareddy",
      "Karimnagar",
      "Khammam",
      "Komaram Bheem",
      "Mahabubabad",
      "Mahbubnagar",
      "Mancherial",
      "Medak",
      "Medchal-Malkajgiri",
      "Nagarkurnool",
      "Nalgonda",
      "Nirmal",
      "Nizamabad",
      "Peddapalli",
      "Rajanna",
      "Rangareddy",
      "Sangareddy",
      "Siddipet",
      "Suryapet",
      "Vikarabad",
      "Wanaparthy",
      "Warangal Rural",
      "Warangal Urban",
      "Yadadri"
    ]),

    StateData(id: 'TR', name: 'Tripura', districts: [
      "Dhalai",
      "Gomati",
      "Khowai",
      "North Tripura",
      "Sepahijala",
      "South Tripura",
      "Unakoti",
      "West Tripura"
    ]),

    StateData(id: 'UP', name: 'Uttar Pradesh', districts: [
      "Agra",
      "Aligarh",
      "Allahabad",
      "Ambedkar Nagar",
      "Amethi",
      "Amroha",
      "Auraiya",
      "Azamgarh",
      "Baghpat",
      "Bahraich",
      "Ballia",
      "Balrampur",
      "Banda",
      "Bara Banki",
      "Bareilly",
      "Basti",
      "Bhadohi",
      "Bijnor",
      "Budaun",
      "Bulandshahr",
      "Chandauli",
      "Chitrakoot",
      "Deoria",
      "Etah",
      "Etawah",
      "Faizabad",
      "Farrukhabad",
      "Fatehpur",
      "Firozabad",
      "Gautam Buddha Nagar",
      "Ghaziabad",
      "Ghazipur",
      "Gonda",
      "Gorakhpur",
      "Hamirpur",
      "Hapur",
      "Hardoi",
      "Hathras",
      "Jalaun",
      "Jaunpur",
      "Jhansi",
      "Kannauj",
      "Kanpur Dehat",
      "Kanpur Nagar",
      "Kasganj",
      "Kaushambi",
      "Kheri",
      "Kushinagar",
      "Lalitpur",
      "Lucknow",
      "Mahoba",
      "Mahrajganj",
      "Mainpuri",
      "Mathura",
      "Mau",
      "Meerut",
      "Mirzapur",
      "Moradabad",
      "Muzaffarnagar",
      "Pilibhit",
      "Pratapgarh",
      "Rae Bareli",
      "Rampur",
      "Saharanpur",
      "Sambhal",
      "Sant Kabir Nagar",
      "Shahjahanpur",
      "Shamli",
      "Shrawasti",
      "Siddharthnagar",
      "Sitapur",
      "Sonbhadra",
      "Sultanpur",
      "Unnao",
      "Varanasi"
    ]),

    StateData(id: 'UK', name: 'Uttarakhand', districts: [
      "Almora",
      "Bageshwar",
      "Chamoli",
      "Champawat",
      "Dehradun",
      "Garhwal",
      "Hardwar",
      "Nainital",
      "Pithoragarh",
      "Rudraprayag",
      "Tehri Garhwal",
      "Udham Singh Nagar",
      "Uttarkashi"
    ]),

    StateData(id: 'WB', name: 'West Bengal', districts: [
      "Alipurduar",
      "Bankura",
      "Barddhaman",
      "Birbhum",
      "Dakshin Dinajpur",
      "Darjiling",
      "Haora",
      "Hugli",
      "Jalpaiguri",
      "Jhargram",
      "Kalimpong",
      "Koch Bihar",
      "Kolkata",
      "Maldah",
      "Murshidabad",
      "Nadia",
      "North Twenty Four Parganas",
      "Paschim Bardhaman",
      "Paschim Medinipur",
      "Purba Bardhaman",
      "Purba Medinipur",
      "Puruliya",
      "South Twenty Four Parganas",
      "Uttar Dinajpur"
    ]),

    StateData(id: 'JK', name: 'Jammu and Kashmir', districts: [
      "Anantnag",
      "Badgam",
      "Bandipore",
      "Baramula",
      "Doda",
      "Ganderbal",
      "Jammu",
      "Kargil",
      "Kathua",
      "Kishtwar",
      "Kulgam",
      "Kupwara",
      "Leh(Ladakh)",
      "Pulwama",
      "Punch",
      "Rajouri",
      "Ramban",
      "Reasi",
      "Samba",
      "Shupiyan",
      "Srinagar",
      "Udhampur"
    ]),

    StateData(
        id: 'AN',
        name: 'Andaman Nicobar',
        districts: ["Nicobars", "North & Middle Andaman", "South Andaman"]),

    StateData(
        id: 'PD',
        name: 'Puducherry',
        districts: ["Karaikal", "Mahe", "Puducherry", "Yanam"]),

    // अन्य राज्यों को भी इसी तरह से परिभाषित करें।
  ];
}

Map<String, List<String>> getStatesMap() {
  final Map<String, List<String>> statesMap = {};
  for (var state in getAllStates()) {
    statesMap[state.name] = state.districts;
  }
  return statesMap;
}
// list end

Future<void> uploadStatesToFirestore() async {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final CollectionReference statesCollection = firestore.collection('states');

  final List<StateData> states = getAllStates();

  for (var state in states) {
    await statesCollection.doc(state.id).set(state.toMap());
  }
}
