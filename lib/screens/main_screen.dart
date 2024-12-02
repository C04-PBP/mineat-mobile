import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mineat/screens/food_details_screen.dart';
import 'package:mineat/screens/forum_screen.dart';
import 'package:mineat/screens/home_screen.dart';
import 'package:mineat/screens/restaurant_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int selectedIndex = 0;
  final List<Map<String, dynamic>> allFood = [
    {
      "title": "Ayam Balado",
      "price": 42000,
      "ingredients":
          "Chicken, red chilies, shallots, garlic, tomatoes, lime leaves, salt, sugar, oil,",
      "description": "fried chicken smothered with chili",
      "imageUrl":
          "https://asset.kompas.com/crops/puSCmWekgKRyE5cRP8IWHhIgTsU=/0x0:1000x667/750x500/data/photo/2023/02/22/63f567b4ab9d0.jpeg"
    },
    {
      "title": "Rendang",
      "price": 55000,
      "ingredients":
          "Beef, coconut milk, turmeric, garlic, shallots, chilies, lemongrass, kaffir lime leaves,",
      "description":
          "chunks of beef stewed in spicy coconut milk and chili gravy, cooked well until dried Other than beef, rendang ayam (chicken rendang), rendang itiak (duck rendang), rendang lokan (mussel rendang), and number of other varieties can be found",
      "imageUrl":
          "https://img.okezone.com/content/2023/11/08/298/2916908/resep-rendang-asli-padang-enaknya-bikin-nagih-fXMyM16D9A.jpg"
    },
    {
      "title": "Ayam Goreng",
      "price": 38000,
      "ingredients": "Chicken, garlic, turmeric, coriander, salt, water, oil,",
      "description": "fried chicken with spicy granules",
      "imageUrl":
          "https://www.astronauts.id/blog/wp-content/uploads/2023/04/Resep-Ayam-Goreng-Serundeng-ala-Rumahan-yang-Nggak-Kalah-Enak-dari-Restoran-1200x900.jpg"
    },
    {
      "title": "Gulai Ayam",
      "price": 39000,
      "ingredients":
          "Chicken, coconut milk, turmeric, garlic, shallots, lemongrass, kaffir lime leaves, salt,",
      "description":
          "Curry dish with main ingredients chicken and unripe jackfruit",
      "imageUrl":
          "https://asset.kompas.com/crops/4Pge4o-1NYVqjBcfiXvB2nAJcnM=/0x0:1000x667/750x500/data/photo/2021/05/11/609a26028d3c9.jpg"
    },
    {
      "title": "Kepiting Saus Padang",
      "price": 75000,
      "ingredients":
          "Crab, chilies, shallots, garlic, lemongrass, turmeric, lime leaves, salt, oil,",
      "description":
          "seafood dish of crab served in hot and spicy Padang sauce",
      "imageUrl":
          "https://www.tokomesin.com/wp-content/uploads/2015/10/kepiting-saos-padang-tokomesin.jpg"
    },
    {
      "title": "Rajungan Goreng",
      "price": 70000,
      "ingredients": "Crab, salt, oil,",
      "description": "crispy fried crab",
      "imageUrl":
          "https://cdn0-production-images-kly.akamaized.net/b4c9FCwttCcvLjdJ7sned_aS06c=/1x40:1000x603/1200x675/filters:quality(75):strip_icc():format(jpeg)/kly-media-production/medias/3570968/original/013224500_1631594241-shutterstock_1796323171.jpg"
    },
    {
      "title": "Martabak kubang",
      "price": 65000,
      "ingredients":
          "Dough, ground beef, garlic, shallots, curry powder, eggs, oil,",
      "description":
          "Minangkabau-style of murtabak from Lima Puluh Kota Regency, West Sumatra, It is Arab–Indian–Minangkabau fusion dish",
      "imageUrl":
          "https://assets-pergikuliner.com/4LbOxRUPxgiqRbzDwXDkOcxd47g=/fit-in/1366x768/smart/filters:no_upscale()/https://assets-pergikuliner.com/uploads/image/picture/2268274/picture-1626920552.jpg"
    },
    {
      "title": "Martabak",
      "price": 60000,
      "ingredients":
          "Dough, ground beef, scallions, garlic, coriander, cumin, oil,",
      "description":
          "Stuffed pancake or pan-fried bread, sometimes filled with beef and scallions",
      "imageUrl":
          "https://bhinneka-resto.com/menu/images/speasyimagegallery/albums/18/images/martabak-daging-padang.jpg"
    },
    {
      "title": "Ikan Panggang",
      "price": 60000,
      "ingredients":
          "Fish, turmeric, garlic, shallots, red chilies, lime, salt, pepper.",
      "description":
          "Grilled fish marinated in traditional Padang spices and served with sambal.",
      "imageUrl":
          "https://img-global.cpcdn.com/recipes/7e5ace0001a81816/680x482cq70/ikan-bakar-khas-minang-foto-resep-utama.jpg"
    },
    {
      "title": "Dendeng batokok",
      "price": 55000,
      "ingredients": "Thin beef slices, garlic, tamarind, salt, chilies, oil,",
      "description": "Thin strips of pounded and softened grilled beef",
      "imageUrl":
          "https://www.sasa.co.id/medias/page_medias/resep_dendeng_balado_kering.jpg"
    },
    {
      "title": "Gulai kambiang",
      "price": 55000,
      "ingredients":
          "Mutton, coconut milk, turmeric, garlic, chilies, lemongrass, kaffir lime leaves, salt,",
      "description": "Mutton gulai",
      "imageUrl":
          "https://img.kurio.network/rLAunDR1yIriIhbbSXwU9dIazcY=/440x440/filters:quality(80)/https://kurio-img.kurioapps.com/22/07/11/3f999767-b8cd-4412-8bf2-6d007cb39cc2.jpg"
    },
    {
      "title": "Nasi briyani",
      "price": 55000,
      "ingredients":
          "Basmati rice, ghee, mutton or chicken, onions, garlic, ginger, cloves, cardamom, cinnamon, yogurt, saffron,",
      "description":
          "Flavoured rice dish cooked or served with mutton, chicken, vegetable or fish curry",
      "imageUrl":
          "https://asset.kompas.com/crops/EJ28d4wVrYLoSBWzdnd_mQjbQyY=/0x183:750x683/750x500/data/photo/2022/07/01/62be3c8565e3c.jpeg"
    },
    {
      "title": "Dendeng balado",
      "price": 52000,
      "ingredients":
          "Thin beef slices, red chilies, shallots, garlic, tomatoes, lime leaves, salt, oil,",
      "description": "Thin crispy beef with chili",
      "imageUrl":
          "https://www.sasa.co.id/medias/page_medias/resep_dendeng_balado.jpg"
    },
    {
      "title": "Dendeng",
      "price": 50000,
      "ingredients": "Beef, garlic, coriander, tamarind, salt, oil,",
      "description": "Thinly sliced dried meat",
      "imageUrl":
          "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSiBNMWYvpmCt1h1cajjZXjk-o_lv3e2NwtoA&s"
    },
    {
      "title": "Gulai kepala ikan kakap merah",
      "price": 50000,
      "ingredients":
          "Red snapper's head, coconut milk, turmeric, garlic, chilies, lemongrass, kaffir lime leaves, salt,",
      "description": "Red snapper's head gulai",
      "imageUrl":
          "https://img-global.cpcdn.com/recipes/2d402f7844250193/1360x964cq70/gulai-kepala-ikan-kakap-merah-foto-resep-utama.webp"
    },
    {
      "title": "Nasi padang",
      "price": 50000,
      "ingredients": "Rice, pre-cooked dishes,",
      "description":
          "Steamed rice served with various choices of pre-cooked dishes",
      "imageUrl":
          "https://static.promediateknologi.id/crop/0x0:0x0/0x0/webp/photo/esensi/2023/11/nasi-padang.jpeg"
    },
    {
      "title": "Udang saus padang",
      "price": 50000,
      "ingredients":
          "Prawns, Cooking oil, Garlic (minced), Shallots (sliced), Red chilies (sliced), Tomato sauce, Sweet soy sauce, Salt, Black pepper, Lime juice, Water",
      "description":
          "Shrimp cooked in a spicy Padang-style sauce of chili, garlic, and spices",
      "imageUrl":
          "https://lezatpedia.id/wp-content/uploads/2023/08/resep-udang-saus-padang-sederhana-dan-mudah.webp"
    },
    {
      "title": "Ayam Cabe Merah",
      "price": 50000,
      "ingredients":
          "Chicken, red chilies, garlic, shallots, lemongrass, kaffir lime leaves, ginger, salt, sugar.",
      "description":
          "Chicken cooked in a fiery red chili sauce with Padang-style seasoning.",
      "imageUrl": "https://i.ytimg.com/vi/lBT2cODxEHM/maxresdefault.jpg"
    },
    {
      "title": "Ayam Gulai Nangka",
      "price": 50000,
      "ingredients":
          "Chicken, young jackfruit, coconut milk, red chilies, turmeric, galangal, lemongrass, bay leaves.",
      "description":
          "Chicken simmered in a spicy coconut curry with young jackfruit.",
      "imageUrl":
          "https://static.promediateknologi.id/crop/0x0:0x0/750x500/webp/photo/p1/1067/2024/05/21/maxresdefault-8-1983884964.jpg"
    },
    {
      "title": "Gulai kepala ikan",
      "price": 48000,
      "ingredients":
          "Fish head, coconut milk, turmeric, garlic, shallots, lemongrass, kaffir lime leaves, salt,",
      "description": "Fish head gulai",
      "imageUrl":
          "https://cdn.idntimes.com/content-images/community/2021/10/fromandroid-f2a4fb48c1f2c9948243bd190a3c71c6.jpg"
    },
    {
      "title": "Gulai udang",
      "price": 48000,
      "ingredients":
          "Shrimp, coconut milk, turmeric, garlic, shallots, lemongrass, kaffir lime leaves, salt,",
      "description": "Shrimp gulai",
      "imageUrl":
          "https://cdn-brilio-net.akamaized.net/news/2021/08/18/211860/1544238-1000xauto-resep-gulai-udang.jpg"
    },
    {
      "title": "Asam padeh",
      "price": 45000,
      "ingredients":
          "Fish, tamarind, chilies, turmeric, shallots, garlic, ginger, lemongrass, salt, water,",
      "description": "Sour and spicy fish stew dish",
      "imageUrl":
          "https://asset.kompas.com/crops/orYuU83oqu-mGLBkAGhZA5NsFBA=/109x69:909x603/750x500/data/photo/2023/09/10/64fd27148f94b.jpg"
    },
    {
      "title": "Ayam percik",
      "price": 45000,
      "ingredients":
          "Chicken, coconut milk, tamarind, turmeric, chili paste, garlic, ginger, lemongrass, salt, oil,",
      "description": "Grilled chicken with a spicy, curry-like sauce",
      "imageUrl":
          "https://img-global.cpcdn.com/recipes/f0f4f03bf529383e/680x482cq70/ayam-percik-kelantan-foto-resep-utama.jpg"
    },
    {
      "title": "Cumi saus padang",
      "price": 45000,
      "ingredients":
          "Squid, Cooking oil, Garlic (minced), Shallots (sliced), Red chilies (sliced), Tomato sauce, Sweet soy sauce, Salt, Black pepper, Lime juice, Water",
      "description":
          "Squid cooked in a spicy Padang-style sauce of chili, garlic, and spices",
      "imageUrl":
          "https://www.blibli.com/friends-backend/wp-content/uploads/2023/03/B300019-Cover-resep-cumi-saus-padang-scaled.jpg"
    },
    {
      "title": "Gulai itik",
      "price": 45000,
      "ingredients":
          "Duck, coconut milk, turmeric, garlic, chilies, lemongrass, kaffir lime leaves, salt,",
      "description": "Duck gulai",
      "imageUrl":
          "https://cdn.yummy.co.id/content-images/images/20201028/4ihcIe9bTBe8509cLMGA6ut3toMcXkXA-31363033383635373030d41d8cd98f00b204e9800998ecf8427e.jpg?x-oss-process=image/resize,w_388,h_388,m_fixed,x-oss-process=image/format,webp"
    },
    {
      "title": "Kalio Daging",
      "price": 45000,
      "ingredients":
          "Beef, coconut milk, turmeric, garlic, shallots, chilies, lemongrass, kaffir lime leaves,",
      "description":
          "similar to rendang; while rendang is rather dry, kalio is watery and light-colored",
      "imageUrl":
          "https://i.ytimg.com/vi/5yOqx_wRcLk/hq720.jpg?sqp=-oaymwEhCK4FEIIDSFryq4qpAxMIARUAAAAAGAElAADIQj0AgKJD&rs=AOn4CLDx9t5odrM5TA0JReDbmi7D-IqVCw"
    },
    {
      "title": "Nasi kapau",
      "price": 45000,
      "ingredients": "Rice, various dishes,",
      "description":
          "steamed rice topped with various choices of dishes originated from Bukittinggi, West Sumatra",
      "imageUrl":
          "https://i0.wp.com/resepkoki.id/wp-content/uploads/2020/12/Resep-Nasi-Kapau.jpg?fit=1080%2C1440&ssl=1"
    },
    {
      "title": "Satay daging",
      "price": 45000,
      "ingredients": "Beef, sweet soy sauce, garlic, shallots, skewers,",
      "description":
          "dish of seasoned, skewered and grilled meat, served with a sauce",
      "imageUrl":
          "https://gerobaksate.my/serikembangan/wp-content/uploads/sites/32/2023/10/sate-daging-2.jpg"
    },
    {
      "title": "Udang balado",
      "price": 45000,
      "ingredients":
          "Shrimp, red chilies, garlic, shallots, tomatoes, lime leaves, salt,",
      "description": "shrimp in chili",
      "imageUrl":
          "https://cdn.idntimes.com/content-images/community/2023/05/screenshot-20230516-173843-instagram-d3d5f7bf15788283d4d39394399f0745.jpg"
    },
    {
      "title": "Ayam pop goreng",
      "price": 43000,
      "ingredients":
          "Chicken, coconut water, garlic, shallots, bay leaves, lime leaves, salt, oil,",
      "description":
          "Padang-style chicken, boiled/steamed and later fried, While fried chicken is golden brown, ayam pop is light-colored",
      "imageUrl":
          "https://www.sasa.co.id/medias/page_medias/Screen_Shot_2021-11-29_at_16_40_14.png"
    },
    {
      "title": "Ayam pop rebus",
      "price": 43000,
      "ingredients":
          "Chicken, coconut water, garlic, shallots, bay leaves, lime leaves, salt, oil,",
      "description": "Padang-style chicken, boiled/steamed.",
      "imageUrl":
          "https://assets.promediateknologi.id/crop/0x0:0x0/750x500/webp/photo/p1/364/2023/09/11/ayam-pop-1758146136.jpg"
    },
    {
      "title": "Ayam balado",
      "price": 42000,
      "ingredients":
          "Chicken, red chilies, shallots, garlic, tomatoes, lime leaves, salt, sugar, oil,",
      "description": "chicken in chili",
      "imageUrl":
          "https://asset.kompas.com/crops/puSCmWekgKRyE5cRP8IWHhIgTsU=/0x0:1000x667/750x500/data/photo/2023/02/22/63f567b4ab9d0.jpeg"
    },
    {
      "title": "Ayam lado ijo",
      "price": 42000,
      "ingredients":
          "Chicken, green chilies, shallots, garlic, lime leaves, salt, oil,",
      "description": "chicken in green chili",
      "imageUrl":
          "https://static.promediateknologi.id/crop/6x262:1075x1659/750x500/webp/photo/p1/1005/2024/01/28/Screenshot_20240128_195516_Instagram-3462551055.jpg"
    },
    {
      "title": "Ayam bumbu",
      "price": 41000,
      "ingredients":
          "Chicken, garlic, turmeric, coriander, cumin, ginger, shallots, salt, coconut milk, oil,",
      "description": "chicken with spices",
      "imageUrl":
          "https://static.promediateknologi.id/crop/0x0:0x0/0x0/webp/photo/p2/74/2024/05/01/3c47eeba484ca5b1b586d8b374aba571-906762525.jpg"
    },
    {
      "title": "Ayam bakar",
      "price": 40000,
      "ingredients":
          "Chicken, tamarind, kecap manis (sweet soy sauce), garlic, shallots, chili, turmeric, lemongrass, salt, oil,",
      "description": "grilled spicy chicken",
      "imageUrl":
          "https://www.sasa.co.id/medias/page_medias/ayam_bakar_lumajang.jpg"
    },
    {
      "title": "Gulai daging",
      "price": 40000,
      "ingredients":
          "Meat, coconut milk, turmeric, chilies, shallots, garlic, lemongrass, kaffir lime leaves, salt, water,",
      "description":
          "curry dish with main ingredients beef and unripe jackfruit",
      "imageUrl":
          "https://assets.pikiran-rakyat.com/crop/0x0:0x0/750x500/photo/2021/11/25/217085998.jpeg"
    },
    {
      "title": "Gulai cancang",
      "price": 40000,
      "ingredients":
          "Meat and internal organs, coconut milk, turmeric, garlic, chilies, lemongrass, salt,",
      "description": "gulai of meats and cow internal organs",
      "imageUrl":
          "https://nnc-media.netralnews.com/IMG-Netral-News-Admin-35-I2FNWD19UL.jpg"
    },
    {
      "title": "Nasi kari or nasi gulai",
      "price": 40000,
      "ingredients":
          "Rice, coconut milk, turmeric, chilies, garlic, shallots, lemongrass, various dishes,",
      "description": "rice and curry",
      "imageUrl":
          "https://media-cdn.tripadvisor.com/media/photo-s/1a/df/23/db/nasi-padang-ayam-gulai.jpg"
    },
    {
      "title": "Sate padang",
      "price": 40000,
      "ingredients":
          "Meat, turmeric, garlic, lemongrass, shallots, thick sauce (rice Flour-based),",
      "description":
          "Padang-style of satay, skewered barbecued meat with thick yellow sauce",
      "imageUrl": "https://i.ytimg.com/vi/hmWh0thXUbQ/maxresdefault.jpg"
    },
    {
      "title": "Soto padang",
      "price": 40000,
      "ingredients":
          "Meat, turmeric, garlic, lemongrass, shallots, thick sauce (rice Flour-based),",
      "description": "a soup of beef",
      "imageUrl":
          "https://www.sasa.co.id/medias/page_medias/resep_soto_padang.jpg"
    },
    {
      "title": "Ayam goreng",
      "price": 38000,
      "ingredients": "Chicken, garlic, turmeric, coriander, salt, water, oil,",
      "description": "fried chicken with spicy granules",
      "imageUrl":
          "https://www.astronauts.id/blog/wp-content/uploads/2023/04/Resep-Ayam-Goreng-Serundeng-ala-Rumahan-yang-Nggak-Kalah-Enak-dari-Restoran-1200x900.jpg"
    },
    {
      "title": "Gulai tambusu",
      "price": 38000,
      "ingredients":
          "Cow intestines, eggs, tofu, coconut milk, turmeric, garlic, chilies, lemongrass, kaffir lime leaves,",
      "description":
          "gulai of cow intestines usually filled with eggs and tofu",
      "imageUrl":
          "https://asset.kompas.com/crops/bcpcDBgw82mDYr495vYWQBLff4A=/0x352:667x797/750x500/data/photo/2022/08/12/62f5e26894a4f.jpg"
    },
    {
      "title": "Ikan bilih",
      "price": 38000,
      "ingredients": "Small freshwater fish, salt, oil,",
      "description": "fried small freshwater fish of the genus Mystacoleucus",
      "imageUrl":
          "https://packagepadang.com/wp-content/uploads/2023/05/ikan-bilih.jpg"
    },
    {
      "title": "Gulai babek",
      "price": 37000,
      "ingredients":
          "Cow tripe, coconut milk, turmeric, chilies, garlic, shallots, lemongrass, salt,",
      "description": "gulai babat, or gulai paruik kabau, gulai of cow tripes",
      "imageUrl":
          "https://cdn.yummy.co.id/content-images/images/20210731/B6mbbnT8my7I95S8VOzmTgJFrDnQM0Ne-31363237373039383835d41d8cd98f00b204e9800998ecf8427e.jpg?x-oss-process=image/resize,w_388,h_388,m_fixed,x-oss-process=image/format,webp"
    },
    {
      "title": "Gulai banak",
      "price": 37000,
      "ingredients":
          "Cow brain, coconut milk, turmeric, garlic, shallots, lemongrass, kaffir lime leaves, salt,",
      "description": "gulai of cow brain",
      "imageUrl":
          "https://img.freepik.com/premium-photo/gulai-banak-gulai-otak-sapi-is-popular-dish-cow-brain-curry-from-padang-sumatera-barat_581937-5408.jpg?w=1800"
    },
    {
      "title": "Gulai sumsum",
      "price": 37000,
      "ingredients":
          "Cow bone marrow, coconut milk, turmeric, garlic, shallots, chilies, lemongrass,",
      "description": "gulai of cow bone marrow",
      "imageUrl":
          "https://assets.promediateknologi.id/crop/9x487:1379x1471/750x500/webp/photo/2023/07/09/gulai-sumsum-4142063430.jpg"
    },
    {
      "title": "Gulai gajeboh",
      "price": 36000,
      "ingredients":
          "Cow fat, coconut milk, turmeric, garlic, shallots, lemongrass, kaffir lime leaves, salt,",
      "description": "cow fat gulai",
      "imageUrl":
          "https://indonesiakaya.com/wp-content/uploads/2020/10/gulai_gajeboh_1290.jpg"
    },
    {
      "title": "Gulai limpo",
      "price": 36000,
      "ingredients":
          "Cow spleen, coconut milk, turmeric, garlic, shallots, lemongrass, kaffir lime leaves, salt,",
      "description": "gulai of cow spleen",
      "imageUrl":
          "https://upload.wikimedia.org/wikipedia/commons/f/fd/Gulai_Limpo.jpg"
    },
    {
      "title": "Gulai tunjang",
      "price": 36000,
      "ingredients":
          "Cow foot tendons, coconut milk, turmeric, garlic, chilies, lemongrass, salt,",
      "description": "gulai of cow foot tendons",
      "imageUrl":
          "https://cdn.idntimes.com/content-images/post/20200917/118813150-2710132395869504-6021290183484363500-n-b878035a8c04ac1c7f1d0d5871c10bfa_600x400.jpg"
    },
    {
      "title": "Baluik goreng",
      "price": 35000,
      "ingredients": "Small freshwater eels, turmeric, garlic, salt, oil,",
      "description": "crispy fried small freshwater eel",
      "imageUrl": "https://jadesta.kemenparekraf.go.id/imgpost/28607.jpg"
    },
    {
      "title": "Kalio Ayam",
      "price": 35000,
      "ingredients":
          "Chicken, Coconut milk, Cooking oil, Garlic (minced), Shallots (sliced), Turmeric, Ginger (sliced), Lemongrass, Red chilies (sliced), Salt, Sugar, Water",
      "description":
          "similar to rendang; while rendang is rather dry, kalio is watery and light-colored",
      "imageUrl":
          "https://asset.kompas.com/crops/mCb4rnN344JdAyqQs9i1IJWktRU=/0x379:667x823/750x500/data/photo/2021/05/11/609a2c750cdc5.jpg"
    },
    {
      "title": "Gulai ati",
      "price": 35000,
      "ingredients":
          "Cow liver, coconut milk, turmeric, chilies, shallots, garlic, lemongrass, salt,",
      "description": "gulai of cow liver",
      "imageUrl":
          "https://img-global.cpcdn.com/recipes/093bca8e79bc5ca4/1360x964cq70/gulai-hati-ampela-foto-resep-utama.webp"
    },
    {
      "title": "Paru goreng",
      "price": 35000,
      "ingredients": "Cow lung, turmeric, garlic, salt, oil,",
      "description": "fried cow lung",
      "imageUrl":
          "https://asset.kompas.com/crops/SExQheJk5IH2hd5zTXUZ5Qkx_Xk=/47x14:661x424/750x500/data/photo/2022/02/02/61fa7b69e014c.jpeg"
    },
    {
      "title": "Satay ayam",
      "price": 35000,
      "ingredients":
          "Chicken, peanut sauce, sweet soy sauce, garlic, shallots, skewers,",
      "description":
          "dish of seasoned, skewered and grilled chicken, served with a sauce",
      "imageUrl":
          "https://img-global.cpcdn.com/recipes/a6ca9f36b02b089b/680x482cq70/sate-ayam-khas-madura-foto-resep-utama.jpg"
    },
    {
      "title": "Soto",
      "price": 35000,
      "ingredients":
          "Meat, broth (spices like turmeric, garlic, ginger), vegetables,",
      "description":
          "traditional soup mainly composed of broth, meat and vegetables",
      "imageUrl":
          "https://giwang.sumselprov.go.id/api/uploads/kuliner/kuliner_168860841064729.jpg"
    },
    {
      "title": "Gulai jariang",
      "price": 34000,
      "ingredients":
          "Jengkol (stinky beans), coconut milk, turmeric, garlic, chilies, lemongrass, kaffir lime leaves, salt,",
      "description": "jengkol stinky bean gulai",
      "imageUrl":
          "https://bimamedia-gurusiana.ap-south-1.linodeobjects.com/63f3a0d84155cf94b757c01c3c8ba2f8/2021/01/31/l-kalio-jariangjpg20210131140742.jpeg"
    },
    {
      "title": "Gulai sayua",
      "price": 30000,
      "ingredients":
          "Vegetable, coconut milk, turmeric, chilies, shallots, garlic, lemongrass, kaffir lime leaves, salt, water,",
      "description":
          "curry dish with main ingredients vegetables such as cassava leaves and unripe jackfruit",
      "imageUrl":
          "https://akcdn.detik.net.id/community/media/visual/2023/01/01/resep-gulai-aneka-sayuran_43.jpeg?w=700&q=90"
    },
    {
      "title": "Gulai talua",
      "price": 30000,
      "ingredients":
          "Boiled eggs, coconut milk, turmeric, garlic, shallots, chilies, lemongrass,",
      "description": "boiled eggs gulai",
      "imageUrl": "https://i.ytimg.com/vi/AU1czt1_Cz8/mqdefault.jpg"
    },
    {
      "title": "Lele goreng",
      "price": 30000,
      "ingredients": "Catfish, turmeric, garlic, salt, oil,",
      "description": "fried catfish",
      "imageUrl":
          "https://kurio-img.kurioapps.com/22/09/26/ea665aec-bb3e-4232-9fa2-6b29197a5884.jpg"
    },
    {
      "title": "Pangek Masin",
      "price": 30000,
      "ingredients":
          "Fish (catfish or mackerel), tamarind, coconut milk, turmeric, garlic, shallots, red chilies, salt.",
      "description":
          "A sour and savory fish dish cooked with tamarind and coconut milk.",
      "imageUrl":
          "https://cdn.yummy.co.id/content-images/images/20230221/eTwNZZyU6qb2RHYAnRLq8XuQz7Ozo1XO-31363736393136393637d41d8cd98f00b204e9800998ecf8427e.jpg?x-oss-process=image/resize,w_388,h_388,m_fixed,x-oss-process=image/format,webp"
    },
    {
      "title": "Palai",
      "price": 28000,
      "ingredients":
          "Fish, grated coconut, turmeric, garlic, shallots, banana leaves,",
      "description": "Minangkabau variants of pepes",
      "imageUrl":
          "https://img-global.cpcdn.com/recipes/f548101c11ec0f35/680x482cq70/resep-palai-bada-khas-minang-foto-resep-utama.jpg"
    },
    {
      "title": "Gulai paku",
      "price": 25000,
      "ingredients":
          "Paku, coconut milk, turmeric, chilies, shallots, garlic, lemongrass, kaffir lime leaves, salt, water,",
      "description": "fern gulai",
      "imageUrl":
          "https://img-global.cpcdn.com/recipes/1d34ae7f990bd073/680x482cq70/gulai-pakisgulai-paku-foto-resep-utama.jpg"
    },
    {
      "title": "Lemang",
      "price": 25000,
      "ingredients": "Sticky rice, coconut milk, pandan leaves, bamboo tubes,",
      "description":
          "a mixture of sticky rice with coconut milk and pandan in thin bamboo (talang)",
      "imageUrl":
          "https://cdn.rri.co.id/berita/Bukittinggi/o/1721880214333-1/70ekx446dewy3pt.jpeg"
    },
    {
      "title": "Es tebak",
      "price": 25000,
      "ingredients": "Avocado, jackfruit, tebak, condensed milk, ice,",
      "description":
          "mixed of avocado, jack fruit, tebak, shredded and iced with sweet thick milk",
      "imageUrl":
          "https://cdn.idntimes.com/content-images/post/20190507/es-campur-bandung-cirebon-483a1ad02721c4a36f42b0cd7f1c21cd_600x400.jpg"
    },
    {
      "title": "Sambal Teri",
      "price": 25000,
      "ingredients":
          "Dried anchovies, red chilies, garlic, shallots, lime juice, salt, sugar.",
      "description":
          "Spicy sambal with crispy anchovies, often served as a condiment or side dish.",
      "imageUrl":
          "https://img-global.cpcdn.com/recipes/51faef764a15a51d/680x482cq70/telor-teri-samba-lado-uok-khas-padang-foto-resep-utama.jpg"
    },
    {
      "title": "Sambalado",
      "price": 20000,
      "ingredients": "Chilies, shallots, garlic, tomatoes, salt, sugar, oil,",
      "description":
          "chili paste similar to sambal with large sliced chili pepper, usually stir fried together with main ingredients",
      "imageUrl":
          "https://static.promediateknologi.id/crop/0x0:0x0/0x0/webp/photo/p2/131/2023/12/12/sambal-bawang-3278993492.jpg"
    },
    {
      "title": "Daun ubi tumbuk",
      "price": 20000,
      "ingredients": "Chilies, shallots, garlic, tomatoes, salt, sugar, oil,",
      "description": "cassava leaves in coconut milk",
      "imageUrl":
          "https://img.kurio.network/Hz0pVo7DU5_L3YzGYNqVa-sPyrE=/1200x1200/filters:quality(80)/https://kurio-img.kurioapps.com/21/07/16/5334bdb0-62d0-4718-a787-1128cf5c9e09.jpe"
    },
    {
      "title": "Sambal lado tanak",
      "price": 20000,
      "ingredients":
          "Green chilies, coconut milk, anchovies, stinky beans, garlic, shallots,",
      "description":
          "sambal with coconut milk, anchovies, green stinky bean and spices",
      "imageUrl":
          "https://img-global.cpcdn.com/recipes/197c93a33e56af43/680x482cq70/sambalado-tanak-khas-minang-foto-resep-utama.jpg"
    },
    {
      "title": "Talua balado",
      "price": 20000,
      "ingredients": "Eggs, red chilies, garlic, shallots, tomatoes, salt,",
      "description": "egg in chili",
      "imageUrl":
          "https://i.ytimg.com/vi/YuqJFbyruTU/hq720.jpg?sqp=-oaymwEhCK4FEIIDSFryq4qpAxMIARUAAAAAGAElAADIQj0AgKJD&rs=AOn4CLAv2tCykPlsWX1Y107QfQYV2Q63DQ"
    },
    {
      "title": "Terong balado",
      "price": 20000,
      "ingredients": "Eggplant, red chilies, garlic, shallots, tomatoes, salt,",
      "description": "eggplant in chili",
      "imageUrl":
          "https://asset.kompas.com/crops/BrFLVwC5LlT6v83pNAG8WGtFwHo=/210x196:795x585/750x500/data/photo/2022/09/27/63329904a916d.jpg"
    },
    {
      "title": "Es ampiang dadiah",
      "price": 20000,
      "ingredients":
          "Buffalo milk (fermented), shaved ice, palm sugar, rice Flour,",
      "description": "Minang yogurt served with shaved ice and palm sugar",
      "imageUrl":
          "https://cdn.idntimes.com/content-images/community/2021/01/119657646-3525199824196675-1505695841977428848-n-0b2e3fe55c98e8dc089991ca6127b017-593497de0889f8a23280afeda9c8d205_600x400.jpg"
    },
    {
      "title": "Cindua",
      "price": 20000,
      "ingredients": "Rice Flour jelly, lupis, durian, palm sugar, shaved ice,",
      "description":
          "sweet dessert that contains droplets of green rice flour jelly, mixed of lupis, durian, ampiang, and doused with palm sugar",
      "imageUrl":
          "https://i0.wp.com/langgam.id/wp-content/uploads/2021/05/InShot_20210508_143837953_compress98.jpg?fit=1440%2C960&ssl=1"
    },
    {
      "title": "Es campur",
      "price": 20000,
      "ingredients":
          "Mixed fruits (coconut, jackfruit), tapioca pearls, shaved ice, syrup, condensed milk,",
      "description":
          "cold and sweet dessert concoction of fruit cocktails, coconut, tapioca pearls, grass jellies, etc, and served in shaved ice, syrup and condensed milk",
      "imageUrl":
          "https://cdn0-production-images-kly.akamaized.net/qSxIa6DhH4tSfPQdtDo-0vS-6R8=/0x2180:3999x4434/1200x675/filters:quality(75):strip_icc():format(jpeg)/kly-media-production/medias/3981507/original/061819300_1648783740-shutterstock_1969134643.jpg"
    },
    {
      "title": "Es cendol",
      "price": 20000,
      "ingredients":
          "Cendol, Coconut milk, Palm sugar, Water, Ice cubes, Pandan leaves (optional)",
      "description":
          "iced dessert made from rice flour jelly, coconut milk, and palm sugar syrup",
      "imageUrl":
          "https://i.gojekapi.com/darkroom/gofood-indonesia/v2/images/uploads/8ce14a1c-5598-4ead-aeeb-f9112beb96c1_Go-Biz_20230112_223311.jpeg"
    },
    {
      "title": "Bubur kampiun",
      "price": 18000,
      "ingredients":
          "Rice Flour, coconut milk, palm sugar, pandan leaves, jackfruit, mung beans, sweet potato,",
      "description": "porridge made from rice flour mixed with brown sugar",
      "imageUrl":
          "https://www.masakapahariini.com/wp-content/uploads/2023/08/bubur-kampiun.jpeg"
    },
    {
      "title": "Petai goreng",
      "price": 18000,
      "ingredients": "Stinky beans (Parkia speciosa), oil,",
      "description": "fried green stinky bean (Parkia speciosa)",
      "imageUrl":
          "https://images.tokopedia.net/img/cache/700/VqbcmM/2021/2/11/098d34be-e600-4635-b73b-13c358ab6879.jpg"
    },
    {
      "title": "Roti jala",
      "price": 18000,
      "ingredients": "Flour, water, eggs, coconut milk, pandan leaves,",
      "description":
          "the name is derived from the Malay word roti (bread) and jala (net) A special ladle with a five-hole perforation used to make the bread looks like a fish net, It is usually eaten as an accompaniment to a curried dish, or served as a sweet with serawa, Serawa is made from a mixture of boiled coconut milk, brown sugar and pandan leaves",
      "imageUrl":
          "https://www.tokomesin.com/wp-content/uploads/2017/10/roti-jala-kari-ayam.jpg"
    },
    {
      "title": "Keripik balado",
      "price": 18000,
      "ingredients": "Cassava, red chili paste, garlic, shallots, sugar, oil,",
      "description": "cassava cracker coated with hot and sweet chilli paste",
      "imageUrl":
          "https://media.tampang.com/tm_images/article/202406/desain-tanpaw4x7xw6e0svoqte3.jpg"
    },
    {
      "title": "Kerupuk jangek",
      "price": 18000,
      "ingredients": "Cow skin, salt, oil,",
      "description": "cow's skin krupuk",
      "imageUrl":
          "https://upload.wikimedia.org/wikipedia/commons/b/be/Karupuak_jangek_2.jpg"
    },
    {
      "title": "Dadiah",
      "price": 18000,
      "ingredients": "Fermented buffalo milk,",
      "description": "fermented buffalo milk akin to yogurt",
      "imageUrl":
          "https://indonesiakaya.com/wp-content/uploads/2020/10/5__IMG_3410_Citarasanya_yang_unik_membuat_dadiah_tergolong_kuliner_dengan_peminat_yang_spesifik.jpg"
    },
    {
      "title": "Jariang lado tomat",
      "price": 18000,
      "ingredients":
          "Jengkol (dogfruit), tomato, chili peppers, shallots, garlic, salt, sugar, oil",
      "description":
          "spicy dish of jengkol beans simmered in a tangy tomato sauce.",
      "imageUrl":
          "https://upload.wikimedia.org/wikipedia/commons/thumb/3/3e/Goreng_jariang_balado.jpg/250px-Goreng_jariang_balado.jpg"
    },
    {
      "title": "Roti tisu",
      "price": 16000,
      "ingredients": "Flour, water, oil or ghee,",
      "description": "thinner version of the traditional roti canai",
      "imageUrl":
          "https://cdn.tasteatlas.com/images/dishes/1414b9c07a7d45f293798254e59f2b5b.jpg?w=600"
    },
    {
      "title": "Ayam kurma",
      "price": 16000,
      "ingredients":
          "Chicken, kurma (dates), onion, garlic, ginger, lemongrass, turmeric, coriander, chili peppers, oil",
      "description":
          "chicken slowly cooked in a rich and aromatic coconut and kurma (date) sauce.",
      "imageUrl":
          "https://img-global.cpcdn.com/recipes/86fd40ff2496de0f/1360x964cq70/gulai-korma-khas-minang-versi-ayam-foto-resep-utama.webp"
    },
    {
      "title": "Lado ijo",
      "price": 15000,
      "ingredients":
          "Green chilies, Garlic, Shallots, Salt, Lime juice or tamarind, Sugar (optional), Water",
      "description":
          "a variant of green chili sambal with fried anchovies or shrimp",
      "imageUrl":
          "https://asset.kompas.com/crops/i8XPicsLEUrsaUTQpb62FK7kU_g=/0x0:1000x667/750x500/data/photo/2020/08/24/5f431f6307111.jpg"
    },
    {
      "title": "Pergedel jaguang",
      "price": 15000,
      "ingredients": "Corn, Flour, eggs, garlic, shallots, salt, oil,",
      "description": "corn fritters",
      "imageUrl":
          "https://asset.kompas.com/crops/qiVD1zYxC5A49SsCaE_2hrUR7g0=/65x0:907x561/750x500/data/photo/2020/11/02/5f9f812b3e9fa.jpg"
    },
    {
      "title": "Roti canai",
      "price": 15000,
      "ingredients": "Flour, water, ghee or oil, eggs,",
      "description":
          "a thin unleavened bread with a flaky crust, fried on a skillet with oil and served with condiments or curry",
      "imageUrl":
          "https://images.tokopedia.net/img/cache/500-square/VqbcmM/2023/9/11/b33d4570-ca3f-47bd-8686-8b9c409946ab.jpg"
    },
    {
      "title": "Galamai",
      "price": 15000,
      "ingredients": "Rice Flour, palm sugar, coconut milk,",
      "description":
          "sweets made of rice flour, palm sugar and coconut milk, This snack similar to dodol",
      "imageUrl":
          "https://images.tokopedia.net/img/cache/500-square/VqbcmM/2023/9/11/b33d4570-ca3f-47bd-8686-8b9c409946ab.jpg"
    },
    {
      "title": "Keripik sanjai",
      "price": 15000,
      "ingredients": "Cassava, salt, oil,",
      "description": "sliced cassava chips",
      "imageUrl":
          "https://asset-a.grid.id/crop/0x0:0x0/x/photo/2020/08/18/910071120.jpg"
    },
    {
      "title": "Peyek udang",
      "price": 15000,
      "ingredients": "Flour, water, shrimp, garlic, coriander, salt, oil,",
      "description": "shrimp rempeyek",
      "imageUrl":
          "https://asset-a.grid.id/crop/0x0:0x0/x/photo/2020/08/18/910071120.jpg"
    },
    {
      "title": "Teh talua",
      "price": 15000,
      "ingredients": "Tea, eggs, sugar,",
      "description": "mixture of tea and egg",
      "imageUrl":
          "https://www.tehsariwangi.com/uploads/ar/article/370/3c6aeb79728eac58b4e6828fff670d99.jpg"
    },
    {
      "title": "Pinyaram",
      "price": 14000,
      "ingredients": "Rice Flour, palm sugar, coconut milk,",
      "description":
          "traditional cake made from mixture of white sugar or palm sugar, white rice flour or black rice, and coconut milk",
      "imageUrl":
          "https://cdn.rri.co.id/berita/Bukittinggi/o/1716043146226-l-screenshot2020112205275120201122052841-1814139726/ylypodc2l1z9vsf.png"
    },
    {
      "title": "Serabi",
      "price": 14000,
      "ingredients": "Rice Flour, coconut milk, pandan leaves,",
      "description":
          "traditional pancake that is made from rice flour with coconut milk or shredded coconut",
      "imageUrl": "https://i.ytimg.com/vi/DkgrqXLYgso/sddefault.jpg"
    },
    {
      "title": "Lupis",
      "price": 13000,
      "ingredients": "Glutinous rice, banana leaves, coconut, palm sugar,",
      "description":
          "sweet cake made of glutinous rice, banana leaves, coconut, and palm sugar sauce",
      "imageUrl":
          "https://serikatnews.com/wp-content/uploads/2023/09/cook-pad7.jpg"
    },
    {
      "title": "Ketupat",
      "price": 12000,
      "ingredients": "Rice, palm leaves, water,",
      "description":
          "rice dumpling made from rice packed inside a diamond-shaped container of woven palm leaf pouch",
      "imageUrl":
          "https://assets.tmecosys.com/image/upload/t_web767x639/img/recipe/ras/Assets/ef6b566965d72c09f082974440a9b1d5/Derivates/b94f1d6a161d294c5ddff7afe44102ee38791650.jpg"
    },
    {
      "title": "Sarikayo",
      "price": 12000,
      "ingredients": "Coconut milk, eggs, palm sugar, pandan leaves,",
      "description": "jam made from a base of coconut milk, eggs and sugar",
      "imageUrl":
          "https://ik.imagekit.io/goodid/gnfi/uploads/articles/large-img-20231106-093401-522787279d1f999ca516090844961d37.jpg"
    },
    {
      "title": "Kacang tojin",
      "price": 12000,
      "ingredients":
          "Raw peanuts, Coconut milk, Cooking oil, Salt, Sugar, Tamarind paste, Water, Chili powder (optional)",
      "description": "fried peanuts seasoned with salt and garlic",
      "imageUrl":
          "https://img.lazcdn.com/g/p/c1d18da429c2dce178f52d5b0eb93856.jpg_960x960q80.jpg_.webp"
    },
    {
      "title": "Kue putu",
      "price": 12000,
      "ingredients": "Rice Flour, pandan leaves, coconut, palm sugar,",
      "description":
          "traditional cylindrical-shaped and green-colored steamed cake",
      "imageUrl":
          "https://cdn.rri.co.id/berita/Bukittinggi/o/1716266719523-1705038382_65a0d22ebe1a1_KraEi35RrXloPGaZ2y2Z/de4ooj24jn7p32r.webp"
    },
    {
      "title": "Peyek",
      "price": 12000,
      "ingredients": "Flour, water, peanuts, garlic, coriander, salt, oil,",
      "description": "deep-fried savoury crackers",
      "imageUrl":
          "https://awsimages.detik.net.id/community/media/visual/2021/11/09/peyek-kacang_169.jpeg?w=600&q=90"
    },
    {
      "title": "Lopek sarikayo",
      "price": 12000,
      "ingredients": "Glutinous rice, coconut milk, palm sugar, pandan leaves,",
      "description": "sticky and chewy snack made from glutinous rice",
      "imageUrl":
          "https://cdn.yummy.co.id/content-images/images/20210629/OzVenSPIA2FfScBYrXaBjJKx4C8Ehj9o-31363234393435353239d41d8cd98f00b204e9800998ecf8427e.jpg?x-oss-process=image/resize,w_388,h_388,m_fixed,x-oss-process=image/format,webp"
    },
    {
      "title": "Wajik",
      "price": 12000,
      "ingredients": "Glutinous rice, palm sugar, coconut milk,",
      "description": "diamond-shaped compressed sweet glutinous rice cake",
      "imageUrl":
          "https://4.bp.blogspot.com/-a9s22xSH-hw/VYpGWKJBcrI/AAAAAAAAA2g/FKlZ7D49Vig/s640/Wajik%2BKetan%2BGula%2BMerah.jpg"
    },
    {
      "title": "Teh tarik",
      "price": 12000,
      "ingredients": "Tea, condensed milk,",
      "description": "hot milk tea beverage",
      "imageUrl":
          "https://asset.kompas.com/crops/-Rw6dVjBqhaT6u4cmDIIxbHvaG4=/120x80:1000x667/750x500/data/photo/2023/10/18/652fcf5eb1b28.jpg"
    },
    {
      "title": "Tapai",
      "price": 10000,
      "ingredients": "Sticky rice, yeast, banana leaves,",
      "description": "fermented sticky rice",
      "imageUrl":
          "https://cdn.idntimes.com/content-images/community/2019/11/asf-1b26f6a93ed3d0731810eeec68f7bc8b.jpg"
    },
  ];

  final List<Map<String, dynamic>> allRestaurant = [
    {
      "title": "Taman Surya",
      "address": "Jl. Tamansiswa No. 15",
      "district": "Padang Utara",
      "imageUrl":
          "https://lh3.googleusercontent.com/p/AF1QipMucy2GYqlxcQZpn6g9OzG8CXFFHCZYpduAxKE2=s1360-w1360-h1020"
    },
    {
      "title": "Kubang Hayuda",
      "address": "Jl. Prof. M. Yamin SH No. 138B, Padang",
      "district": "Padang Barat",
      "imageUrl":
          "https://lh3.googleusercontent.com/p/AF1QipPE1fJpyuCWE2eMPbYKPL5zD-eTKPbvM_MJ6bmD=s680-w680-h510"
    },
    {
      "title": "VII Koto Talago",
      "address": "Jl. Jhoni Anwar No.Kelurahan No.17, Padang",
      "district": "Padang Utara",
      "imageUrl":
          "https://lh3.googleusercontent.com/p/AF1QipMfCv5oU_RRNSg_BgK9lA9FLaMSABN1CUDTAO0S=s680-w680-h510"
    },
    {
      "title": "Pagi Sore",
      "address": "Jl. Pondok No. 143, Padang",
      "district": "Padang Barat",
      "imageUrl":
          "https://lh3.googleusercontent.com/p/AF1QipPnRTwAUA2u2RmeR8LBzhCnJypZgAmLF7tC2v3g=s1360-w1360-h1020"
    },
    {
      "title": "Sing A Song",
      "address": "Jl. Perintis Kemerdekaan No. 4C, Padang",
      "district": "Padang Timur",
      "imageUrl":
          "https://lh5.googleusercontent.com/p/AF1QipMyIWWaWJjrU-Kzv0PSXfHT59mmGQlZ5kwmRtKT=w408-h544-k-no"
    },
  ];

  late final List<String> allTitles;
  late final List<String> allImageUrls;

  @override
  void initState() {
    super.initState();
    allTitles = allFood.map((food) => food['title'].toString()).toList();
    allImageUrls = allFood.map((food) => food['imageUrl'].toString()).toList();
  }

  void onItemTapped(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  Widget _getScreen(int index) {
    if (index == 0) {
      return HomeScreen(
        allFood: allFood,
        allRestaurant: allRestaurant,
      );
    } else if (index == 1) {
      return RestaurantScreen(
        allRestaurant: allRestaurant,
        allFood: allFood,
      );
    } else if (index == 2) {
      return ForumScreen(allFood: allFood);
    } else {
      return const Center(child: Text('Unknown screen'));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: currentScreen is HomeScreen // Check if the body is HomeScreen
      //     ? AppBar(
      //         title: RichText(
      //           text: const TextSpan(
      //             style: TextStyle(
      //               fontSize: 20,
      //               fontWeight: FontWeight.bold,
      //             ),
      //             children: [
      //               TextSpan(
      //                 text: 'Min',
      //                 style: TextStyle(
      //                     color: Color(0xffbb0000), fontSize: 25), // Red color
      //               ),
      //               TextSpan(
      //                 text: 'eat',
      //                 style: TextStyle(
      //                     color: Color(0xffffd700), fontSize: 25), // Gold color
      //               ),
      //             ],
      //           ),
      //         ),
      //         // leading: Image.asset('assets/images/in8.png'), // Image on the left side
      //       )
      //     : null, // No AppBar for other screens
      bottomNavigationBar: ClipRRect(
        borderRadius: const BorderRadius.vertical(top: Radius.circular(30)),
        child: BottomNavigationBar(
          currentIndex: selectedIndex, // Make highlights for the slected page
          onTap: onItemTapped,
          backgroundColor: Theme.of(context).bottomAppBarTheme.color,
          showSelectedLabels: false,
          showUnselectedLabels: false,
          elevation: 3,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.home),
              label: "Home",
            ),
            BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.graph_square_fill),
              label: "Stats",
            ),
            BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.search),
              label: "Search",
            ),
          ],
        ),
      ),
      body: _getScreen(selectedIndex),
    );
  }
}
