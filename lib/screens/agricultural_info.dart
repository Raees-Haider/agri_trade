import 'package:flutter/material.dart';

class ChatbotScreen extends StatefulWidget {
  @override
  _ChatbotScreenState createState() => _ChatbotScreenState();
}

class _ChatbotScreenState extends State<ChatbotScreen> {
  final Map<String, String> faq = {
    "What are the uses of barley?":
    "Barley is used as food (barley flour, porridge), fodder for livestock, and as a key ingredient in the production of beer and whiskey.",
    "What type of crop is potato?":
    "Potato is a tuber crop and a Rabi crop, grown primarily for its edible tubers.",
    "When is the sowing season for potatoes?":
    "Potatoes are sown from October to November, in well-drained, fertile soil that allows for healthy root development.",
    "When are potatoes harvested?":
    "Potatoes are harvested from March to April, once the leaves start to wither, and the tubers have matured.",
    "Where are potatoes mostly grown?":
    "Potatoes are grown in Sindh, Punjab, and Khyber Pakhtunkhwa, where the soil and climate conditions are favourable.",
    "What type of crop is tomato?":
    "Tomato is a vegetable crop and a Kharif crop, commonly grown for its fruit.",
    "What type of land is found in Lahore?":
    "Lahore is situated on fertile alluvial plains, formed by the deposits of rivers flowing through the region. The land is ideal for agriculture due to its rich soil composition and extensive canal irrigation system that provides water for farming.",
    "What are the major crops grown in Lahore?":
    "Lahore is a hub for agricultural activity with wheat, rice, sugarcane, and maize being the main crops. Wheat is the staple crop grown during the Rabi season, while rice and sugarcane thrive during the Kharif season, benefiting from the warm climate and ample water resources.",
    "Which fruits and vegetables are grown in Lahore?":
    "Lahore's agricultural diversity includes fruits like guava and citrus, which thrive in its subtropical climate. Vegetables such as tomatoes, onions, and potatoes are also extensively cultivated, supporting both local consumption and trade.",
    "What is the main type of land in Faisalabad?":
    "Faisalabad is known for its fertile plains, which benefit from an advanced irrigation system, including canals fed by the River Chenab. This land supports a variety of crops, making Faisalabad one of the most agriculturally productive regions in Punjab.",
    "Which crops are significant in Faisalabad?":
    "Faisalabad’s agriculture is dominated by wheat, cotton, sugarcane, and maize. Cotton production plays a crucial role in supporting the textile industry, while wheat and maize contribute to staple food supplies.",
    "What are the key fruits and vegetables produced in Faisalabad?":
    "Faisalabad is famous for mangoes and guavas, particularly varieties known for their sweet flavor. Vegetables like potatoes and carrots are cultivated on a large scale, often exported to other regions.",
    "What kind of land is found in Multan?":
    "Multan features arid plains, which are heavily dependent on irrigation from canals sourced from the River Chenab. The combination of dry climate and irrigation systems is ideal for certain crops, particularly fruit farming.",
    "Which crops are predominantly grown in Multan?":
    "Multan is one of the major producers of cotton, wheat, and sugarcane in Punjab. Cotton, often referred to as 'white gold,' forms the backbone of Multan's agricultural economy. Wheat serves as the staple food crop, while sugarcane supports local sugar mills.",
    "What fruits are famous in Multan?":
    "Multan is globally renowned for its mangoes, particularly the Sindhri and Chaunsa varieties. Additionally, citrus fruits such as oranges and melons are also significant contributors to the region’s agricultural exports.",
    "What type of land does Sialkot have?":
    "Sialkot is located on fertile alluvial plains, enriched by river sediments from the Chenab River. The region benefits from a well-established irrigation network that ensures consistent agricultural output.",
    "What are the main crops grown in Sialkot?":
    "Sialkot’s major crops include basmati rice, wheat, and sugarcane. Basmati rice is especially famous for its aromatic quality and is exported to international markets.",
    "Which fruits and vegetables are cultivated in Sialkot?":
    "Fruits such as guava and citrus are widely grown in Sialkot. Vegetables, including onions, garlic, and spinach, are cultivated to meet local demands and support the agro-based economy.",
    "What type of land is found in Rawalpindi?":
    "Rawalpindi is characterized by barani (rainfed) lands, as the region lacks extensive canal irrigation. Rainwater and seasonal streams are the primary sources of water for agriculture.",
    "What crops are commonly grown in Rawalpindi?":
    "Due to the reliance on rainfall, Rawalpindi primarily grows wheat, barley, and millet, which are less water-intensive and well-suited to the semi-arid climate.",
    "Which fruits and vegetables are famous in Rawalpindi?":
    "Citrus fruits, particularly oranges and kinnow, are grown here. Additionally, guava, potatoes, and fodder crops are cultivated, supporting both food production and livestock farming.",
    "What is the primary land type in Bahawalpur?":
    "Bahawalpur consists of desert terrain (Cholistan Desert) that has been partially converted into arable land through irrigation. The availability of water from canals has enabled productive agriculture in this otherwise arid region.",
    "Which crops dominate Bahawalpur’s agriculture?":
    "Bahawalpur is known for its production of cotton, wheat, and sugarcane. The region is a significant contributor to Pakistan's textile and sugar industries.",
    "What fruits and vegetables are grown in Bahawalpur?":
    "Dates are the signature fruit of Bahawalpur, along with melons. Various vegetables are also cultivated, including onions, cucumbers, and tomatoes.",
    "What kind of land is found in Sargodha?":
    "Sargodha is located on fertile plains with a highly productive soil profile and ample irrigation from canals fed by the Jhelum River. This makes it one of the top agricultural regions in Punjab.",
    "What are the major crops grown in Sargodha?":
    "Wheat, rice, and sugarcane are the staple crops. The fertile land and access to water make it possible to produce high yields of these essential crops.",
    "Which fruit is Sargodha famous for?":
    "Sargodha is internationally renowned for its kinnow (a type of mandarin orange) and guavas, which are exported due to their exceptional taste and quality.",
    "What type of land does Dera Ghazi Khan have?":
    "Dera Ghazi Khan has diverse terrains, ranging from fertile plains in the Indus basin to rugged hilly areas near the Suleiman Range. Irrigation supports agriculture in the plains, while rainfed farming occurs in the hills.",
    "What are the main crops grown in Dera Ghazi Khan?":
    "Wheat, sugarcane, and rice are the key crops. The plains benefit from the canal irrigation system, which ensures high crop productivity.",
    "Which fruits are commonly grown in Dera Ghazi Khan?":
    "Dates are the signature fruit of the region, along with citrus fruits such as oranges and guavas, which are cultivated extensively.",
    "What type of land is found in Narowal?":
    "Narowal has fertile alluvial plains enriched by river sediments from the Ravi River. The region benefits from an efficient canal irrigation system, supporting diverse agricultural activities.",
    "What are the major crops grown in Narowal?":
    "The main crops include wheat, rice, and sugarcane. Narowal is particularly known for its production of high-quality basmati rice, which is both consumed locally and exported.",
    "Which fruits and vegetables are grown in Narowal?":
    "Citrus fruits, guava, and jujube (ber) are widely cultivated in Narowal. Vegetables like cauliflower, tomatoes, and potatoes are also significant contributors to the region's agriculture.",
    "What type of land is found in Sahiwal?":
    "Sahiwal has fertile plains with a well-established irrigation system that draws water from the Sutlej River. The region's soil is highly conducive to the cultivation of both crops and livestock farming.",
    "What are the major crops grown in Sahiwal?":
    "Sahiwal is known for its production of wheat, cotton, sugarcane, and maize. It is also a hub for fodder crops, supporting its renowned cattle farming industry.",
    "Which fruits and vegetables are grown in Sahiwal?":
    "Mangoes, guava, and citrus fruits thrive in Sahiwal's subtropical climate. Vegetables such as onions, potatoes, and tomatoes are grown extensively, contributing to both local consumption and trade.",
    "What type of land does Karachi have?":
    "Karachi features coastal sandy soil, which is relatively less fertile for traditional farming. However, this soil is suitable for growing crops and fruits that thrive in saline and sandy conditions. Additionally, the proximity to the sea provides a unique environment for certain agricultural practices.",
    "What are the primary agricultural products of Karachi?":
    "Karachi's agriculture is limited but focused on vegetables and fodder crops. These include spinach, tomatoes, and chilies, which are cultivated to meet the demands of the city's large population. Fodder crops support livestock farming in the outskirts.",
    "Which fruits are cultivated in Karachi?":
    "Coconut trees thrive along the coastal areas of Karachi due to the saline environment. Dates are another significant fruit, as they adapt well to the arid conditions of the region.",
    "What is the main type of land in Hyderabad?":
    "Hyderabad is situated on fertile alluvial plains, enriched by the Indus River and its irrigation network. The land is highly productive, supporting the cultivation of diverse crops and fruits.",
    "What are the major crops in Hyderabad?":
    "Hyderabad produces wheat, rice, and sugarcane as its primary crops. Rice paddies dominate the agricultural landscape, supported by irrigation systems that ensure optimal water availability during the growing season.",
    "Which fruits are grown in Hyderabad?":
    "Hyderabad is known for its mangoes, including the famous Sindhri variety, which is prized for its sweetness and size. Bananas are another significant fruit, grown extensively in the region.",
    "What is the primary type of land in Sukkur?":
    "Sukkur boasts fertile irrigated plains due to its location near the Indus River. The region benefits from the Sukkur Barrage, which provides consistent irrigation, making it one of the most agriculturally productive areas in Sindh.",
    "What are the main crops grown in Sukkur?":
    "Sukkur is a major producer of wheat, sugarcane, and cotton. The region also plays a crucial role in Pakistan’s textile industry, thanks to its cotton production.",
    "Which fruits are famous in Sukkur?":
    "Sukkur is renowned for its dates, particularly the Aseel variety, which is exported worldwide. Citrus fruits, including oranges, are also cultivated extensively.",
    "What type of land is found in Khairpur?":
    "Khairpur features arid but fertile plains. The region relies on an efficient irrigation network from the Indus River, allowing for the cultivation of various crops and fruits despite its dry climate.",
    "What crops dominate agriculture in Khairpur?":
    "Khairpur’s agriculture is centered around wheat, sugarcane, and cotton. The availability of water through canals ensures stable yields of these crops.",
    "What is Khairpur famous for?":
    "Khairpur is celebrated for its premium quality dates, particularly the Aseel and Karbala varieties. The region is one of the largest producers of dates in Pakistan, with significant exports.",
    "What is the land type in Thatta?":
    "Thatta has coastal plains, with a mix of saline and fertile soils. The region is influenced by its proximity to the Arabian Sea, which impacts its agricultural practices and crop selection.",
    "What crops are grown in Thatta?":
    "Rice is the most significant crop in Thatta, as it thrives in the waterlogged conditions of the area. Wheat and sugarcane are also cultivated, supported by irrigation systems.",
    "Which fruits and vegetables are cultivated in Thatta?":
    "Thatta is known for its production of dates and a variety of vegetables, including eggplants, chilies, and onions. The region’s farmers adapt to the coastal environment to produce these crops effectively.",
    "What type of land is found in Peshawar?":
    "Peshawar has fertile irrigated plains, supported by the Kabul River and its canal system. This land is well-suited for intensive agriculture, enabling the region to grow diverse crops and fruits.",
    "What are the major crops grown in Peshawar?":
    "Wheat, maize, and sugarcane are the primary crops cultivated in Peshawar. Wheat is the staple food crop, while maize and sugarcane contribute to both local consumption and industrial use.",
    "Which fruits and vegetables are grown in Peshawar?":
    "Peshawar is known for its apples, peaches, and plums, which are grown in orchards across the region. Tomatoes and onions are among the most commonly grown vegetables.",
    "What type of land is found in Mardan?":
    "Mardan features fertile plains supported by an extensive irrigation network. The land’s productivity makes it one of the top agricultural regions in KP.",
    "What are the major crops grown in Mardan?":
    "Mardan produces wheat, maize, and sugarcane as its primary crops. Additionally, tobacco is a significant cash crop, contributing to the local economy.",
    "Which fruits and vegetables are significant in Mardan?":
    "Apricots, peaches, and guavas are widely grown in Mardan, benefiting from the region’s favourable climate. Tobacco farming is also prominent, with Mardan being one of Pakistan's leading producers.",
    "What type of land is found in Abbottabad?":
    "Abbottabad has hilly terrain with rainfed agricultural lands. Terraced farming is practiced in the mountainous areas to maximize arable land use.",
    "What are the major crops of Abbottabad?":
    "Wheat, maize, and barley are the primary crops cultivated in Abbottabad. The rainfed conditions make these crops suitable for the region’s agricultural practices."
  };

  TextEditingController _controller = TextEditingController();

  String _response = "";

  void getAnswer(String question) async {
    setState(() {
      showText = true;
      _response = 'typing';
      _controller.text = '';
    });
    await Future.delayed(const Duration(seconds: 3));
    setState(() {
      if (faq.containsKey(question)) {
        _response = faq[question]!;
      } else {
        _response = "Sorry, I don't have an answer to that question.";
      }
    });
  }

  void handleUserInput() {
    String question = _controller.text.trim();
    if (question.isNotEmpty) {
      getAnswer(question);
    }
  }

  void addInController(String question) {
    _controller.text = question.trim();
  }

  bool showText = false;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chatbot Q&A'),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 16.0, right: 16, bottom: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: faq.keys.length,
                itemBuilder: (context, index) {
                  String question = faq.keys.elementAt(index);
                  return Card(
                    margin: const EdgeInsets.only(left: 30, bottom: 10),
                    color: Colors.white60.withOpacity(0.8),
                    child: ListTile(
                      title: Text(question),
                      onTap: () => addInController(question),
                    ),
                  );
                },
              ),
            ),
            if (showText) ...[
              const SizedBox(height: 10),
              Container(
                padding: const EdgeInsets.all(12),
                margin: const EdgeInsets.only(right: 30),
                decoration: BoxDecoration(
                  color: Colors.green.withOpacity(0.9),
                  border: Border.all(color: Colors.transparent),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  _response,
                  style: const TextStyle(fontSize: 16, color: Colors.white),
                ),
              ),
            ],
            const SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: const InputDecoration(
                      hintText: 'Ask a question...',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                IconButton(
                  onPressed: () {
                    getAnswer(_controller.text);
                  },
                  icon: const Icon(
                    Icons.send,
                    color: Colors.green,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}