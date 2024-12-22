import 'package:flutter/material.dart';
import 'package:mineat/screens/district_all_screen.dart';
import 'package:mineat/screens/district_details_screen.dart';
import 'package:mineat/screens/food_details_screen.dart';
import 'package:mineat/screens/login_screen.dart';
import 'package:mineat/screens/profile_screen.dart';
import 'package:mineat/screens/restaurant_all_screen.dart';
import 'package:mineat/screens/restaurant_details_screen.dart';
import 'package:mineat/widgets/top_picks_widget.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:mineat/api/restaurant_service.dart';
import 'package:mineat/api/location_service.dart';

class RestaurantScreen extends StatefulWidget {
  final String username;
  final bool isLoggedIn;
  final List<Map<String, dynamic>> allRestaurant;
  final List<Map<String, dynamic>> allFood;
  const RestaurantScreen({
    required this.username,
    required this.allRestaurant,
    required this.allFood,
    required this.isLoggedIn,
    super.key,
  });

  @override
  State<RestaurantScreen> createState() => _RestaurantScreenState();
}

class _RestaurantScreenState extends State<RestaurantScreen> {
  final List<Map<String, dynamic>> stackData = [
    {
      "title": "Rumah Makan Taman Surya",
      "address": "Jl. Tamansiswa No. 15",
      "district": "Padang Utara",
      "imageUrl":
          "https://lh3.googleusercontent.com/p/AF1QipMucy2GYqlxcQZpn6g9OzG8CXFFHCZYpduAxKE2=s1360-w1360-h1020",
      "foodsInTheRestaurant": [
        {
          "id": "0215db5f-847d-4875-ba7c-6d8136a3c532",
          "title": "Rajungan goreng",
          "price": 70000,
          "description": "crispy fried crab",
          "ingredients": "salt, oil, Crab, ",
          "imageUrl":
              "https://cdn0-production-images-kly.akamaized.net/b4c9FCwttCcvLjdJ7sned_aS06c%3D/1x40%3A1000x603/1200x675/filters%3Aquality(75)%3Astrip_icc()%3Aformat(jpeg)/kly-media-production/medias/3570968/original/013224500_1631594241-shutterstock_1796323171.jpg"
        },
        {
          "id": "02173c34-d3b4-4f91-b762-8436d510bb63",
          "title": "Gulai paku",
          "price": 25000,
          "description": "fern gulai",
          "ingredients":
              "coconut, shallots, chilies, turmeric, water, chili, garlic, salt, coconut milk, lime, kaffir lime leaves, Paku, lime leaves, lemongrass, ",
          "imageUrl":
              "https://img-global.cpcdn.com/recipes/1d34ae7f990bd073/680x482cq70/gulai-pakisgulai-paku-foto-resep-utama.jpg"
        },
        {
          "id": "02274a61-8fc1-4e74-9045-4480764c9da7",
          "title": "Kerupuk jangek",
          "price": 18000,
          "description": "cow's skin krupuk",
          "ingredients": "salt, Cow skin, oil, ",
          "imageUrl":
              "https://upload.wikimedia.org/wikipedia/commons/b/be/Karupuak_jangek_2.jpg"
        },
        {
          "id": "2a858213-b635-4253-bc19-ba14f78578cd",
          "title": "Gulai ati",
          "price": 35000,
          "description": "gulai of cow liver",
          "ingredients":
              "coconut, shallots, chilies, turmeric, chili, garlic, Cow liver, salt, coconut milk, lemongrass, ",
          "imageUrl":
              "https://img-global.cpcdn.com/recipes/093bca8e79bc5ca4/1360x964cq70/gulai-hati-ampela-foto-resep-utama.webp"
        },
        {
          "id": "3afb4d62-29f8-43c3-8dd9-509075e88e2c",
          "title": "Sate padang",
          "price": 40000,
          "description":
              "Padang-style of satay, skewered barbecued meat with thick yellow sauce",
          "ingredients":
              "thick sauce (rice Flour-based), Meat, shallots, Flour, turmeric, garlic, lemongrass, ",
          "imageUrl": "https://i.ytimg.com/vi/hmWh0thXUbQ/maxresdefault.jpg"
        },
        {
          "id": "45ecc2cc-d220-4049-88c2-5e37109e924f",
          "title": "Sambal lado tanak",
          "price": 20000,
          "description":
              "sambal with coconut milk, anchovies, green stinky bean and spices",
          "ingredients":
              "coconut, shallots, Green chilies, chilies, chili, garlic, anchovies, coconut milk, stinky beans, ",
          "imageUrl":
              "https://img-global.cpcdn.com/recipes/197c93a33e56af43/680x482cq70/sambalado-tanak-khas-minang-foto-resep-utama.jpg"
        },
        {
          "id": "46c93e82-181d-4371-8e49-9839668dd863",
          "title": "Ikan bilih",
          "price": 38000,
          "description":
              "fried small freshwater fish of the genus Mystacoleucus",
          "ingredients": "salt, Small freshwater fish, oil, ",
          "imageUrl":
              "https://packagepadang.com/wp-content/uploads/2023/05/ikan-bilih.jpg"
        },
        {
          "id": "4d9184ef-97c3-44c9-9e54-ee6859680828",
          "title": "Gulai sayua",
          "price": 30000,
          "description":
              "curry dish with main ingredients vegetables such as cassava leaves and unripe jackfruit",
          "ingredients":
              "coconut, shallots, chilies, turmeric, water, chili, garlic, salt, coconut milk, lime, oil, Vegetable, kaffir lime leaves, lime leaves, lemongrass, ",
          "imageUrl":
              "https://akcdn.detik.net.id/community/media/visual/2023/01/01/resep-gulai-aneka-sayuran_43.jpeg%3Fw%3D700%26q%3D90"
        },
        {
          "id": "9dd2d67d-58ec-4122-83ca-efce2e04cc31",
          "title": "Dadiah",
          "price": 18000,
          "description": "fermented buffalo milk akin to yogurt",
          "ingredients": "Fermented buffalo milk, ",
          "imageUrl":
              "https://indonesiakaya.com/wp-content/uploads/2020/10/5__IMG_3410_Citarasanya_yang_unik_membuat_dadiah_tergolong_kuliner_dengan_peminat_yang_spesifik.jpg"
        },
        {
          "id": "a2e5ca53-04a3-49e3-a623-4e6ee5ec46c9",
          "title": "Satay ayam",
          "price": 35000,
          "description":
              "dish of seasoned, skewered and grilled chicken, served with a sauce",
          "ingredients":
              "shallots, garlic, sweet soy sauce, Chicken, skewers, peanut sauce, ",
          "imageUrl":
              "https://img-global.cpcdn.com/recipes/a6ca9f36b02b089b/680x482cq70/sate-ayam-khas-madura-foto-resep-utama.jpg"
        },
        {
          "id": "a6d45a69-80c9-4c29-970d-6576322ab563",
          "title": "Gulai kepala ikan",
          "price": 48000,
          "description": "fish head gulai",
          "ingredients":
              "coconut, shallots, turmeric, garlic, salt, coconut milk, lime, kaffir lime leaves, Fish head, lime leaves, Fish, lemongrass, ",
          "imageUrl":
              "https://cdn.idntimes.com/content-images/community/2021/10/fromandroid-f2a4fb48c1f2c9948243bd190a3c71c6.jpg"
        },
        {
          "id": "ab01df10-2430-4eaa-80a6-7590b7742a42",
          "title": "Lele goreng",
          "price": 30000,
          "description": "fried catfish",
          "ingredients": "turmeric, Catfish, garlic, salt, oil, ",
          "imageUrl":
              "https://kurio-img.kurioapps.com/22/09/26/ea665aec-bb3e-4232-9fa2-6b29197a5884.jpg"
        },
        {
          "id": "b2146ad8-f45a-426c-9828-16a9ea5ccf1e",
          "title": "Gulai daging",
          "price": 40000,
          "description":
              "curry dish with main ingredients beef and unripe jackfruit",
          "ingredients":
              "coconut, Meat, shallots, chilies, turmeric, water, chili, garlic, salt, coconut milk, lime, kaffir lime leaves, lime leaves, lemongrass, ",
          "imageUrl":
              "https://assets.pikiran-rakyat.com/crop/0x0%3A0x0/750x500/photo/2021/11/25/217085998.jpeg"
        },
        {
          "id": "b820cb02-ce8d-4092-a599-f39d6dd9d5cd",
          "title": "Gulai cancang",
          "price": 40000,
          "description": "gulai of meats and cow internal organs",
          "ingredients":
              "coconut, Meat, chilies, turmeric, chili, garlic, salt, coconut milk, Meat and internal organs, lemongrass, ",
          "imageUrl":
              "https://nnc-media.netralnews.com/IMG-Netral-News-Admin-35-I2FNWD19UL.jpg"
        },
        {
          "id": "c80f5b33-16a8-4ead-8301-298f764a5187",
          "title": "Gulai babek",
          "price": 37000,
          "description":
              "gulai babat, or gulai paruik kabau, gulai of cow tripes",
          "ingredients":
              "coconut, shallots, chilies, turmeric, chili, garlic, salt, coconut milk, Cow tripe, lemongrass, ",
          "imageUrl":
              "https://cdn.yummy.co.id/content-images/images/20210731/B6mbbnT8my7I95S8VOzmTgJFrDnQM0Ne-31363237373039383835d41d8cd98f00b204e9800998ecf8427e.jpg%3Fx-oss-process%3Dimage/resize%2Cw_388%2Ch_388%2Cm_fixed%2Cx-oss-process%3Dimage/format%2Cwebp"
        },
        {
          "id": "dbcee8e3-0192-4372-9191-a9d6ec4e4e2b",
          "title": "Ayam Gulai Nangka",
          "price": 50000,
          "description":
              "Chicken simmered in a spicy coconut curry with young jackfruit.",
          "ingredients":
              "coconut, chilies, turmeric, bay leaves., bay leaves, jackfruit, chili, coconut milk, Chicken, red chilies, young jackfruit, galangal, lemongrass, ",
          "imageUrl":
              "https://static.promediateknologi.id/crop/0x0%3A0x0/750x500/webp/photo/p1/1067/2024/05/21/maxresdefault-8-1983884964.jpg"
        },
        {
          "id": "ddbf80f4-772b-45d5-9b18-6ffcd400dd4f",
          "title": "Es ampiang dadiah",
          "price": 20000,
          "description": "Minang yogurt served with shaved ice and palm sugar",
          "ingredients":
              "ice, rice Flour, shaved ice, Flour, palm sugar, sugar, Buffalo milk (fermented), ",
          "imageUrl":
              "https://cdn.idntimes.com/content-images/community/2021/01/119657646-3525199824196675-1505695841977428848-n-0b2e3fe55c98e8dc089991ca6127b017-593497de0889f8a23280afeda9c8d205_600x400.jpg"
        },
        {
          "id": "ec0d7ab8-4ba5-4c8d-927d-38981e693d96",
          "title": "Pergedel jaguang",
          "price": 15000,
          "description": "corn fritters",
          "ingredients": "shallots, Flour, garlic, salt, oil, eggs, Corn, ",
          "imageUrl":
              "https://asset.kompas.com/crops/qiVD1zYxC5A49SsCaE_2hrUR7g0%3D/65x0%3A907x561/750x500/data/photo/2020/11/02/5f9f812b3e9fa.jpg"
        },
        {
          "id": "efab575f-9ca3-4665-83b3-7c639ddf10cf",
          "title": "Kue putu",
          "price": 12000,
          "description":
              "traditional cylindrical-shaped and green-colored steamed cake",
          "ingredients":
              "coconut, Rice Flour, Flour, palm sugar, sugar, Rice, pandan leaves, ",
          "imageUrl":
              "https://cdn.rri.co.id/berita/Bukittinggi/o/1716266719523-1705038382_65a0d22ebe1a1_KraEi35RrXloPGaZ2y2Z/de4ooj24jn7p32r.webp"
        },
        {
          "id": "f5b8aa37-85fa-4594-818a-b76e06413cac",
          "title": "Petai goreng",
          "price": 18000,
          "description": "fried green stinky bean (Parkia speciosa)",
          "ingredients": "Stinky beans (Parkia speciosa), oil, ",
          "imageUrl":
              "https://images.tokopedia.net/img/cache/700/VqbcmM/2021/2/11/098d34be-e600-4635-b73b-13c358ab6879.jpg"
        }
      ]
    },
    {
      "title": "Restoran Kubang Hayuda",
      "address": "Jl. Prof. M. Yamin SH No. 138B, Padang",
      "district": "Padang Barat",
      "imageUrl":
          "https://lh3.googleusercontent.com/p/AF1QipPE1fJpyuCWE2eMPbYKPL5zD-eTKPbvM_MJ6bmD=s680-w680-h510",
      "foodsInTheRestaurant": [
        {
          "id": "02173c34-d3b4-4f91-b762-8436d510bb63",
          "title": "Gulai paku",
          "price": 25000,
          "description": "fern gulai",
          "ingredients":
              "coconut, shallots, chilies, turmeric, water, chili, garlic, salt, coconut milk, lime, kaffir lime leaves, Paku, lime leaves, lemongrass, ",
          "imageUrl":
              "https://img-global.cpcdn.com/recipes/1d34ae7f990bd073/680x482cq70/gulai-pakisgulai-paku-foto-resep-utama.jpg"
        },
        {
          "id": "0aa137f9-3f93-44d1-b1bb-4a5d3f0d42a3",
          "title": "Kalio Ayam",
          "price": 35000,
          "description":
              "similar to rendang; while rendang is rather dry, kalio is watery and light-colored",
          "ingredients":
              "Shallots, Turmeric, Coconut milk, chilies, Cooking oil, chili, Ginger (sliced), Garlic, Lemongrass, Sugar, Water, oil, Shallots (sliced), Chicken, Salt, Garlic (minced), Red chilies (sliced), ",
          "imageUrl":
              "https://asset.kompas.com/crops/mCb4rnN344JdAyqQs9i1IJWktRU%3D/0x379%3A667x823/750x500/data/photo/2021/05/11/609a2c750cdc5.jpg"
        },
        {
          "id": "48ff3e73-d767-4173-bbe8-44ec2b24aa8c",
          "title": "Es campur",
          "price": 20000,
          "description":
              "cold and sweet dessert concoction of fruit cocktails, coconut, tapioca pearls, grass jellies, etc, and served in shaved ice, syrup and condensed milk",
          "ingredients":
              "ice, shaved ice, jackfruit, condensed milk, Mixed fruits (coconut, syrup, tapioca pearls, jackfruit), ",
          "imageUrl":
              "https://cdn0-production-images-kly.akamaized.net/qSxIa6DhH4tSfPQdtDo-0vS-6R8%3D/0x2180%3A3999x4434/1200x675/filters%3Aquality(75)%3Astrip_icc()%3Aformat(jpeg)/kly-media-production/medias/3981507/original/061819300_1648783740-shutterstock_1969134643.jpg"
        },
        {
          "id": "6d0a88e5-8afa-4eb3-b4de-c3cc9b4ce0ab",
          "title": "Sambalado",
          "price": 20000,
          "description":
              "chili paste similar to sambal with large sliced chili pepper, usually stir fried together with main ingredients",
          "ingredients":
              "shallots, tomato, sugar, garlic, tomatoes, salt, oil, Chilies, ",
          "imageUrl":
              "https://static.promediateknologi.id/crop/0x0%3A0x0/0x0/webp/photo/p2/131/2023/12/12/sambal-bawang-3278993492.jpg"
        },
        {
          "id": "9e949d0b-f83e-4512-8ce0-bf62ba5fee88",
          "title": "Ayam kurma",
          "price": 16000,
          "description":
              "chicken slowly cooked in a rich and aromatic coconut and kurma (date) sauce.",
          "ingredients":
              "onion, turmeric, chili, garlic, ginger, kurma (dates), oil, Chicken, coriander, chili peppers, lemongrass, ",
          "imageUrl":
              "https://img-global.cpcdn.com/recipes/86fd40ff2496de0f/1360x964cq70/gulai-korma-khas-minang-versi-ayam-foto-resep-utama.webp"
        },
        {
          "id": "b2146ad8-f45a-426c-9828-16a9ea5ccf1e",
          "title": "Gulai daging",
          "price": 40000,
          "description":
              "curry dish with main ingredients beef and unripe jackfruit",
          "ingredients":
              "coconut, Meat, shallots, chilies, turmeric, water, chili, garlic, salt, coconut milk, lime, kaffir lime leaves, lime leaves, lemongrass, ",
          "imageUrl":
              "https://assets.pikiran-rakyat.com/crop/0x0%3A0x0/750x500/photo/2021/11/25/217085998.jpeg"
        },
        {
          "id": "bd4434a5-4488-4d53-a477-9b542f5aec34",
          "title": "Gulai kepala ikan kakap merah",
          "price": 50000,
          "description": "red snapper's head gulai",
          "ingredients":
              "coconut, chilies, turmeric, chili, garlic, salt, coconut milk, lime, kaffir lime leaves, Red snapper's head, lime leaves, lemongrass, ",
          "imageUrl":
              "https://img-global.cpcdn.com/recipes/2d402f7844250193/1360x964cq70/gulai-kepala-ikan-kakap-merah-foto-resep-utama.webp"
        },
        {
          "id": "bffc0e18-3d01-4586-b12b-9b3a27e7d347",
          "title": "Gulai ayam",
          "price": 39000,
          "description": "chicken gulai",
          "ingredients":
              "coconut, shallots, turmeric, garlic, salt, coconut milk, lime, Chicken, kaffir lime leaves, lime leaves, lemongrass, ",
          "imageUrl":
              "https://asset.kompas.com/crops/4Pge4o-1NYVqjBcfiXvB2nAJcnM%3D/0x0%3A1000x667/750x500/data/photo/2021/05/11/609a26028d3c9.jpg"
        },
        {
          "id": "d1adc396-741d-4feb-b8f4-b4836714f996",
          "title": "Nasi kapau",
          "price": 45000,
          "description":
              "steamed rice topped with various choices of dishes originated from Bukittinggi, West Sumatra",
          "ingredients": "various dishes, Rice, ",
          "imageUrl":
              "https://i0.wp.com/resepkoki.id/wp-content/uploads/2020/12/Resep-Nasi-Kapau.jpg%3Ffit%3D1080%252C1440%26ssl%3D1"
        },
        {
          "id": "db9ae1f2-b556-4a8f-9fb4-effa914fc1eb",
          "title": "Ayam bakar",
          "price": 40000,
          "description": "grilled spicy chicken",
          "ingredients":
              "shallots, turmeric, tamarind, chili, garlic, kecap manis (sweet soy sauce), salt, oil, Chicken, lemongrass, ",
          "imageUrl":
              "https://www.sasa.co.id/medias/page_medias/ayam_bakar_lumajang.jpg"
        },
        {
          "id": "f17174b5-c69f-4b28-88f7-f6504f99d4de",
          "title": "Es tebak",
          "price": 25000,
          "description":
              "mixed of avocado, jack fruit, tebak, shredded and iced with sweet thick milk",
          "ingredients": "ice, Avocado, jackfruit, tebak, condensed milk, ",
          "imageUrl":
              "https://cdn.idntimes.com/content-images/post/20190507/es-campur-bandung-cirebon-483a1ad02721c4a36f42b0cd7f1c21cd_600x400.jpg"
        }
      ]
    },
    {
      "title": "Rumah Makan VII Koto Talago",
      "address": "Jl. Jhoni Anwar No.Kelurahan No.17, Padang",
      "district": "Padang Utara",
      "imageUrl":
          "https://lh3.googleusercontent.com/p/AF1QipMfCv5oU_RRNSg_BgK9lA9FLaMSABN1CUDTAO0S=s680-w680-h510",
      "foodsInTheRestaurant": [
        {
          "id": "3a4ba9ed-dd6c-4bbc-bfae-7faf76e5ca88",
          "title": "Soto",
          "price": 35000,
          "description":
              "traditional soup mainly composed of broth, meat and vegetables",
          "ingredients":
              "Meat, broth (spices like turmeric, turmeric, garlic, ginger, ginger), vegetables, broth, ",
          "imageUrl":
              "https://giwang.sumselprov.go.id/api/uploads/kuliner/kuliner_168860841064729.jpg"
        },
        {
          "id": "3c0c832e-ac22-4975-967c-95d40e7caf97",
          "title": "Roti tisu",
          "price": 16000,
          "description": "thinner version of the traditional roti canai",
          "ingredients": "Flour, water, ghee, oil or ghee, oil, ",
          "imageUrl":
              "https://cdn.tasteatlas.com/images/dishes/1414b9c07a7d45f293798254e59f2b5b.jpg%3Fw%3D600"
        },
        {
          "id": "3fb1020a-4675-4cb0-9189-b16b24d94407",
          "title": "Gulai udang",
          "price": 48000,
          "description": "shrimp gulai",
          "ingredients":
              "coconut, shallots, Shrimp, turmeric, garlic, salt, coconut milk, lime, kaffir lime leaves, lime leaves, lemongrass, ",
          "imageUrl":
              "https://cdn-brilio-net.akamaized.net/news/2021/08/18/211860/1544238-1000xauto-resep-gulai-udang.jpg"
        },
        {
          "id": "4450880a-a28a-4949-8b2c-77781029c613",
          "title": "Dendeng",
          "price": 50000,
          "description": "thinly sliced dried meat",
          "ingredients": "tamarind, garlic, salt, Beef, oil, coriander, ",
          "imageUrl":
              "https://encrypted-tbn0.gstatic.com/images%3Fq%3Dtbn%3AANd9GcSiBNMWYvpmCt1h1cajjZXjk-o_lv3e2NwtoA%26s"
        },
        {
          "id": "6d0a88e5-8afa-4eb3-b4de-c3cc9b4ce0ab",
          "title": "Sambalado",
          "price": 20000,
          "description":
              "chili paste similar to sambal with large sliced chili pepper, usually stir fried together with main ingredients",
          "ingredients":
              "shallots, tomato, sugar, garlic, tomatoes, salt, oil, Chilies, ",
          "imageUrl":
              "https://static.promediateknologi.id/crop/0x0%3A0x0/0x0/webp/photo/p2/131/2023/12/12/sambal-bawang-3278993492.jpg"
        },
        {
          "id": "7272e012-c3f3-4fb6-a22e-922ef7a57aa4",
          "title": "Sarikayo",
          "price": 12000,
          "description": "jam made from a base of coconut milk, eggs and sugar",
          "ingredients": "palm sugar, sugar, eggs, pandan leaves, ",
          "imageUrl":
              "https://ik.imagekit.io/goodid/gnfi/uploads/articles/large-img-20231106-093401-522787279d1f999ca516090844961d37.jpg"
        },
        {
          "id": "95c2fa2a-8f8f-4c72-ad10-d56c0c9d7bb7",
          "title": "Palai",
          "price": 28000,
          "description": "Minangkabau variants of pepes",
          "ingredients":
              "coconut, shallots, turmeric, garlic, grated coconut, banana leaves, Fish, ",
          "imageUrl":
              "https://img-global.cpcdn.com/recipes/f548101c11ec0f35/680x482cq70/resep-palai-bada-khas-minang-foto-resep-utama.jpg"
        },
        {
          "id": "a61eb40c-7f9a-473d-9455-4725393142dc",
          "title": "Ayam bumbu",
          "price": 41000,
          "description": "chicken with spices",
          "ingredients":
              "cumin, coconut, shallots, turmeric, garlic, ginger, salt, coconut milk, oil, Chicken, coriander, ",
          "imageUrl":
              "https://static.promediateknologi.id/crop/0x0%3A0x0/0x0/webp/photo/p2/74/2024/05/01/3c47eeba484ca5b1b586d8b374aba571-906762525.jpg"
        },
        {
          "id": "b820cb02-ce8d-4092-a599-f39d6dd9d5cd",
          "title": "Gulai cancang",
          "price": 40000,
          "description": "gulai of meats and cow internal organs",
          "ingredients":
              "coconut, Meat, chilies, turmeric, chili, garlic, salt, coconut milk, Meat and internal organs, lemongrass, ",
          "imageUrl":
              "https://nnc-media.netralnews.com/IMG-Netral-News-Admin-35-I2FNWD19UL.jpg"
        },
        {
          "id": "bd4434a5-4488-4d53-a477-9b542f5aec34",
          "title": "Gulai kepala ikan kakap merah",
          "price": 50000,
          "description": "red snapper's head gulai",
          "ingredients":
              "coconut, chilies, turmeric, chili, garlic, salt, coconut milk, lime, kaffir lime leaves, Red snapper's head, lime leaves, lemongrass, ",
          "imageUrl":
              "https://img-global.cpcdn.com/recipes/2d402f7844250193/1360x964cq70/gulai-kepala-ikan-kakap-merah-foto-resep-utama.webp"
        },
        {
          "id": "c1d8ebb6-dcaf-4931-943f-37def1697625",
          "title": "Serabi",
          "price": 14000,
          "description":
              "traditional pancake that is made from rice flour with coconut milk or shredded coconut",
          "ingredients":
              "coconut, Rice Flour, Flour, coconut milk, Rice, pandan leaves, ",
          "imageUrl": "https://i.ytimg.com/vi/DkgrqXLYgso/sddefault.jpg"
        },
        {
          "id": "db9ae1f2-b556-4a8f-9fb4-effa914fc1eb",
          "title": "Ayam bakar",
          "price": 40000,
          "description": "grilled spicy chicken",
          "ingredients":
              "shallots, turmeric, tamarind, chili, garlic, kecap manis (sweet soy sauce), salt, oil, Chicken, lemongrass, ",
          "imageUrl":
              "https://www.sasa.co.id/medias/page_medias/ayam_bakar_lumajang.jpg"
        },
        {
          "id": "e74c9cba-68fc-4dea-8059-c85725d52e85",
          "title": "Cumi Saus Padang",
          "price": 45000,
          "description":
              "squid cooked in a spicy Padang-style sauce of chili, garlic, and spices",
          "ingredients":
              "Shallots, Lime juice, chilies, Black pepper, Cooking oil, chili, Garlic, Water, oil, Shallots (sliced), Sweet soy sauce, Salt, Garlic (minced), Squid, Red chilies (sliced), Tomato sauce, ",
          "imageUrl":
              "https://www.blibli.com/friends-backend/wp-content/uploads/2023/03/B300019-Cover-resep-cumi-saus-padang-scaled.jpg"
        },
        {
          "id": "fe70d1d1-2fb3-4a06-9bbf-6b80bd343f59",
          "title": "Roti jala",
          "price": 18000,
          "description":
              "the name is derived from the Malay word roti (bread) and jala (net) A special ladle with a five-hole perforation used to make the bread looks like a fish net, It is usually eaten as an accompaniment to a curried dish, or served as a sweet with serawa, Serawa is made from a mixture of boiled coconut milk, brown sugar and pandan leaves",
          "ingredients":
              "coconut, Flour, water, coconut milk, eggs, pandan leaves, ",
          "imageUrl":
              "https://www.tokomesin.com/wp-content/uploads/2017/10/roti-jala-kari-ayam.jpg"
        }
      ]
    },
  ];

  final List<Map<String, dynamic>> cardData = [
    {
      "title": "Rumah Makan Taman Surya",
      "address": "Jl. Tamansiswa No. 15",
      "district": "Padang Utara",
      "imageUrl":
          "https://lh3.googleusercontent.com/p/AF1QipMucy2GYqlxcQZpn6g9OzG8CXFFHCZYpduAxKE2=s1360-w1360-h1020",
      "foodsInTheRestaurant": [
        {
          "id": "0215db5f-847d-4875-ba7c-6d8136a3c532",
          "title": "Rajungan goreng",
          "price": 70000,
          "description": "crispy fried crab",
          "ingredients": "salt, oil, Crab, ",
          "imageUrl":
              "https://cdn0-production-images-kly.akamaized.net/b4c9FCwttCcvLjdJ7sned_aS06c%3D/1x40%3A1000x603/1200x675/filters%3Aquality(75)%3Astrip_icc()%3Aformat(jpeg)/kly-media-production/medias/3570968/original/013224500_1631594241-shutterstock_1796323171.jpg"
        },
        {
          "id": "02173c34-d3b4-4f91-b762-8436d510bb63",
          "title": "Gulai paku",
          "price": 25000,
          "description": "fern gulai",
          "ingredients":
              "coconut, shallots, chilies, turmeric, water, chili, garlic, salt, coconut milk, lime, kaffir lime leaves, Paku, lime leaves, lemongrass, ",
          "imageUrl":
              "https://img-global.cpcdn.com/recipes/1d34ae7f990bd073/680x482cq70/gulai-pakisgulai-paku-foto-resep-utama.jpg"
        },
        {
          "id": "02274a61-8fc1-4e74-9045-4480764c9da7",
          "title": "Kerupuk jangek",
          "price": 18000,
          "description": "cow's skin krupuk",
          "ingredients": "salt, Cow skin, oil, ",
          "imageUrl":
              "https://upload.wikimedia.org/wikipedia/commons/b/be/Karupuak_jangek_2.jpg"
        },
        {
          "id": "2a858213-b635-4253-bc19-ba14f78578cd",
          "title": "Gulai ati",
          "price": 35000,
          "description": "gulai of cow liver",
          "ingredients":
              "coconut, shallots, chilies, turmeric, chili, garlic, Cow liver, salt, coconut milk, lemongrass, ",
          "imageUrl":
              "https://img-global.cpcdn.com/recipes/093bca8e79bc5ca4/1360x964cq70/gulai-hati-ampela-foto-resep-utama.webp"
        },
        {
          "id": "3afb4d62-29f8-43c3-8dd9-509075e88e2c",
          "title": "Sate padang",
          "price": 40000,
          "description":
              "Padang-style of satay, skewered barbecued meat with thick yellow sauce",
          "ingredients":
              "thick sauce (rice Flour-based), Meat, shallots, Flour, turmeric, garlic, lemongrass, ",
          "imageUrl": "https://i.ytimg.com/vi/hmWh0thXUbQ/maxresdefault.jpg"
        },
        {
          "id": "45ecc2cc-d220-4049-88c2-5e37109e924f",
          "title": "Sambal lado tanak",
          "price": 20000,
          "description":
              "sambal with coconut milk, anchovies, green stinky bean and spices",
          "ingredients":
              "coconut, shallots, Green chilies, chilies, chili, garlic, anchovies, coconut milk, stinky beans, ",
          "imageUrl":
              "https://img-global.cpcdn.com/recipes/197c93a33e56af43/680x482cq70/sambalado-tanak-khas-minang-foto-resep-utama.jpg"
        },
        {
          "id": "46c93e82-181d-4371-8e49-9839668dd863",
          "title": "Ikan bilih",
          "price": 38000,
          "description":
              "fried small freshwater fish of the genus Mystacoleucus",
          "ingredients": "salt, Small freshwater fish, oil, ",
          "imageUrl":
              "https://packagepadang.com/wp-content/uploads/2023/05/ikan-bilih.jpg"
        },
        {
          "id": "4d9184ef-97c3-44c9-9e54-ee6859680828",
          "title": "Gulai sayua",
          "price": 30000,
          "description":
              "curry dish with main ingredients vegetables such as cassava leaves and unripe jackfruit",
          "ingredients":
              "coconut, shallots, chilies, turmeric, water, chili, garlic, salt, coconut milk, lime, oil, Vegetable, kaffir lime leaves, lime leaves, lemongrass, ",
          "imageUrl":
              "https://akcdn.detik.net.id/community/media/visual/2023/01/01/resep-gulai-aneka-sayuran_43.jpeg%3Fw%3D700%26q%3D90"
        },
        {
          "id": "9dd2d67d-58ec-4122-83ca-efce2e04cc31",
          "title": "Dadiah",
          "price": 18000,
          "description": "fermented buffalo milk akin to yogurt",
          "ingredients": "Fermented buffalo milk, ",
          "imageUrl":
              "https://indonesiakaya.com/wp-content/uploads/2020/10/5__IMG_3410_Citarasanya_yang_unik_membuat_dadiah_tergolong_kuliner_dengan_peminat_yang_spesifik.jpg"
        },
        {
          "id": "a2e5ca53-04a3-49e3-a623-4e6ee5ec46c9",
          "title": "Satay ayam",
          "price": 35000,
          "description":
              "dish of seasoned, skewered and grilled chicken, served with a sauce",
          "ingredients":
              "shallots, garlic, sweet soy sauce, Chicken, skewers, peanut sauce, ",
          "imageUrl":
              "https://img-global.cpcdn.com/recipes/a6ca9f36b02b089b/680x482cq70/sate-ayam-khas-madura-foto-resep-utama.jpg"
        },
        {
          "id": "a6d45a69-80c9-4c29-970d-6576322ab563",
          "title": "Gulai kepala ikan",
          "price": 48000,
          "description": "fish head gulai",
          "ingredients":
              "coconut, shallots, turmeric, garlic, salt, coconut milk, lime, kaffir lime leaves, Fish head, lime leaves, Fish, lemongrass, ",
          "imageUrl":
              "https://cdn.idntimes.com/content-images/community/2021/10/fromandroid-f2a4fb48c1f2c9948243bd190a3c71c6.jpg"
        },
        {
          "id": "ab01df10-2430-4eaa-80a6-7590b7742a42",
          "title": "Lele goreng",
          "price": 30000,
          "description": "fried catfish",
          "ingredients": "turmeric, Catfish, garlic, salt, oil, ",
          "imageUrl":
              "https://kurio-img.kurioapps.com/22/09/26/ea665aec-bb3e-4232-9fa2-6b29197a5884.jpg"
        },
        {
          "id": "b2146ad8-f45a-426c-9828-16a9ea5ccf1e",
          "title": "Gulai daging",
          "price": 40000,
          "description":
              "curry dish with main ingredients beef and unripe jackfruit",
          "ingredients":
              "coconut, Meat, shallots, chilies, turmeric, water, chili, garlic, salt, coconut milk, lime, kaffir lime leaves, lime leaves, lemongrass, ",
          "imageUrl":
              "https://assets.pikiran-rakyat.com/crop/0x0%3A0x0/750x500/photo/2021/11/25/217085998.jpeg"
        },
        {
          "id": "b820cb02-ce8d-4092-a599-f39d6dd9d5cd",
          "title": "Gulai cancang",
          "price": 40000,
          "description": "gulai of meats and cow internal organs",
          "ingredients":
              "coconut, Meat, chilies, turmeric, chili, garlic, salt, coconut milk, Meat and internal organs, lemongrass, ",
          "imageUrl":
              "https://nnc-media.netralnews.com/IMG-Netral-News-Admin-35-I2FNWD19UL.jpg"
        },
        {
          "id": "c80f5b33-16a8-4ead-8301-298f764a5187",
          "title": "Gulai babek",
          "price": 37000,
          "description":
              "gulai babat, or gulai paruik kabau, gulai of cow tripes",
          "ingredients":
              "coconut, shallots, chilies, turmeric, chili, garlic, salt, coconut milk, Cow tripe, lemongrass, ",
          "imageUrl":
              "https://cdn.yummy.co.id/content-images/images/20210731/B6mbbnT8my7I95S8VOzmTgJFrDnQM0Ne-31363237373039383835d41d8cd98f00b204e9800998ecf8427e.jpg%3Fx-oss-process%3Dimage/resize%2Cw_388%2Ch_388%2Cm_fixed%2Cx-oss-process%3Dimage/format%2Cwebp"
        },
        {
          "id": "dbcee8e3-0192-4372-9191-a9d6ec4e4e2b",
          "title": "Ayam Gulai Nangka",
          "price": 50000,
          "description":
              "Chicken simmered in a spicy coconut curry with young jackfruit.",
          "ingredients":
              "coconut, chilies, turmeric, bay leaves., bay leaves, jackfruit, chili, coconut milk, Chicken, red chilies, young jackfruit, galangal, lemongrass, ",
          "imageUrl":
              "https://static.promediateknologi.id/crop/0x0%3A0x0/750x500/webp/photo/p1/1067/2024/05/21/maxresdefault-8-1983884964.jpg"
        },
        {
          "id": "ddbf80f4-772b-45d5-9b18-6ffcd400dd4f",
          "title": "Es ampiang dadiah",
          "price": 20000,
          "description": "Minang yogurt served with shaved ice and palm sugar",
          "ingredients":
              "ice, rice Flour, shaved ice, Flour, palm sugar, sugar, Buffalo milk (fermented), ",
          "imageUrl":
              "https://cdn.idntimes.com/content-images/community/2021/01/119657646-3525199824196675-1505695841977428848-n-0b2e3fe55c98e8dc089991ca6127b017-593497de0889f8a23280afeda9c8d205_600x400.jpg"
        },
        {
          "id": "ec0d7ab8-4ba5-4c8d-927d-38981e693d96",
          "title": "Pergedel jaguang",
          "price": 15000,
          "description": "corn fritters",
          "ingredients": "shallots, Flour, garlic, salt, oil, eggs, Corn, ",
          "imageUrl":
              "https://asset.kompas.com/crops/qiVD1zYxC5A49SsCaE_2hrUR7g0%3D/65x0%3A907x561/750x500/data/photo/2020/11/02/5f9f812b3e9fa.jpg"
        },
        {
          "id": "efab575f-9ca3-4665-83b3-7c639ddf10cf",
          "title": "Kue putu",
          "price": 12000,
          "description":
              "traditional cylindrical-shaped and green-colored steamed cake",
          "ingredients":
              "coconut, Rice Flour, Flour, palm sugar, sugar, Rice, pandan leaves, ",
          "imageUrl":
              "https://cdn.rri.co.id/berita/Bukittinggi/o/1716266719523-1705038382_65a0d22ebe1a1_KraEi35RrXloPGaZ2y2Z/de4ooj24jn7p32r.webp"
        },
        {
          "id": "f5b8aa37-85fa-4594-818a-b76e06413cac",
          "title": "Petai goreng",
          "price": 18000,
          "description": "fried green stinky bean (Parkia speciosa)",
          "ingredients": "Stinky beans (Parkia speciosa), oil, ",
          "imageUrl":
              "https://images.tokopedia.net/img/cache/700/VqbcmM/2021/2/11/098d34be-e600-4635-b73b-13c358ab6879.jpg"
        }
      ]
    },
    {
      "title": "Restoran Kubang Hayuda",
      "address": "Jl. Prof. M. Yamin SH No. 138B, Padang",
      "district": "Padang Barat",
      "imageUrl":
          "https://lh3.googleusercontent.com/p/AF1QipPE1fJpyuCWE2eMPbYKPL5zD-eTKPbvM_MJ6bmD=s680-w680-h510",
      "foodsInTheRestaurant": [
        {
          "id": "02173c34-d3b4-4f91-b762-8436d510bb63",
          "title": "Gulai paku",
          "price": 25000,
          "description": "fern gulai",
          "ingredients":
              "coconut, shallots, chilies, turmeric, water, chili, garlic, salt, coconut milk, lime, kaffir lime leaves, Paku, lime leaves, lemongrass, ",
          "imageUrl":
              "https://img-global.cpcdn.com/recipes/1d34ae7f990bd073/680x482cq70/gulai-pakisgulai-paku-foto-resep-utama.jpg"
        },
        {
          "id": "0aa137f9-3f93-44d1-b1bb-4a5d3f0d42a3",
          "title": "Kalio Ayam",
          "price": 35000,
          "description":
              "similar to rendang; while rendang is rather dry, kalio is watery and light-colored",
          "ingredients":
              "Shallots, Turmeric, Coconut milk, chilies, Cooking oil, chili, Ginger (sliced), Garlic, Lemongrass, Sugar, Water, oil, Shallots (sliced), Chicken, Salt, Garlic (minced), Red chilies (sliced), ",
          "imageUrl":
              "https://asset.kompas.com/crops/mCb4rnN344JdAyqQs9i1IJWktRU%3D/0x379%3A667x823/750x500/data/photo/2021/05/11/609a2c750cdc5.jpg"
        },
        {
          "id": "48ff3e73-d767-4173-bbe8-44ec2b24aa8c",
          "title": "Es campur",
          "price": 20000,
          "description":
              "cold and sweet dessert concoction of fruit cocktails, coconut, tapioca pearls, grass jellies, etc, and served in shaved ice, syrup and condensed milk",
          "ingredients":
              "ice, shaved ice, jackfruit, condensed milk, Mixed fruits (coconut, syrup, tapioca pearls, jackfruit), ",
          "imageUrl":
              "https://cdn0-production-images-kly.akamaized.net/qSxIa6DhH4tSfPQdtDo-0vS-6R8%3D/0x2180%3A3999x4434/1200x675/filters%3Aquality(75)%3Astrip_icc()%3Aformat(jpeg)/kly-media-production/medias/3981507/original/061819300_1648783740-shutterstock_1969134643.jpg"
        },
        {
          "id": "6d0a88e5-8afa-4eb3-b4de-c3cc9b4ce0ab",
          "title": "Sambalado",
          "price": 20000,
          "description":
              "chili paste similar to sambal with large sliced chili pepper, usually stir fried together with main ingredients",
          "ingredients":
              "shallots, tomato, sugar, garlic, tomatoes, salt, oil, Chilies, ",
          "imageUrl":
              "https://static.promediateknologi.id/crop/0x0%3A0x0/0x0/webp/photo/p2/131/2023/12/12/sambal-bawang-3278993492.jpg"
        },
        {
          "id": "9e949d0b-f83e-4512-8ce0-bf62ba5fee88",
          "title": "Ayam kurma",
          "price": 16000,
          "description":
              "chicken slowly cooked in a rich and aromatic coconut and kurma (date) sauce.",
          "ingredients":
              "onion, turmeric, chili, garlic, ginger, kurma (dates), oil, Chicken, coriander, chili peppers, lemongrass, ",
          "imageUrl":
              "https://img-global.cpcdn.com/recipes/86fd40ff2496de0f/1360x964cq70/gulai-korma-khas-minang-versi-ayam-foto-resep-utama.webp"
        },
        {
          "id": "b2146ad8-f45a-426c-9828-16a9ea5ccf1e",
          "title": "Gulai daging",
          "price": 40000,
          "description":
              "curry dish with main ingredients beef and unripe jackfruit",
          "ingredients":
              "coconut, Meat, shallots, chilies, turmeric, water, chili, garlic, salt, coconut milk, lime, kaffir lime leaves, lime leaves, lemongrass, ",
          "imageUrl":
              "https://assets.pikiran-rakyat.com/crop/0x0%3A0x0/750x500/photo/2021/11/25/217085998.jpeg"
        },
        {
          "id": "bd4434a5-4488-4d53-a477-9b542f5aec34",
          "title": "Gulai kepala ikan kakap merah",
          "price": 50000,
          "description": "red snapper's head gulai",
          "ingredients":
              "coconut, chilies, turmeric, chili, garlic, salt, coconut milk, lime, kaffir lime leaves, Red snapper's head, lime leaves, lemongrass, ",
          "imageUrl":
              "https://img-global.cpcdn.com/recipes/2d402f7844250193/1360x964cq70/gulai-kepala-ikan-kakap-merah-foto-resep-utama.webp"
        },
        {
          "id": "bffc0e18-3d01-4586-b12b-9b3a27e7d347",
          "title": "Gulai ayam",
          "price": 39000,
          "description": "chicken gulai",
          "ingredients":
              "coconut, shallots, turmeric, garlic, salt, coconut milk, lime, Chicken, kaffir lime leaves, lime leaves, lemongrass, ",
          "imageUrl":
              "https://asset.kompas.com/crops/4Pge4o-1NYVqjBcfiXvB2nAJcnM%3D/0x0%3A1000x667/750x500/data/photo/2021/05/11/609a26028d3c9.jpg"
        },
        {
          "id": "d1adc396-741d-4feb-b8f4-b4836714f996",
          "title": "Nasi kapau",
          "price": 45000,
          "description":
              "steamed rice topped with various choices of dishes originated from Bukittinggi, West Sumatra",
          "ingredients": "various dishes, Rice, ",
          "imageUrl":
              "https://i0.wp.com/resepkoki.id/wp-content/uploads/2020/12/Resep-Nasi-Kapau.jpg%3Ffit%3D1080%252C1440%26ssl%3D1"
        },
        {
          "id": "db9ae1f2-b556-4a8f-9fb4-effa914fc1eb",
          "title": "Ayam bakar",
          "price": 40000,
          "description": "grilled spicy chicken",
          "ingredients":
              "shallots, turmeric, tamarind, chili, garlic, kecap manis (sweet soy sauce), salt, oil, Chicken, lemongrass, ",
          "imageUrl":
              "https://www.sasa.co.id/medias/page_medias/ayam_bakar_lumajang.jpg"
        },
        {
          "id": "f17174b5-c69f-4b28-88f7-f6504f99d4de",
          "title": "Es tebak",
          "price": 25000,
          "description":
              "mixed of avocado, jack fruit, tebak, shredded and iced with sweet thick milk",
          "ingredients": "ice, Avocado, jackfruit, tebak, condensed milk, ",
          "imageUrl":
              "https://cdn.idntimes.com/content-images/post/20190507/es-campur-bandung-cirebon-483a1ad02721c4a36f42b0cd7f1c21cd_600x400.jpg"
        }
      ]
    },
    {
      "title": "Rumah Makan VII Koto Talago",
      "address": "Jl. Jhoni Anwar No.Kelurahan No.17, Padang",
      "district": "Padang Utara",
      "imageUrl":
          "https://lh3.googleusercontent.com/p/AF1QipMfCv5oU_RRNSg_BgK9lA9FLaMSABN1CUDTAO0S=s680-w680-h510",
      "foodsInTheRestaurant": [
        {
          "id": "3a4ba9ed-dd6c-4bbc-bfae-7faf76e5ca88",
          "title": "Soto",
          "price": 35000,
          "description":
              "traditional soup mainly composed of broth, meat and vegetables",
          "ingredients":
              "Meat, broth (spices like turmeric, turmeric, garlic, ginger, ginger), vegetables, broth, ",
          "imageUrl":
              "https://giwang.sumselprov.go.id/api/uploads/kuliner/kuliner_168860841064729.jpg"
        },
        {
          "id": "3c0c832e-ac22-4975-967c-95d40e7caf97",
          "title": "Roti tisu",
          "price": 16000,
          "description": "thinner version of the traditional roti canai",
          "ingredients": "Flour, water, ghee, oil or ghee, oil, ",
          "imageUrl":
              "https://cdn.tasteatlas.com/images/dishes/1414b9c07a7d45f293798254e59f2b5b.jpg%3Fw%3D600"
        },
        {
          "id": "3fb1020a-4675-4cb0-9189-b16b24d94407",
          "title": "Gulai udang",
          "price": 48000,
          "description": "shrimp gulai",
          "ingredients":
              "coconut, shallots, Shrimp, turmeric, garlic, salt, coconut milk, lime, kaffir lime leaves, lime leaves, lemongrass, ",
          "imageUrl":
              "https://cdn-brilio-net.akamaized.net/news/2021/08/18/211860/1544238-1000xauto-resep-gulai-udang.jpg"
        },
        {
          "id": "4450880a-a28a-4949-8b2c-77781029c613",
          "title": "Dendeng",
          "price": 50000,
          "description": "thinly sliced dried meat",
          "ingredients": "tamarind, garlic, salt, Beef, oil, coriander, ",
          "imageUrl":
              "https://encrypted-tbn0.gstatic.com/images%3Fq%3Dtbn%3AANd9GcSiBNMWYvpmCt1h1cajjZXjk-o_lv3e2NwtoA%26s"
        },
        {
          "id": "6d0a88e5-8afa-4eb3-b4de-c3cc9b4ce0ab",
          "title": "Sambalado",
          "price": 20000,
          "description":
              "chili paste similar to sambal with large sliced chili pepper, usually stir fried together with main ingredients",
          "ingredients":
              "shallots, tomato, sugar, garlic, tomatoes, salt, oil, Chilies, ",
          "imageUrl":
              "https://static.promediateknologi.id/crop/0x0%3A0x0/0x0/webp/photo/p2/131/2023/12/12/sambal-bawang-3278993492.jpg"
        },
        {
          "id": "7272e012-c3f3-4fb6-a22e-922ef7a57aa4",
          "title": "Sarikayo",
          "price": 12000,
          "description": "jam made from a base of coconut milk, eggs and sugar",
          "ingredients": "palm sugar, sugar, eggs, pandan leaves, ",
          "imageUrl":
              "https://ik.imagekit.io/goodid/gnfi/uploads/articles/large-img-20231106-093401-522787279d1f999ca516090844961d37.jpg"
        },
        {
          "id": "95c2fa2a-8f8f-4c72-ad10-d56c0c9d7bb7",
          "title": "Palai",
          "price": 28000,
          "description": "Minangkabau variants of pepes",
          "ingredients":
              "coconut, shallots, turmeric, garlic, grated coconut, banana leaves, Fish, ",
          "imageUrl":
              "https://img-global.cpcdn.com/recipes/f548101c11ec0f35/680x482cq70/resep-palai-bada-khas-minang-foto-resep-utama.jpg"
        },
        {
          "id": "a61eb40c-7f9a-473d-9455-4725393142dc",
          "title": "Ayam bumbu",
          "price": 41000,
          "description": "chicken with spices",
          "ingredients":
              "cumin, coconut, shallots, turmeric, garlic, ginger, salt, coconut milk, oil, Chicken, coriander, ",
          "imageUrl":
              "https://static.promediateknologi.id/crop/0x0%3A0x0/0x0/webp/photo/p2/74/2024/05/01/3c47eeba484ca5b1b586d8b374aba571-906762525.jpg"
        },
        {
          "id": "b820cb02-ce8d-4092-a599-f39d6dd9d5cd",
          "title": "Gulai cancang",
          "price": 40000,
          "description": "gulai of meats and cow internal organs",
          "ingredients":
              "coconut, Meat, chilies, turmeric, chili, garlic, salt, coconut milk, Meat and internal organs, lemongrass, ",
          "imageUrl":
              "https://nnc-media.netralnews.com/IMG-Netral-News-Admin-35-I2FNWD19UL.jpg"
        },
        {
          "id": "bd4434a5-4488-4d53-a477-9b542f5aec34",
          "title": "Gulai kepala ikan kakap merah",
          "price": 50000,
          "description": "red snapper's head gulai",
          "ingredients":
              "coconut, chilies, turmeric, chili, garlic, salt, coconut milk, lime, kaffir lime leaves, Red snapper's head, lime leaves, lemongrass, ",
          "imageUrl":
              "https://img-global.cpcdn.com/recipes/2d402f7844250193/1360x964cq70/gulai-kepala-ikan-kakap-merah-foto-resep-utama.webp"
        },
        {
          "id": "c1d8ebb6-dcaf-4931-943f-37def1697625",
          "title": "Serabi",
          "price": 14000,
          "description":
              "traditional pancake that is made from rice flour with coconut milk or shredded coconut",
          "ingredients":
              "coconut, Rice Flour, Flour, coconut milk, Rice, pandan leaves, ",
          "imageUrl": "https://i.ytimg.com/vi/DkgrqXLYgso/sddefault.jpg"
        },
        {
          "id": "db9ae1f2-b556-4a8f-9fb4-effa914fc1eb",
          "title": "Ayam bakar",
          "price": 40000,
          "description": "grilled spicy chicken",
          "ingredients":
              "shallots, turmeric, tamarind, chili, garlic, kecap manis (sweet soy sauce), salt, oil, Chicken, lemongrass, ",
          "imageUrl":
              "https://www.sasa.co.id/medias/page_medias/ayam_bakar_lumajang.jpg"
        },
        {
          "id": "e74c9cba-68fc-4dea-8059-c85725d52e85",
          "title": "Cumi Saus Padang",
          "price": 45000,
          "description":
              "squid cooked in a spicy Padang-style sauce of chili, garlic, and spices",
          "ingredients":
              "Shallots, Lime juice, chilies, Black pepper, Cooking oil, chili, Garlic, Water, oil, Shallots (sliced), Sweet soy sauce, Salt, Garlic (minced), Squid, Red chilies (sliced), Tomato sauce, ",
          "imageUrl":
              "https://www.blibli.com/friends-backend/wp-content/uploads/2023/03/B300019-Cover-resep-cumi-saus-padang-scaled.jpg"
        },
        {
          "id": "fe70d1d1-2fb3-4a06-9bbf-6b80bd343f59",
          "title": "Roti jala",
          "price": 18000,
          "description":
              "the name is derived from the Malay word roti (bread) and jala (net) A special ladle with a five-hole perforation used to make the bread looks like a fish net, It is usually eaten as an accompaniment to a curried dish, or served as a sweet with serawa, Serawa is made from a mixture of boiled coconut milk, brown sugar and pandan leaves",
          "ingredients":
              "coconut, Flour, water, coconut milk, eggs, pandan leaves, ",
          "imageUrl":
              "https://www.tokomesin.com/wp-content/uploads/2017/10/roti-jala-kari-ayam.jpg"
        }
      ]
    },
  ];

  final List<Map<String, dynamic>> cardDataDistrict = [
    {
      "title": "Padang Utara",
      "imageUrl":
          "https://lh5.googleusercontent.com/p/AF1QipOjtH1F3dIPa_q_CFqrBKr0u03o0CCRSWdyr5kb=w426-h240-k-no",
      "trivia":
          "Lokasi dari salah satu rumah makan terbaik di Padang, RM Lamun Ombak, serta Masjid Raya Sumatera Barat",
      "restaurantsInTheDistrict": [
        {
          "title": "Lamun Ombak",
          "address": "Jl. Khatib Sulaiman No.99, Padang",
          "district": "Padang Utara",
          "imageUrl":
              "https://minangkabau-airport.co.id/userdata/pariwisata/ads5a027c169c4bc.jpg",
          "foodsInTheRestaurant": [
            {
              "id": "02173c34-d3b4-4f91-b762-8436d510bb63",
              "title": "Gulai paku",
              "price": 25000,
              "description": "fern gulai",
              "ingredients":
                  "coconut, shallots, chilies, turmeric, water, chili, garlic, salt, coconut milk, lime, kaffir lime leaves, Paku, lime leaves, lemongrass, ",
              "imageUrl":
                  "https://img-global.cpcdn.com/recipes/1d34ae7f990bd073/680x482cq70/gulai-pakisgulai-paku-foto-resep-utama.jpg"
            },
            {
              "id": "02e97b94-e8b6-4b47-9c51-ddd40a974796",
              "title": "Lupis",
              "price": 13000,
              "description":
                  "sweet cake made of glutinous rice, banana leaves, coconut, and palm sugar sauce",
              "ingredients":
                  "coconut, palm sugar, sugar, Glutinous rice, banana leaves, ",
              "imageUrl":
                  "https://serikatnews.com/wp-content/uploads/2023/09/cook-pad7.jpg"
            },
            {
              "id": "2a858213-b635-4253-bc19-ba14f78578cd",
              "title": "Gulai ati",
              "price": 35000,
              "description": "gulai of cow liver",
              "ingredients":
                  "coconut, shallots, chilies, turmeric, chili, garlic, Cow liver, salt, coconut milk, lemongrass, ",
              "imageUrl":
                  "https://img-global.cpcdn.com/recipes/093bca8e79bc5ca4/1360x964cq70/gulai-hati-ampela-foto-resep-utama.webp"
            },
            {
              "id": "4450880a-a28a-4949-8b2c-77781029c613",
              "title": "Dendeng",
              "price": 50000,
              "description": "thinly sliced dried meat",
              "ingredients": "tamarind, garlic, salt, Beef, oil, coriander, ",
              "imageUrl":
                  "https://encrypted-tbn0.gstatic.com/images%3Fq%3Dtbn%3AANd9GcSiBNMWYvpmCt1h1cajjZXjk-o_lv3e2NwtoA%26s"
            },
            {
              "id": "45ecc2cc-d220-4049-88c2-5e37109e924f",
              "title": "Sambal lado tanak",
              "price": 20000,
              "description":
                  "sambal with coconut milk, anchovies, green stinky bean and spices",
              "ingredients":
                  "coconut, shallots, Green chilies, chilies, chili, garlic, anchovies, coconut milk, stinky beans, ",
              "imageUrl":
                  "https://img-global.cpcdn.com/recipes/197c93a33e56af43/680x482cq70/sambalado-tanak-khas-minang-foto-resep-utama.jpg"
            },
            {
              "id": "4b0d6510-fbe5-4e96-a7cc-1075187a4da6",
              "title": "Lopek sarikayo",
              "price": 12000,
              "description": "sticky and chewy snack made from glutinous rice",
              "ingredients":
                  "coconut, palm sugar, sugar, Glutinous rice, coconut milk, pandan leaves, ",
              "imageUrl":
                  "https://cdn.yummy.co.id/content-images/images/20210629/OzVenSPIA2FfScBYrXaBjJKx4C8Ehj9o-31363234393435353239d41d8cd98f00b204e9800998ecf8427e.jpg%3Fx-oss-process%3Dimage/resize%2Cw_388%2Ch_388%2Cm_fixed%2Cx-oss-process%3Dimage/format%2Cwebp"
            },
            {
              "id": "4ed19b4d-53b4-49f8-95ed-5a6bf1c0fef5",
              "title": "Dendeng balado",
              "price": 52000,
              "description": "thin crispy beef with chili",
              "ingredients":
                  "shallots, tomato, chilies, chili, garlic, tomatoes, salt, lime, oil, red chilies, Thin beef slices, lime leaves, ",
              "imageUrl":
                  "https://www.sasa.co.id/medias/page_medias/resep_dendeng_balado.jpg"
            },
            {
              "id": "57850d96-4146-4fa2-ae94-6b006ae8fabe",
              "title": "Ayam balado",
              "price": 42000,
              "description": "chicken in chili",
              "ingredients":
                  "shallots, tomato, chilies, sugar, chili, garlic, tomatoes, salt, lime, oil, Chicken, red chilies, lime leaves, ",
              "imageUrl":
                  "https://asset.kompas.com/crops/puSCmWekgKRyE5cRP8IWHhIgTsU%3D/0x0%3A1000x667/750x500/data/photo/2023/02/22/63f567b4ab9d0.jpeg"
            },
            {
              "id": "6d0a88e5-8afa-4eb3-b4de-c3cc9b4ce0ab",
              "title": "Sambalado",
              "price": 20000,
              "description":
                  "chili paste similar to sambal with large sliced chili pepper, usually stir fried together with main ingredients",
              "ingredients":
                  "shallots, tomato, sugar, garlic, tomatoes, salt, oil, Chilies, ",
              "imageUrl":
                  "https://static.promediateknologi.id/crop/0x0%3A0x0/0x0/webp/photo/p2/131/2023/12/12/sambal-bawang-3278993492.jpg"
            },
            {
              "id": "6f9f1cb9-3567-4bf9-afda-433923f23e3d",
              "title": "Terong balado",
              "price": 20000,
              "description": "eggplant in chili",
              "ingredients":
                  "Eggplant, shallots, tomato, chilies, chili, garlic, tomatoes, salt, red chilies, ",
              "imageUrl":
                  "https://asset.kompas.com/crops/BrFLVwC5LlT6v83pNAG8WGtFwHo%3D/210x196%3A795x585/750x500/data/photo/2022/09/27/63329904a916d.jpg"
            },
            {
              "id": "70baf4c8-6763-4955-ae77-97d2725c9dd0",
              "title": "Lado Ijo",
              "price": 15000,
              "description":
                  "a variant of green chili sambal with fried anchovies or shrimp",
              "ingredients":
                  "Shallots, Lime juice, Green chilies, chilies, tamarind, chili, Garlic, Sugar, Water, Lime juice or tamarind, Salt, Sugar (optional), ",
              "imageUrl":
                  "https://asset.kompas.com/crops/i8XPicsLEUrsaUTQpb62FK7kU_g%3D/0x0%3A1000x667/750x500/data/photo/2020/08/24/5f431f6307111.jpg"
            },
            {
              "id": "802f92a5-0ba1-49fc-afc6-b31219373b3f",
              "title": "Bubur kampiun",
              "price": 18000,
              "description":
                  "porridge made from rice flour mixed with brown sugar",
              "ingredients":
                  "coconut, Rice Flour, Flour, palm sugar, sweet potato, sugar, jackfruit, mung beans, coconut milk, Rice, pandan leaves, ",
              "imageUrl":
                  "https://www.masakapahariini.com/wp-content/uploads/2023/08/bubur-kampiun.jpeg"
            },
            {
              "id": "80b1db42-cf77-4bb5-ae3a-a7df954cc7e2",
              "title": "Peyek",
              "price": 12000,
              "description": "deep-fried savoury crackers",
              "ingredients":
                  "Flour, water, garlic, salt, oil, peanuts, coriander, ",
              "imageUrl":
                  "https://awsimages.detik.net.id/community/media/visual/2021/11/09/peyek-kacang_169.jpeg%3Fw%3D600%26q%3D90"
            },
            {
              "id": "82139a64-8fb1-45df-b215-31e0c2e4ae5d",
              "title": "Ayam lado ijo",
              "price": 42000,
              "description": "chicken in green chili",
              "ingredients":
                  "shallots, chilies, chili, garlic, salt, lime, oil, Chicken, lime leaves, green chilies, ",
              "imageUrl":
                  "https://static.promediateknologi.id/crop/6x262%3A1075x1659/750x500/webp/photo/p1/1005/2024/01/28/Screenshot_20240128_195516_Instagram-3462551055.jpg"
            },
            {
              "id": "bd2b1296-85d8-4db1-9dba-a0b61d22a0a7",
              "title": "Nasi kari or nasi gulai",
              "price": 40000,
              "description": "rice and curry",
              "ingredients":
                  "coconut, shallots, chilies, turmeric, chili, garlic, coconut milk, Rice, lemongrass, ",
              "imageUrl":
                  "https://media-cdn.tripadvisor.com/media/photo-s/1a/df/23/db/nasi-padang-ayam-gulai.jpg"
            },
            {
              "id": "d1adc396-741d-4feb-b8f4-b4836714f996",
              "title": "Nasi kapau",
              "price": 45000,
              "description":
                  "steamed rice topped with various choices of dishes originated from Bukittinggi, West Sumatra",
              "ingredients": "various dishes, Rice, ",
              "imageUrl":
                  "https://i0.wp.com/resepkoki.id/wp-content/uploads/2020/12/Resep-Nasi-Kapau.jpg%3Ffit%3D1080%252C1440%26ssl%3D1"
            },
            {
              "id": "ddbf80f4-772b-45d5-9b18-6ffcd400dd4f",
              "title": "Es ampiang dadiah",
              "price": 20000,
              "description":
                  "Minang yogurt served with shaved ice and palm sugar",
              "ingredients":
                  "ice, rice Flour, shaved ice, Flour, palm sugar, sugar, Buffalo milk (fermented), ",
              "imageUrl":
                  "https://cdn.idntimes.com/content-images/community/2021/01/119657646-3525199824196675-1505695841977428848-n-0b2e3fe55c98e8dc089991ca6127b017-593497de0889f8a23280afeda9c8d205_600x400.jpg"
            },
            {
              "id": "e14e783b-bfce-40c2-bca3-661dac67142e",
              "title": "Gulai tunjang",
              "price": 36000,
              "description": "gulai of cow foot tendons",
              "ingredients":
                  "coconut, chilies, turmeric, chili, garlic, salt, coconut milk, Cow foot tendons, lemongrass, ",
              "imageUrl":
                  "https://cdn.idntimes.com/content-images/post/20200917/118813150-2710132395869504-6021290183484363500-n-b878035a8c04ac1c7f1d0d5871c10bfa_600x400.jpg"
            },
            {
              "id": "e74c9cba-68fc-4dea-8059-c85725d52e85",
              "title": "Cumi Saus Padang",
              "price": 45000,
              "description":
                  "squid cooked in a spicy Padang-style sauce of chili, garlic, and spices",
              "ingredients":
                  "Shallots, Lime juice, chilies, Black pepper, Cooking oil, chili, Garlic, Water, oil, Shallots (sliced), Sweet soy sauce, Salt, Garlic (minced), Squid, Red chilies (sliced), Tomato sauce, ",
              "imageUrl":
                  "https://www.blibli.com/friends-backend/wp-content/uploads/2023/03/B300019-Cover-resep-cumi-saus-padang-scaled.jpg"
            },
            {
              "id": "f3bf6927-b77a-4221-94fc-b127ddba6732",
              "title": "Martabak kubang",
              "price": 65000,
              "description":
                  "Minangkabau-style of murtabak from Lima Puluh Kota Regency, West Sumatra, It is Arab\u2013Indian\u2013Minangkabau fusion dish",
              "ingredients":
                  "shallots, garlic, oil, ground beef, eggs, curry powder, Dough, ",
              "imageUrl":
                  "https://assets-pergikuliner.com/4LbOxRUPxgiqRbzDwXDkOcxd47g%3D/fit-in/1366x768/smart/filters%3Ano_upscale()https://assets-pergikuliner.com/uploads/image/picture/2268274/picture-1626920552.jpg"
            }
          ]
        },
        {
          "title": "RM Pauh Piaman",
          "address": "Jl. Bandar Purus No. 29, Padang",
          "district": "Padang Utara",
          "imageUrl":
              "https://i.gojekapi.com/darkroom/gofood-indonesia/v2/images/uploads/c8851c45-77c4-4c73-bf0f-e7db6934192b.jpg",
          "foodsInTheRestaurant": [
            {
              "id": "0b0ce4c4-a5a2-4b91-9fff-61a796c50486",
              "title": "Asam padeh",
              "price": 45000,
              "description": "sour and spicy fish stew dish",
              "ingredients":
                  "shallots, chilies, turmeric, tamarind, water, chili, garlic, ginger, salt, Fish, lemongrass, ",
              "imageUrl":
                  "https://asset.kompas.com/crops/orYuU83oqu-mGLBkAGhZA5NsFBA%3D/109x69%3A909x603/750x500/data/photo/2023/09/10/64fd27148f94b.jpg"
            },
            {
              "id": "3afb4d62-29f8-43c3-8dd9-509075e88e2c",
              "title": "Sate padang",
              "price": 40000,
              "description":
                  "Padang-style of satay, skewered barbecued meat with thick yellow sauce",
              "ingredients":
                  "thick sauce (rice Flour-based), Meat, shallots, Flour, turmeric, garlic, lemongrass, ",
              "imageUrl": "https://i.ytimg.com/vi/hmWh0thXUbQ/maxresdefault.jpg"
            },
            {
              "id": "453c23c1-b28f-4d29-b1ef-d5d8c18c2bc9",
              "title": "Rendang",
              "price": 55000,
              "description":
                  "chunks of beef stewed in spicy coconut milk and chili gravy, cooked well until dried Other than beef, rendang ayam (chicken rendang), rendang itiak (duck rendang), rendang lokan (mussel rendang), and number of other varieties can be found",
              "ingredients":
                  "coconut, shallots, chilies, turmeric, chili, garlic, Beef, coconut milk, lime, kaffir lime leaves, lime leaves, lemongrass, ",
              "imageUrl":
                  "https://img.okezone.com/content/2023/11/08/298/2916908/resep-rendang-asli-padang-enaknya-bikin-nagih-fXMyM16D9A.jpg"
            },
            {
              "id": "45ecc2cc-d220-4049-88c2-5e37109e924f",
              "title": "Sambal lado tanak",
              "price": 20000,
              "description":
                  "sambal with coconut milk, anchovies, green stinky bean and spices",
              "ingredients":
                  "coconut, shallots, Green chilies, chilies, chili, garlic, anchovies, coconut milk, stinky beans, ",
              "imageUrl":
                  "https://img-global.cpcdn.com/recipes/197c93a33e56af43/680x482cq70/sambalado-tanak-khas-minang-foto-resep-utama.jpg"
            },
            {
              "id": "48ff3e73-d767-4173-bbe8-44ec2b24aa8c",
              "title": "Es campur",
              "price": 20000,
              "description":
                  "cold and sweet dessert concoction of fruit cocktails, coconut, tapioca pearls, grass jellies, etc, and served in shaved ice, syrup and condensed milk",
              "ingredients":
                  "ice, shaved ice, jackfruit, condensed milk, Mixed fruits (coconut, syrup, tapioca pearls, jackfruit), ",
              "imageUrl":
                  "https://cdn0-production-images-kly.akamaized.net/qSxIa6DhH4tSfPQdtDo-0vS-6R8%3D/0x2180%3A3999x4434/1200x675/filters%3Aquality(75)%3Astrip_icc()%3Aformat(jpeg)/kly-media-production/medias/3981507/original/061819300_1648783740-shutterstock_1969134643.jpg"
            },
            {
              "id": "4b0d6510-fbe5-4e96-a7cc-1075187a4da6",
              "title": "Lopek sarikayo",
              "price": 12000,
              "description": "sticky and chewy snack made from glutinous rice",
              "ingredients":
                  "coconut, palm sugar, sugar, Glutinous rice, coconut milk, pandan leaves, ",
              "imageUrl":
                  "https://cdn.yummy.co.id/content-images/images/20210629/OzVenSPIA2FfScBYrXaBjJKx4C8Ehj9o-31363234393435353239d41d8cd98f00b204e9800998ecf8427e.jpg%3Fx-oss-process%3Dimage/resize%2Cw_388%2Ch_388%2Cm_fixed%2Cx-oss-process%3Dimage/format%2Cwebp"
            },
            {
              "id": "57850d96-4146-4fa2-ae94-6b006ae8fabe",
              "title": "Ayam balado",
              "price": 42000,
              "description": "chicken in chili",
              "ingredients":
                  "shallots, tomato, chilies, sugar, chili, garlic, tomatoes, salt, lime, oil, Chicken, red chilies, lime leaves, ",
              "imageUrl":
                  "https://asset.kompas.com/crops/puSCmWekgKRyE5cRP8IWHhIgTsU%3D/0x0%3A1000x667/750x500/data/photo/2023/02/22/63f567b4ab9d0.jpeg"
            },
            {
              "id": "70b131b5-764a-400a-9167-11330e603199",
              "title": "Talua balado",
              "price": 20000,
              "description": "egg in chili",
              "ingredients":
                  "shallots, tomato, chilies, chili, garlic, Eggs, tomatoes, salt, red chilies, ",
              "imageUrl":
                  "https://i.ytimg.com/vi/YuqJFbyruTU/hq720.jpg%3Fsqp%3D-oaymwEhCK4FEIIDSFryq4qpAxMIARUAAAAAGAElAADIQj0AgKJD%26rs%3DAOn4CLAv2tCykPlsWX1Y107QfQYV2Q63DQ"
            },
            {
              "id": "81111c4f-1778-4ea7-997c-6ac7e0ac2253",
              "title": "Ikan Panggang",
              "price": 60000,
              "description":
                  "Grilled fish marinated in traditional Padang spices and served with sambal.",
              "ingredients":
                  "Fish (snapper, shallots, chilies, turmeric, chili, garlic, or other), pepper., salt, mackerel, lime, red chilies, Fish, ",
              "imageUrl":
                  "https://img-global.cpcdn.com/recipes/7e5ace0001a81816/680x482cq70/ikan-bakar-khas-minang-foto-resep-utama.jpg"
            },
            {
              "id": "ab01df10-2430-4eaa-80a6-7590b7742a42",
              "title": "Lele goreng",
              "price": 30000,
              "description": "fried catfish",
              "ingredients": "turmeric, Catfish, garlic, salt, oil, ",
              "imageUrl":
                  "https://kurio-img.kurioapps.com/22/09/26/ea665aec-bb3e-4232-9fa2-6b29197a5884.jpg"
            },
            {
              "id": "bbfb883c-a5dd-4945-94bf-6f74e9feb98e",
              "title": "Sambal Teri",
              "price": 25000,
              "description":
                  "Spicy sambal with crispy anchovies, often served as a condiment or side dish.",
              "ingredients":
                  "shallots, sugar., chilies, lime juice, sugar, Dried anchovies, chili, garlic, anchovies, salt, lime, red chilies, ",
              "imageUrl":
                  "https://img-global.cpcdn.com/recipes/51faef764a15a51d/680x482cq70/telor-teri-samba-lado-uok-khas-padang-foto-resep-utama.jpg"
            },
            {
              "id": "db9ae1f2-b556-4a8f-9fb4-effa914fc1eb",
              "title": "Ayam bakar",
              "price": 40000,
              "description": "grilled spicy chicken",
              "ingredients":
                  "shallots, turmeric, tamarind, chili, garlic, kecap manis (sweet soy sauce), salt, oil, Chicken, lemongrass, ",
              "imageUrl":
                  "https://www.sasa.co.id/medias/page_medias/ayam_bakar_lumajang.jpg"
            },
            {
              "id": "f3bf6927-b77a-4221-94fc-b127ddba6732",
              "title": "Martabak kubang",
              "price": 65000,
              "description":
                  "Minangkabau-style of murtabak from Lima Puluh Kota Regency, West Sumatra, It is Arab\u2013Indian\u2013Minangkabau fusion dish",
              "ingredients":
                  "shallots, garlic, oil, ground beef, eggs, curry powder, Dough, ",
              "imageUrl":
                  "https://assets-pergikuliner.com/4LbOxRUPxgiqRbzDwXDkOcxd47g%3D/fit-in/1366x768/smart/filters%3Ano_upscale()https://assets-pergikuliner.com/uploads/image/picture/2268274/picture-1626920552.jpg"
            }
          ]
        },
        {
          "title": "Restoran Soto Garuda",
          "address": "Jl. S. Parman No.110, Padang",
          "district": "Padang Utara",
          "imageUrl":
              "https://lh3.googleusercontent.com/p/AF1QipMaf1P8Ob1gE_16cNYdWpxo5eS4n8pLsirI9U8m=s1360-w1360-h1020",
          "foodsInTheRestaurant": [
            {
              "id": "32ad8811-eb5c-4487-ac02-4de510ddfdb4",
              "title": "Kacang Tojin",
              "price": 12000,
              "description": "fried peanuts seasoned with salt and garlic",
              "ingredients":
                  "Coconut milk, Cooking oil, Tamarind paste, Sugar, Water, oil, peanuts, Raw peanuts, Salt, Chili powder (optional), ",
              "imageUrl":
                  "https://img.lazcdn.com/g/p/c1d18da429c2dce178f52d5b0eb93856.jpg_960x960q80.jpg_.webp"
            },
            {
              "id": "32bdd010-c70f-4ccf-8931-877398ceebd8",
              "title": "Gulai limpo",
              "price": 36000,
              "description": "gulai of cow spleen",
              "ingredients":
                  "coconut, shallots, turmeric, Cow spleen, garlic, salt, coconut milk, lime, kaffir lime leaves, lime leaves, lemongrass, ",
              "imageUrl":
                  "https://upload.wikimedia.org/wikipedia/commons/f/fd/Gulai_Limpo.jpg"
            },
            {
              "id": "3a4ba9ed-dd6c-4bbc-bfae-7faf76e5ca88",
              "title": "Soto",
              "price": 35000,
              "description":
                  "traditional soup mainly composed of broth, meat and vegetables",
              "ingredients":
                  "Meat, broth (spices like turmeric, turmeric, garlic, ginger, ginger), vegetables, broth, ",
              "imageUrl":
                  "https://giwang.sumselprov.go.id/api/uploads/kuliner/kuliner_168860841064729.jpg"
            },
            {
              "id": "453c23c1-b28f-4d29-b1ef-d5d8c18c2bc9",
              "title": "Rendang",
              "price": 55000,
              "description":
                  "chunks of beef stewed in spicy coconut milk and chili gravy, cooked well until dried Other than beef, rendang ayam (chicken rendang), rendang itiak (duck rendang), rendang lokan (mussel rendang), and number of other varieties can be found",
              "ingredients":
                  "coconut, shallots, chilies, turmeric, chili, garlic, Beef, coconut milk, lime, kaffir lime leaves, lime leaves, lemongrass, ",
              "imageUrl":
                  "https://img.okezone.com/content/2023/11/08/298/2916908/resep-rendang-asli-padang-enaknya-bikin-nagih-fXMyM16D9A.jpg"
            },
            {
              "id": "455c2fd4-e155-4a78-b781-85a8656b29ba",
              "title": "Keripik balado",
              "price": 18000,
              "description":
                  "cassava cracker coated with hot and sweet chilli paste",
              "ingredients":
                  "Cassava, shallots, sugar, chili, garlic, chili paste, oil, red chili paste, ",
              "imageUrl":
                  "https://media.tampang.com/tm_images/article/202406/desain-tanpaw4x7xw6e0svoqte3.jpg"
            },
            {
              "id": "48ff3e73-d767-4173-bbe8-44ec2b24aa8c",
              "title": "Es campur",
              "price": 20000,
              "description":
                  "cold and sweet dessert concoction of fruit cocktails, coconut, tapioca pearls, grass jellies, etc, and served in shaved ice, syrup and condensed milk",
              "ingredients":
                  "ice, shaved ice, jackfruit, condensed milk, Mixed fruits (coconut, syrup, tapioca pearls, jackfruit), ",
              "imageUrl":
                  "https://cdn0-production-images-kly.akamaized.net/qSxIa6DhH4tSfPQdtDo-0vS-6R8%3D/0x2180%3A3999x4434/1200x675/filters%3Aquality(75)%3Astrip_icc()%3Aformat(jpeg)/kly-media-production/medias/3981507/original/061819300_1648783740-shutterstock_1969134643.jpg"
            },
            {
              "id": "4e34eb2d-f267-4730-a83a-5555a93bff9d",
              "title": "Nasi briyani",
              "price": 55000,
              "description":
                  "flavoured rice dish cooked or served with mutton, chicken, vegetable or fish curry",
              "ingredients":
                  "onion, mutton or chicken, Basmati rice, onions, garlic, ginger, ghee, cardamom, cloves, saffron, yogurt, cinnamon, ",
              "imageUrl":
                  "https://asset.kompas.com/crops/EJ28d4wVrYLoSBWzdnd_mQjbQyY%3D/0x183%3A750x683/750x500/data/photo/2022/07/01/62be3c8565e3c.jpeg"
            },
            {
              "id": "4ed19b4d-53b4-49f8-95ed-5a6bf1c0fef5",
              "title": "Dendeng balado",
              "price": 52000,
              "description": "thin crispy beef with chili",
              "ingredients":
                  "shallots, tomato, chilies, chili, garlic, tomatoes, salt, lime, oil, red chilies, Thin beef slices, lime leaves, ",
              "imageUrl":
                  "https://www.sasa.co.id/medias/page_medias/resep_dendeng_balado.jpg"
            },
            {
              "id": "7272e012-c3f3-4fb6-a22e-922ef7a57aa4",
              "title": "Sarikayo",
              "price": 12000,
              "description":
                  "jam made from a base of coconut milk, eggs and sugar",
              "ingredients": "palm sugar, sugar, eggs, pandan leaves, ",
              "imageUrl":
                  "https://ik.imagekit.io/goodid/gnfi/uploads/articles/large-img-20231106-093401-522787279d1f999ca516090844961d37.jpg"
            },
            {
              "id": "80b1db42-cf77-4bb5-ae3a-a7df954cc7e2",
              "title": "Peyek",
              "price": 12000,
              "description": "deep-fried savoury crackers",
              "ingredients":
                  "Flour, water, garlic, salt, oil, peanuts, coriander, ",
              "imageUrl":
                  "https://awsimages.detik.net.id/community/media/visual/2021/11/09/peyek-kacang_169.jpeg%3Fw%3D600%26q%3D90"
            },
            {
              "id": "96e806ae-b6d3-44af-98c2-b620e3a888db",
              "title": "Gulai tambusu",
              "price": 38000,
              "description":
                  "gulai of cow intestines usually filled with eggs and tofu",
              "ingredients":
                  "coconut, chilies, turmeric, tofu, chili, garlic, coconut milk, lime, eggs, kaffir lime leaves, Cow intestines, lime leaves, lemongrass, ",
              "imageUrl":
                  "https://asset.kompas.com/crops/bcpcDBgw82mDYr495vYWQBLff4A%3D/0x352%3A667x797/750x500/data/photo/2022/08/12/62f5e26894a4f.jpg"
            },
            {
              "id": "a61eb40c-7f9a-473d-9455-4725393142dc",
              "title": "Ayam bumbu",
              "price": 41000,
              "description": "chicken with spices",
              "ingredients":
                  "cumin, coconut, shallots, turmeric, garlic, ginger, salt, coconut milk, oil, Chicken, coriander, ",
              "imageUrl":
                  "https://static.promediateknologi.id/crop/0x0%3A0x0/0x0/webp/photo/p2/74/2024/05/01/3c47eeba484ca5b1b586d8b374aba571-906762525.jpg"
            },
            {
              "id": "a6d45a69-80c9-4c29-970d-6576322ab563",
              "title": "Gulai kepala ikan",
              "price": 48000,
              "description": "fish head gulai",
              "ingredients":
                  "coconut, shallots, turmeric, garlic, salt, coconut milk, lime, kaffir lime leaves, Fish head, lime leaves, Fish, lemongrass, ",
              "imageUrl":
                  "https://cdn.idntimes.com/content-images/community/2021/10/fromandroid-f2a4fb48c1f2c9948243bd190a3c71c6.jpg"
            },
            {
              "id": "a7b30d67-4fd0-4bc9-83a6-a22656518814",
              "title": "Udang balado",
              "price": 45000,
              "description": "shrimp in chili",
              "ingredients":
                  "shallots, tomato, chilies, Shrimp, chili, garlic, tomatoes, salt, lime, red chilies, lime leaves, ",
              "imageUrl":
                  "https://cdn.idntimes.com/content-images/community/2023/05/screenshot-20230516-173843-instagram-d3d5f7bf15788283d4d39394399f0745.jpg"
            },
            {
              "id": "bd2b1296-85d8-4db1-9dba-a0b61d22a0a7",
              "title": "Nasi kari or nasi gulai",
              "price": 40000,
              "description": "rice and curry",
              "ingredients":
                  "coconut, shallots, chilies, turmeric, chili, garlic, coconut milk, Rice, lemongrass, ",
              "imageUrl":
                  "https://media-cdn.tripadvisor.com/media/photo-s/1a/df/23/db/nasi-padang-ayam-gulai.jpg"
            },
            {
              "id": "db9ae1f2-b556-4a8f-9fb4-effa914fc1eb",
              "title": "Ayam bakar",
              "price": 40000,
              "description": "grilled spicy chicken",
              "ingredients":
                  "shallots, turmeric, tamarind, chili, garlic, kecap manis (sweet soy sauce), salt, oil, Chicken, lemongrass, ",
              "imageUrl":
                  "https://www.sasa.co.id/medias/page_medias/ayam_bakar_lumajang.jpg"
            },
            {
              "id": "ddbf80f4-772b-45d5-9b18-6ffcd400dd4f",
              "title": "Es ampiang dadiah",
              "price": 20000,
              "description":
                  "Minang yogurt served with shaved ice and palm sugar",
              "ingredients":
                  "ice, rice Flour, shaved ice, Flour, palm sugar, sugar, Buffalo milk (fermented), ",
              "imageUrl":
                  "https://cdn.idntimes.com/content-images/community/2021/01/119657646-3525199824196675-1505695841977428848-n-0b2e3fe55c98e8dc089991ca6127b017-593497de0889f8a23280afeda9c8d205_600x400.jpg"
            }
          ]
        },
        {
          "title": "Rumah Makan VII Koto Talago",
          "address": "Jl. Jhoni Anwar No.Kelurahan No.17, Padang",
          "district": "Padang Utara",
          "imageUrl":
              "https://lh3.googleusercontent.com/p/AF1QipMfCv5oU_RRNSg_BgK9lA9FLaMSABN1CUDTAO0S=s680-w680-h510",
          "foodsInTheRestaurant": [
            {
              "id": "3a4ba9ed-dd6c-4bbc-bfae-7faf76e5ca88",
              "title": "Soto",
              "price": 35000,
              "description":
                  "traditional soup mainly composed of broth, meat and vegetables",
              "ingredients":
                  "Meat, broth (spices like turmeric, turmeric, garlic, ginger, ginger), vegetables, broth, ",
              "imageUrl":
                  "https://giwang.sumselprov.go.id/api/uploads/kuliner/kuliner_168860841064729.jpg"
            },
            {
              "id": "3c0c832e-ac22-4975-967c-95d40e7caf97",
              "title": "Roti tisu",
              "price": 16000,
              "description": "thinner version of the traditional roti canai",
              "ingredients": "Flour, water, ghee, oil or ghee, oil, ",
              "imageUrl":
                  "https://cdn.tasteatlas.com/images/dishes/1414b9c07a7d45f293798254e59f2b5b.jpg%3Fw%3D600"
            },
            {
              "id": "3fb1020a-4675-4cb0-9189-b16b24d94407",
              "title": "Gulai udang",
              "price": 48000,
              "description": "shrimp gulai",
              "ingredients":
                  "coconut, shallots, Shrimp, turmeric, garlic, salt, coconut milk, lime, kaffir lime leaves, lime leaves, lemongrass, ",
              "imageUrl":
                  "https://cdn-brilio-net.akamaized.net/news/2021/08/18/211860/1544238-1000xauto-resep-gulai-udang.jpg"
            },
            {
              "id": "4450880a-a28a-4949-8b2c-77781029c613",
              "title": "Dendeng",
              "price": 50000,
              "description": "thinly sliced dried meat",
              "ingredients": "tamarind, garlic, salt, Beef, oil, coriander, ",
              "imageUrl":
                  "https://encrypted-tbn0.gstatic.com/images%3Fq%3Dtbn%3AANd9GcSiBNMWYvpmCt1h1cajjZXjk-o_lv3e2NwtoA%26s"
            },
            {
              "id": "6d0a88e5-8afa-4eb3-b4de-c3cc9b4ce0ab",
              "title": "Sambalado",
              "price": 20000,
              "description":
                  "chili paste similar to sambal with large sliced chili pepper, usually stir fried together with main ingredients",
              "ingredients":
                  "shallots, tomato, sugar, garlic, tomatoes, salt, oil, Chilies, ",
              "imageUrl":
                  "https://static.promediateknologi.id/crop/0x0%3A0x0/0x0/webp/photo/p2/131/2023/12/12/sambal-bawang-3278993492.jpg"
            },
            {
              "id": "7272e012-c3f3-4fb6-a22e-922ef7a57aa4",
              "title": "Sarikayo",
              "price": 12000,
              "description":
                  "jam made from a base of coconut milk, eggs and sugar",
              "ingredients": "palm sugar, sugar, eggs, pandan leaves, ",
              "imageUrl":
                  "https://ik.imagekit.io/goodid/gnfi/uploads/articles/large-img-20231106-093401-522787279d1f999ca516090844961d37.jpg"
            },
            {
              "id": "95c2fa2a-8f8f-4c72-ad10-d56c0c9d7bb7",
              "title": "Palai",
              "price": 28000,
              "description": "Minangkabau variants of pepes",
              "ingredients":
                  "coconut, shallots, turmeric, garlic, grated coconut, banana leaves, Fish, ",
              "imageUrl":
                  "https://img-global.cpcdn.com/recipes/f548101c11ec0f35/680x482cq70/resep-palai-bada-khas-minang-foto-resep-utama.jpg"
            },
            {
              "id": "a61eb40c-7f9a-473d-9455-4725393142dc",
              "title": "Ayam bumbu",
              "price": 41000,
              "description": "chicken with spices",
              "ingredients":
                  "cumin, coconut, shallots, turmeric, garlic, ginger, salt, coconut milk, oil, Chicken, coriander, ",
              "imageUrl":
                  "https://static.promediateknologi.id/crop/0x0%3A0x0/0x0/webp/photo/p2/74/2024/05/01/3c47eeba484ca5b1b586d8b374aba571-906762525.jpg"
            },
            {
              "id": "b820cb02-ce8d-4092-a599-f39d6dd9d5cd",
              "title": "Gulai cancang",
              "price": 40000,
              "description": "gulai of meats and cow internal organs",
              "ingredients":
                  "coconut, Meat, chilies, turmeric, chili, garlic, salt, coconut milk, Meat and internal organs, lemongrass, ",
              "imageUrl":
                  "https://nnc-media.netralnews.com/IMG-Netral-News-Admin-35-I2FNWD19UL.jpg"
            },
            {
              "id": "bd4434a5-4488-4d53-a477-9b542f5aec34",
              "title": "Gulai kepala ikan kakap merah",
              "price": 50000,
              "description": "red snapper's head gulai",
              "ingredients":
                  "coconut, chilies, turmeric, chili, garlic, salt, coconut milk, lime, kaffir lime leaves, Red snapper's head, lime leaves, lemongrass, ",
              "imageUrl":
                  "https://img-global.cpcdn.com/recipes/2d402f7844250193/1360x964cq70/gulai-kepala-ikan-kakap-merah-foto-resep-utama.webp"
            },
            {
              "id": "c1d8ebb6-dcaf-4931-943f-37def1697625",
              "title": "Serabi",
              "price": 14000,
              "description":
                  "traditional pancake that is made from rice flour with coconut milk or shredded coconut",
              "ingredients":
                  "coconut, Rice Flour, Flour, coconut milk, Rice, pandan leaves, ",
              "imageUrl": "https://i.ytimg.com/vi/DkgrqXLYgso/sddefault.jpg"
            },
            {
              "id": "db9ae1f2-b556-4a8f-9fb4-effa914fc1eb",
              "title": "Ayam bakar",
              "price": 40000,
              "description": "grilled spicy chicken",
              "ingredients":
                  "shallots, turmeric, tamarind, chili, garlic, kecap manis (sweet soy sauce), salt, oil, Chicken, lemongrass, ",
              "imageUrl":
                  "https://www.sasa.co.id/medias/page_medias/ayam_bakar_lumajang.jpg"
            },
            {
              "id": "e74c9cba-68fc-4dea-8059-c85725d52e85",
              "title": "Cumi Saus Padang",
              "price": 45000,
              "description":
                  "squid cooked in a spicy Padang-style sauce of chili, garlic, and spices",
              "ingredients":
                  "Shallots, Lime juice, chilies, Black pepper, Cooking oil, chili, Garlic, Water, oil, Shallots (sliced), Sweet soy sauce, Salt, Garlic (minced), Squid, Red chilies (sliced), Tomato sauce, ",
              "imageUrl":
                  "https://www.blibli.com/friends-backend/wp-content/uploads/2023/03/B300019-Cover-resep-cumi-saus-padang-scaled.jpg"
            },
            {
              "id": "fe70d1d1-2fb3-4a06-9bbf-6b80bd343f59",
              "title": "Roti jala",
              "price": 18000,
              "description":
                  "the name is derived from the Malay word roti (bread) and jala (net) A special ladle with a five-hole perforation used to make the bread looks like a fish net, It is usually eaten as an accompaniment to a curried dish, or served as a sweet with serawa, Serawa is made from a mixture of boiled coconut milk, brown sugar and pandan leaves",
              "ingredients":
                  "coconut, Flour, water, coconut milk, eggs, pandan leaves, ",
              "imageUrl":
                  "https://www.tokomesin.com/wp-content/uploads/2017/10/roti-jala-kari-ayam.jpg"
            }
          ]
        },
        {
          "title": "Sate Itjap",
          "address": "Jl. Rasuna Said No. 99",
          "district": "Padang Utara",
          "imageUrl":
              "https://lh5.googleusercontent.com/p/AF1QipPQ7cTJCirxUJoDRrlmlgHUu08kCGtFv5fen4Ve=w480-h240-k-no",
          "foodsInTheRestaurant": [
            {
              "id": "19d6c0f0-5876-4cb8-b230-9bd1f0083f92",
              "title": "Cindua",
              "price": 20000,
              "description":
                  "sweet dessert that contains droplets of green rice flour jelly, mixed of lupis, durian, ampiang, and doused with palm sugar",
              "ingredients":
                  "ice, Rice Flour, shaved ice, Flour, palm sugar, sugar, lupis, durian, Rice Flour jelly, Rice, ",
              "imageUrl":
                  "https://i0.wp.com/langgam.id/wp-content/uploads/2021/05/InShot_20210508_143837953_compress98.jpg%3Ffit%3D1440%252C960%26ssl%3D1"
            },
            {
              "id": "3afb4d62-29f8-43c3-8dd9-509075e88e2c",
              "title": "Sate padang",
              "price": 40000,
              "description":
                  "Padang-style of satay, skewered barbecued meat with thick yellow sauce",
              "ingredients":
                  "thick sauce (rice Flour-based), Meat, shallots, Flour, turmeric, garlic, lemongrass, ",
              "imageUrl": "https://i.ytimg.com/vi/hmWh0thXUbQ/maxresdefault.jpg"
            },
            {
              "id": "41057284-329a-4581-a414-5b026d67b379",
              "title": "Gulai kambiang",
              "price": 55000,
              "description": "mutton gulai",
              "ingredients":
                  "coconut, chilies, Mutton, turmeric, chili, garlic, salt, coconut milk, lime, kaffir lime leaves, lime leaves, lemongrass, ",
              "imageUrl":
                  "https://img.kurio.network/rLAunDR1yIriIhbbSXwU9dIazcY%3D/440x440/filters%3Aquality(80)https://kurio-img.kurioapps.com/22/07/11/3f999767-b8cd-4412-8bf2-6d007cb39cc2.jpg"
            },
            {
              "id": "4ed19b4d-53b4-49f8-95ed-5a6bf1c0fef5",
              "title": "Dendeng balado",
              "price": 52000,
              "description": "thin crispy beef with chili",
              "ingredients":
                  "shallots, tomato, chilies, chili, garlic, tomatoes, salt, lime, oil, red chilies, Thin beef slices, lime leaves, ",
              "imageUrl":
                  "https://www.sasa.co.id/medias/page_medias/resep_dendeng_balado.jpg"
            },
            {
              "id": "6d340647-dad4-4c40-8134-c23cef70a1d7",
              "title": "Satay daging",
              "price": 45000,
              "description":
                  "dish of seasoned, skewered and grilled meat, served with a sauce",
              "ingredients":
                  "shallots, garlic, sweet soy sauce, Beef, skewers, ",
              "imageUrl":
                  "https://gerobaksate.my/serikembangan/wp-content/uploads/sites/32/2023/10/sate-daging-2.jpg"
            },
            {
              "id": "796b4623-ba58-47f5-9ddc-0a0b84ba0391",
              "title": "Gulai sumsum",
              "price": 37000,
              "description": "gulai of cow bone marrow",
              "ingredients":
                  "coconut, shallots, chilies, turmeric, chili, garlic, Cow bone marrow, coconut milk, lemongrass, ",
              "imageUrl":
                  "https://assets.promediateknologi.id/crop/9x487%3A1379x1471/750x500/webp/photo/2023/07/09/gulai-sumsum-4142063430.jpg"
            },
            {
              "id": "87acde46-8155-4e6a-85d1-261534cf6bd5",
              "title": "Udang Saus Padang",
              "price": 50000,
              "description":
                  "shrimp cooked in a spicy Padang-style sauce of chili, garlic, and spices",
              "ingredients":
                  "Shallots, Lime juice, Prawns, chilies, Black pepper, Cooking oil, chili, Garlic, Water, oil, Shallots (sliced), Sweet soy sauce, Salt, Garlic (minced), Red chilies (sliced), Tomato sauce, ",
              "imageUrl":
                  "https://lezatpedia.id/wp-content/uploads/2023/08/resep-udang-saus-padang-sederhana-dan-mudah.webp"
            },
            {
              "id": "a6d45a69-80c9-4c29-970d-6576322ab563",
              "title": "Gulai kepala ikan",
              "price": 48000,
              "description": "fish head gulai",
              "ingredients":
                  "coconut, shallots, turmeric, garlic, salt, coconut milk, lime, kaffir lime leaves, Fish head, lime leaves, Fish, lemongrass, ",
              "imageUrl":
                  "https://cdn.idntimes.com/content-images/community/2021/10/fromandroid-f2a4fb48c1f2c9948243bd190a3c71c6.jpg"
            },
            {
              "id": "b7b01f69-e246-4fa8-b32e-d64388844c87",
              "title": "Kalio Daging",
              "price": 45000,
              "description":
                  "similar to rendang; while rendang is rather dry, kalio is watery and light-colored",
              "ingredients":
                  "coconut, shallots, chilies, turmeric, chili, garlic, Beef, coconut milk, lime, kaffir lime leaves, Beef (or other meat), lime leaves, lemongrass, ",
              "imageUrl":
                  "https://i.ytimg.com/vi/5yOqx_wRcLk/hq720.jpg%3Fsqp%3D-oaymwEhCK4FEIIDSFryq4qpAxMIARUAAAAAGAElAADIQj0AgKJD%26rs%3DAOn4CLDx9t5odrM5TA0JReDbmi7D-IqVCw"
            },
            {
              "id": "b820cb02-ce8d-4092-a599-f39d6dd9d5cd",
              "title": "Gulai cancang",
              "price": 40000,
              "description": "gulai of meats and cow internal organs",
              "ingredients":
                  "coconut, Meat, chilies, turmeric, chili, garlic, salt, coconut milk, Meat and internal organs, lemongrass, ",
              "imageUrl":
                  "https://nnc-media.netralnews.com/IMG-Netral-News-Admin-35-I2FNWD19UL.jpg"
            },
            {
              "id": "bd398362-701c-44dc-9ff7-59d1adad1953",
              "title": "Roti canai",
              "price": 15000,
              "description":
                  "a thin unleavened bread with a flaky crust, fried on a skillet with oil and served with condiments or curry",
              "ingredients": "Flour, water, ghee, oil, eggs, ghee or oil, ",
              "imageUrl":
                  "https://images.tokopedia.net/img/cache/500-square/VqbcmM/2023/9/11/b33d4570-ca3f-47bd-8686-8b9c409946ab.jpg"
            },
            {
              "id": "db9ae1f2-b556-4a8f-9fb4-effa914fc1eb",
              "title": "Ayam bakar",
              "price": 40000,
              "description": "grilled spicy chicken",
              "ingredients":
                  "shallots, turmeric, tamarind, chili, garlic, kecap manis (sweet soy sauce), salt, oil, Chicken, lemongrass, ",
              "imageUrl":
                  "https://www.sasa.co.id/medias/page_medias/ayam_bakar_lumajang.jpg"
            },
            {
              "id": "f5b8aa37-85fa-4594-818a-b76e06413cac",
              "title": "Petai goreng",
              "price": 18000,
              "description": "fried green stinky bean (Parkia speciosa)",
              "ingredients": "Stinky beans (Parkia speciosa), oil, ",
              "imageUrl":
                  "https://images.tokopedia.net/img/cache/700/VqbcmM/2021/2/11/098d34be-e600-4635-b73b-13c358ab6879.jpg"
            }
          ]
        },
        {
          "title": "Rumah Makan Taman Surya",
          "address": "Jl. Tamansiswa No. 15",
          "district": "Padang Utara",
          "imageUrl":
              "https://lh3.googleusercontent.com/p/AF1QipMucy2GYqlxcQZpn6g9OzG8CXFFHCZYpduAxKE2=s1360-w1360-h1020",
          "foodsInTheRestaurant": [
            {
              "id": "0215db5f-847d-4875-ba7c-6d8136a3c532",
              "title": "Rajungan goreng",
              "price": 70000,
              "description": "crispy fried crab",
              "ingredients": "salt, oil, Crab, ",
              "imageUrl":
                  "https://cdn0-production-images-kly.akamaized.net/b4c9FCwttCcvLjdJ7sned_aS06c%3D/1x40%3A1000x603/1200x675/filters%3Aquality(75)%3Astrip_icc()%3Aformat(jpeg)/kly-media-production/medias/3570968/original/013224500_1631594241-shutterstock_1796323171.jpg"
            },
            {
              "id": "02173c34-d3b4-4f91-b762-8436d510bb63",
              "title": "Gulai paku",
              "price": 25000,
              "description": "fern gulai",
              "ingredients":
                  "coconut, shallots, chilies, turmeric, water, chili, garlic, salt, coconut milk, lime, kaffir lime leaves, Paku, lime leaves, lemongrass, ",
              "imageUrl":
                  "https://img-global.cpcdn.com/recipes/1d34ae7f990bd073/680x482cq70/gulai-pakisgulai-paku-foto-resep-utama.jpg"
            },
            {
              "id": "02274a61-8fc1-4e74-9045-4480764c9da7",
              "title": "Kerupuk jangek",
              "price": 18000,
              "description": "cow's skin krupuk",
              "ingredients": "salt, Cow skin, oil, ",
              "imageUrl":
                  "https://upload.wikimedia.org/wikipedia/commons/b/be/Karupuak_jangek_2.jpg"
            },
            {
              "id": "2a858213-b635-4253-bc19-ba14f78578cd",
              "title": "Gulai ati",
              "price": 35000,
              "description": "gulai of cow liver",
              "ingredients":
                  "coconut, shallots, chilies, turmeric, chili, garlic, Cow liver, salt, coconut milk, lemongrass, ",
              "imageUrl":
                  "https://img-global.cpcdn.com/recipes/093bca8e79bc5ca4/1360x964cq70/gulai-hati-ampela-foto-resep-utama.webp"
            },
            {
              "id": "3afb4d62-29f8-43c3-8dd9-509075e88e2c",
              "title": "Sate padang",
              "price": 40000,
              "description":
                  "Padang-style of satay, skewered barbecued meat with thick yellow sauce",
              "ingredients":
                  "thick sauce (rice Flour-based), Meat, shallots, Flour, turmeric, garlic, lemongrass, ",
              "imageUrl": "https://i.ytimg.com/vi/hmWh0thXUbQ/maxresdefault.jpg"
            },
            {
              "id": "45ecc2cc-d220-4049-88c2-5e37109e924f",
              "title": "Sambal lado tanak",
              "price": 20000,
              "description":
                  "sambal with coconut milk, anchovies, green stinky bean and spices",
              "ingredients":
                  "coconut, shallots, Green chilies, chilies, chili, garlic, anchovies, coconut milk, stinky beans, ",
              "imageUrl":
                  "https://img-global.cpcdn.com/recipes/197c93a33e56af43/680x482cq70/sambalado-tanak-khas-minang-foto-resep-utama.jpg"
            },
            {
              "id": "46c93e82-181d-4371-8e49-9839668dd863",
              "title": "Ikan bilih",
              "price": 38000,
              "description":
                  "fried small freshwater fish of the genus Mystacoleucus",
              "ingredients": "salt, Small freshwater fish, oil, ",
              "imageUrl":
                  "https://packagepadang.com/wp-content/uploads/2023/05/ikan-bilih.jpg"
            },
            {
              "id": "4d9184ef-97c3-44c9-9e54-ee6859680828",
              "title": "Gulai sayua",
              "price": 30000,
              "description":
                  "curry dish with main ingredients vegetables such as cassava leaves and unripe jackfruit",
              "ingredients":
                  "coconut, shallots, chilies, turmeric, water, chili, garlic, salt, coconut milk, lime, oil, Vegetable, kaffir lime leaves, lime leaves, lemongrass, ",
              "imageUrl":
                  "https://akcdn.detik.net.id/community/media/visual/2023/01/01/resep-gulai-aneka-sayuran_43.jpeg%3Fw%3D700%26q%3D90"
            },
            {
              "id": "9dd2d67d-58ec-4122-83ca-efce2e04cc31",
              "title": "Dadiah",
              "price": 18000,
              "description": "fermented buffalo milk akin to yogurt",
              "ingredients": "Fermented buffalo milk, ",
              "imageUrl":
                  "https://indonesiakaya.com/wp-content/uploads/2020/10/5__IMG_3410_Citarasanya_yang_unik_membuat_dadiah_tergolong_kuliner_dengan_peminat_yang_spesifik.jpg"
            },
            {
              "id": "a2e5ca53-04a3-49e3-a623-4e6ee5ec46c9",
              "title": "Satay ayam",
              "price": 35000,
              "description":
                  "dish of seasoned, skewered and grilled chicken, served with a sauce",
              "ingredients":
                  "shallots, garlic, sweet soy sauce, Chicken, skewers, peanut sauce, ",
              "imageUrl":
                  "https://img-global.cpcdn.com/recipes/a6ca9f36b02b089b/680x482cq70/sate-ayam-khas-madura-foto-resep-utama.jpg"
            },
            {
              "id": "a6d45a69-80c9-4c29-970d-6576322ab563",
              "title": "Gulai kepala ikan",
              "price": 48000,
              "description": "fish head gulai",
              "ingredients":
                  "coconut, shallots, turmeric, garlic, salt, coconut milk, lime, kaffir lime leaves, Fish head, lime leaves, Fish, lemongrass, ",
              "imageUrl":
                  "https://cdn.idntimes.com/content-images/community/2021/10/fromandroid-f2a4fb48c1f2c9948243bd190a3c71c6.jpg"
            },
            {
              "id": "ab01df10-2430-4eaa-80a6-7590b7742a42",
              "title": "Lele goreng",
              "price": 30000,
              "description": "fried catfish",
              "ingredients": "turmeric, Catfish, garlic, salt, oil, ",
              "imageUrl":
                  "https://kurio-img.kurioapps.com/22/09/26/ea665aec-bb3e-4232-9fa2-6b29197a5884.jpg"
            },
            {
              "id": "b2146ad8-f45a-426c-9828-16a9ea5ccf1e",
              "title": "Gulai daging",
              "price": 40000,
              "description":
                  "curry dish with main ingredients beef and unripe jackfruit",
              "ingredients":
                  "coconut, Meat, shallots, chilies, turmeric, water, chili, garlic, salt, coconut milk, lime, kaffir lime leaves, lime leaves, lemongrass, ",
              "imageUrl":
                  "https://assets.pikiran-rakyat.com/crop/0x0%3A0x0/750x500/photo/2021/11/25/217085998.jpeg"
            },
            {
              "id": "b820cb02-ce8d-4092-a599-f39d6dd9d5cd",
              "title": "Gulai cancang",
              "price": 40000,
              "description": "gulai of meats and cow internal organs",
              "ingredients":
                  "coconut, Meat, chilies, turmeric, chili, garlic, salt, coconut milk, Meat and internal organs, lemongrass, ",
              "imageUrl":
                  "https://nnc-media.netralnews.com/IMG-Netral-News-Admin-35-I2FNWD19UL.jpg"
            },
            {
              "id": "c80f5b33-16a8-4ead-8301-298f764a5187",
              "title": "Gulai babek",
              "price": 37000,
              "description":
                  "gulai babat, or gulai paruik kabau, gulai of cow tripes",
              "ingredients":
                  "coconut, shallots, chilies, turmeric, chili, garlic, salt, coconut milk, Cow tripe, lemongrass, ",
              "imageUrl":
                  "https://cdn.yummy.co.id/content-images/images/20210731/B6mbbnT8my7I95S8VOzmTgJFrDnQM0Ne-31363237373039383835d41d8cd98f00b204e9800998ecf8427e.jpg%3Fx-oss-process%3Dimage/resize%2Cw_388%2Ch_388%2Cm_fixed%2Cx-oss-process%3Dimage/format%2Cwebp"
            },
            {
              "id": "dbcee8e3-0192-4372-9191-a9d6ec4e4e2b",
              "title": "Ayam Gulai Nangka",
              "price": 50000,
              "description":
                  "Chicken simmered in a spicy coconut curry with young jackfruit.",
              "ingredients":
                  "coconut, chilies, turmeric, bay leaves., bay leaves, jackfruit, chili, coconut milk, Chicken, red chilies, young jackfruit, galangal, lemongrass, ",
              "imageUrl":
                  "https://static.promediateknologi.id/crop/0x0%3A0x0/750x500/webp/photo/p1/1067/2024/05/21/maxresdefault-8-1983884964.jpg"
            },
            {
              "id": "ddbf80f4-772b-45d5-9b18-6ffcd400dd4f",
              "title": "Es ampiang dadiah",
              "price": 20000,
              "description":
                  "Minang yogurt served with shaved ice and palm sugar",
              "ingredients":
                  "ice, rice Flour, shaved ice, Flour, palm sugar, sugar, Buffalo milk (fermented), ",
              "imageUrl":
                  "https://cdn.idntimes.com/content-images/community/2021/01/119657646-3525199824196675-1505695841977428848-n-0b2e3fe55c98e8dc089991ca6127b017-593497de0889f8a23280afeda9c8d205_600x400.jpg"
            },
            {
              "id": "ec0d7ab8-4ba5-4c8d-927d-38981e693d96",
              "title": "Pergedel jaguang",
              "price": 15000,
              "description": "corn fritters",
              "ingredients": "shallots, Flour, garlic, salt, oil, eggs, Corn, ",
              "imageUrl":
                  "https://asset.kompas.com/crops/qiVD1zYxC5A49SsCaE_2hrUR7g0%3D/65x0%3A907x561/750x500/data/photo/2020/11/02/5f9f812b3e9fa.jpg"
            },
            {
              "id": "efab575f-9ca3-4665-83b3-7c639ddf10cf",
              "title": "Kue putu",
              "price": 12000,
              "description":
                  "traditional cylindrical-shaped and green-colored steamed cake",
              "ingredients":
                  "coconut, Rice Flour, Flour, palm sugar, sugar, Rice, pandan leaves, ",
              "imageUrl":
                  "https://cdn.rri.co.id/berita/Bukittinggi/o/1716266719523-1705038382_65a0d22ebe1a1_KraEi35RrXloPGaZ2y2Z/de4ooj24jn7p32r.webp"
            },
            {
              "id": "f5b8aa37-85fa-4594-818a-b76e06413cac",
              "title": "Petai goreng",
              "price": 18000,
              "description": "fried green stinky bean (Parkia speciosa)",
              "ingredients": "Stinky beans (Parkia speciosa), oil, ",
              "imageUrl":
                  "https://images.tokopedia.net/img/cache/700/VqbcmM/2021/2/11/098d34be-e600-4635-b73b-13c358ab6879.jpg"
            }
          ]
        },
        {
          "title": "Rumah Makan Ajo Paris",
          "address": "Jl. S. Parman No.126, Lolong Belanti, Padang",
          "district": "Padang Utara",
          "imageUrl":
              "https://lh3.googleusercontent.com/p/AF1QipOrsLhA2tp3ZC5DM_9s_xDaL-2mOPHFnDpmj2I6=s1360-w1360-h1020",
          "foodsInTheRestaurant": [
            {
              "id": "32bdd010-c70f-4ccf-8931-877398ceebd8",
              "title": "Gulai limpo",
              "price": 36000,
              "description": "gulai of cow spleen",
              "ingredients":
                  "coconut, shallots, turmeric, Cow spleen, garlic, salt, coconut milk, lime, kaffir lime leaves, lime leaves, lemongrass, ",
              "imageUrl":
                  "https://upload.wikimedia.org/wikipedia/commons/f/fd/Gulai_Limpo.jpg"
            },
            {
              "id": "3971eb53-709b-4de6-9e27-8548ff5a6ced",
              "title": "Ayam percik",
              "price": 45000,
              "description": "grilled chicken with a spicy, curry-like sauce",
              "ingredients":
                  "coconut, turmeric, tamarind, chili, garlic, ginger, salt, coconut milk, chili paste, oil, Chicken, lemongrass, ",
              "imageUrl":
                  "https://img-global.cpcdn.com/recipes/f0f4f03bf529383e/680x482cq70/ayam-percik-kelantan-foto-resep-utama.jpg"
            },
            {
              "id": "566c9c92-42b9-4232-8f04-635eb9101745",
              "title": "Dendeng batokok",
              "price": 55000,
              "description": "thin strips of pounded and softened grilled beef",
              "ingredients":
                  "chilies, tamarind, chili, garlic, salt, oil, Thin beef slices, ",
              "imageUrl":
                  "https://www.sasa.co.id/medias/page_medias/resep_dendeng_balado_kering.jpg"
            },
            {
              "id": "6457a926-dd20-4356-8cce-693d8ef65b47",
              "title": "Paru goreng",
              "price": 35000,
              "description": "fried cow lung",
              "ingredients": "turmeric, garlic, salt, oil, Cow lung, ",
              "imageUrl":
                  "https://asset.kompas.com/crops/SExQheJk5IH2hd5zTXUZ5Qkx_Xk%3D/47x14%3A661x424/750x500/data/photo/2022/02/02/61fa7b69e014c.jpeg"
            },
            {
              "id": "6d0a88e5-8afa-4eb3-b4de-c3cc9b4ce0ab",
              "title": "Sambalado",
              "price": 20000,
              "description":
                  "chili paste similar to sambal with large sliced chili pepper, usually stir fried together with main ingredients",
              "ingredients":
                  "shallots, tomato, sugar, garlic, tomatoes, salt, oil, Chilies, ",
              "imageUrl":
                  "https://static.promediateknologi.id/crop/0x0%3A0x0/0x0/webp/photo/p2/131/2023/12/12/sambal-bawang-3278993492.jpg"
            },
            {
              "id": "80b1db42-cf77-4bb5-ae3a-a7df954cc7e2",
              "title": "Peyek",
              "price": 12000,
              "description": "deep-fried savoury crackers",
              "ingredients":
                  "Flour, water, garlic, salt, oil, peanuts, coriander, ",
              "imageUrl":
                  "https://awsimages.detik.net.id/community/media/visual/2021/11/09/peyek-kacang_169.jpeg%3Fw%3D600%26q%3D90"
            },
            {
              "id": "88b0a3d9-c752-45e9-9d96-6dcd4fd36c35",
              "title": "Keripik sanjai",
              "price": 15000,
              "description": "sliced cassava chips",
              "ingredients": "Cassava, salt, oil, ",
              "imageUrl":
                  "https://www.kabarsumbar.com/wp-content/uploads/2021/10/Keripik_singkong_balado_cassava_chips-scaled.jpg"
            },
            {
              "id": "8f1c829c-9241-46b6-bbd4-ab7e98bbf1e5",
              "title": "Es Cendol",
              "price": 20000,
              "description":
                  "iced dessert made from rice flour jelly, coconut milk, and palm sugar syrup",
              "ingredients":
                  "Palm sugar, Coconut milk, Ice cubes, sugar, Water, Cendol, Pandan leaves (optional), ",
              "imageUrl":
                  "https://i.gojekapi.com/darkroom/gofood-indonesia/v2/images/uploads/8ce14a1c-5598-4ead-aeeb-f9112beb96c1_Go-Biz_20230112_223311.jpeg"
            },
            {
              "id": "95c2fa2a-8f8f-4c72-ad10-d56c0c9d7bb7",
              "title": "Palai",
              "price": 28000,
              "description": "Minangkabau variants of pepes",
              "ingredients":
                  "coconut, shallots, turmeric, garlic, grated coconut, banana leaves, Fish, ",
              "imageUrl":
                  "https://img-global.cpcdn.com/recipes/f548101c11ec0f35/680x482cq70/resep-palai-bada-khas-minang-foto-resep-utama.jpg"
            },
            {
              "id": "bffc0e18-3d01-4586-b12b-9b3a27e7d347",
              "title": "Gulai ayam",
              "price": 39000,
              "description": "chicken gulai",
              "ingredients":
                  "coconut, shallots, turmeric, garlic, salt, coconut milk, lime, Chicken, kaffir lime leaves, lime leaves, lemongrass, ",
              "imageUrl":
                  "https://asset.kompas.com/crops/4Pge4o-1NYVqjBcfiXvB2nAJcnM%3D/0x0%3A1000x667/750x500/data/photo/2021/05/11/609a26028d3c9.jpg"
            },
            {
              "id": "d180492c-c47b-4259-8e24-042a2ee22b99",
              "title": "Galamai",
              "price": 15000,
              "description":
                  "sweets made of rice flour, palm sugar and coconut milk, This snack similar to dodol",
              "ingredients":
                  "coconut, Rice Flour, Flour, palm sugar, sugar, coconut milk, Rice, ",
              "imageUrl":
                  "https://www.randangrajorajo.com/wp-content/uploads/2023/03/3328159348.webp"
            }
          ]
        },
        {
          "title": "Rumah Makan Bernama",
          "address": "Jl. S. Parman No.114, Lolong Belanti, Padang",
          "district": "Padang Utara",
          "imageUrl":
              "https://lh3.googleusercontent.com/p/AF1QipMI6RM8susMwHgYoQeilFryA6ZakJRxMxmGIHnR=s1360-w1360-h1020",
          "foodsInTheRestaurant": [
            {
              "id": "0215db5f-847d-4875-ba7c-6d8136a3c532",
              "title": "Rajungan goreng",
              "price": 70000,
              "description": "crispy fried crab",
              "ingredients": "salt, oil, Crab, ",
              "imageUrl":
                  "https://cdn0-production-images-kly.akamaized.net/b4c9FCwttCcvLjdJ7sned_aS06c%3D/1x40%3A1000x603/1200x675/filters%3Aquality(75)%3Astrip_icc()%3Aformat(jpeg)/kly-media-production/medias/3570968/original/013224500_1631594241-shutterstock_1796323171.jpg"
            },
            {
              "id": "02e97b94-e8b6-4b47-9c51-ddd40a974796",
              "title": "Lupis",
              "price": 13000,
              "description":
                  "sweet cake made of glutinous rice, banana leaves, coconut, and palm sugar sauce",
              "ingredients":
                  "coconut, palm sugar, sugar, Glutinous rice, banana leaves, ",
              "imageUrl":
                  "https://serikatnews.com/wp-content/uploads/2023/09/cook-pad7.jpg"
            },
            {
              "id": "2a858213-b635-4253-bc19-ba14f78578cd",
              "title": "Gulai ati",
              "price": 35000,
              "description": "gulai of cow liver",
              "ingredients":
                  "coconut, shallots, chilies, turmeric, chili, garlic, Cow liver, salt, coconut milk, lemongrass, ",
              "imageUrl":
                  "https://img-global.cpcdn.com/recipes/093bca8e79bc5ca4/1360x964cq70/gulai-hati-ampela-foto-resep-utama.webp"
            },
            {
              "id": "32ad8811-eb5c-4487-ac02-4de510ddfdb4",
              "title": "Kacang Tojin",
              "price": 12000,
              "description": "fried peanuts seasoned with salt and garlic",
              "ingredients":
                  "Coconut milk, Cooking oil, Tamarind paste, Sugar, Water, oil, peanuts, Raw peanuts, Salt, Chili powder (optional), ",
              "imageUrl":
                  "https://img.lazcdn.com/g/p/c1d18da429c2dce178f52d5b0eb93856.jpg_960x960q80.jpg_.webp"
            },
            {
              "id": "4ed19b4d-53b4-49f8-95ed-5a6bf1c0fef5",
              "title": "Dendeng balado",
              "price": 52000,
              "description": "thin crispy beef with chili",
              "ingredients":
                  "shallots, tomato, chilies, chili, garlic, tomatoes, salt, lime, oil, red chilies, Thin beef slices, lime leaves, ",
              "imageUrl":
                  "https://www.sasa.co.id/medias/page_medias/resep_dendeng_balado.jpg"
            },
            {
              "id": "7ac01c8d-deee-46ca-9c12-9edc48ba56fa",
              "title": "Gulai jariang",
              "price": 34000,
              "description": "jengkol stinky bean gulai",
              "ingredients":
                  "coconut, chilies, turmeric, Jengkol (stinky beans), chili, garlic, salt, coconut milk, lime, kaffir lime leaves, lime leaves, lemongrass, ",
              "imageUrl":
                  "https://bimamedia-gurusiana.ap-south-1.linodeobjects.com/63f3a0d84155cf94b757c01c3c8ba2f8/2021/01/31/l-kalio-jariangjpg20210131140742.jpeg"
            },
            {
              "id": "81111c4f-1778-4ea7-997c-6ac7e0ac2253",
              "title": "Ikan Panggang",
              "price": 60000,
              "description":
                  "Grilled fish marinated in traditional Padang spices and served with sambal.",
              "ingredients":
                  "Fish (snapper, shallots, chilies, turmeric, chili, garlic, or other), pepper., salt, mackerel, lime, red chilies, Fish, ",
              "imageUrl":
                  "https://img-global.cpcdn.com/recipes/7e5ace0001a81816/680x482cq70/ikan-bakar-khas-minang-foto-resep-utama.jpg"
            },
            {
              "id": "8adf2419-584e-4067-bf7a-b77205399cba",
              "title": "Ayam pop rebus",
              "price": 43000,
              "description": "Padang-style chicken, boiled/steamed.",
              "ingredients":
                  "coconut, shallots, bay leaves, water, garlic, salt, lime, oil, Chicken, coconut water, lime leaves, ",
              "imageUrl":
                  "https://assets.promediateknologi.id/crop/0x0%3A0x0/750x500/webp/photo/p1/364/2023/09/11/ayam-pop-1758146136.jpg"
            },
            {
              "id": "9e949d0b-f83e-4512-8ce0-bf62ba5fee88",
              "title": "Ayam kurma",
              "price": 16000,
              "description":
                  "chicken slowly cooked in a rich and aromatic coconut and kurma (date) sauce.",
              "ingredients":
                  "onion, turmeric, chili, garlic, ginger, kurma (dates), oil, Chicken, coriander, chili peppers, lemongrass, ",
              "imageUrl":
                  "https://img-global.cpcdn.com/recipes/86fd40ff2496de0f/1360x964cq70/gulai-korma-khas-minang-versi-ayam-foto-resep-utama.webp"
            },
            {
              "id": "a7b30d67-4fd0-4bc9-83a6-a22656518814",
              "title": "Udang balado",
              "price": 45000,
              "description": "shrimp in chili",
              "ingredients":
                  "shallots, tomato, chilies, Shrimp, chili, garlic, tomatoes, salt, lime, red chilies, lime leaves, ",
              "imageUrl":
                  "https://cdn.idntimes.com/content-images/community/2023/05/screenshot-20230516-173843-instagram-d3d5f7bf15788283d4d39394399f0745.jpg"
            },
            {
              "id": "d1adc396-741d-4feb-b8f4-b4836714f996",
              "title": "Nasi kapau",
              "price": 45000,
              "description":
                  "steamed rice topped with various choices of dishes originated from Bukittinggi, West Sumatra",
              "ingredients": "various dishes, Rice, ",
              "imageUrl":
                  "https://i0.wp.com/resepkoki.id/wp-content/uploads/2020/12/Resep-Nasi-Kapau.jpg%3Ffit%3D1080%252C1440%26ssl%3D1"
            },
            {
              "id": "e74c9cba-68fc-4dea-8059-c85725d52e85",
              "title": "Cumi Saus Padang",
              "price": 45000,
              "description":
                  "squid cooked in a spicy Padang-style sauce of chili, garlic, and spices",
              "ingredients":
                  "Shallots, Lime juice, chilies, Black pepper, Cooking oil, chili, Garlic, Water, oil, Shallots (sliced), Sweet soy sauce, Salt, Garlic (minced), Squid, Red chilies (sliced), Tomato sauce, ",
              "imageUrl":
                  "https://www.blibli.com/friends-backend/wp-content/uploads/2023/03/B300019-Cover-resep-cumi-saus-padang-scaled.jpg"
            }
          ]
        }
      ]
    },
    {
      "title": "Pauh",
      "imageUrl":
          "https://lh5.googleusercontent.com/p/AF1QipNpQE2jm9yWKsEmqpcPCTYy-HvIWfIPvOJsWTuP=w408-h271-k-no",
      "trivia":
          "Kecamatan ini terkenal dengan institusi pendidikannya dan merupakan rumah bagi Fakultas Kedokteran Universitas Andalas",
      "restaurantsInTheDistrict": [
        {
          "title": "Sari Bundo",
          "address": "Jl. Piai 3C4C+4JQ, Padang",
          "district": "Pauh",
          "imageUrl":
              "https://lh3.googleusercontent.com/p/AF1QipOelS-I3bmglDOPi5yLeND6D9acgT1Q6wnZRvMK=s1360-w1360-h1020",
          "foodsInTheRestaurant": [
            {
              "id": "02173c34-d3b4-4f91-b762-8436d510bb63",
              "title": "Gulai paku",
              "price": 25000,
              "description": "fern gulai",
              "ingredients":
                  "coconut, shallots, chilies, turmeric, water, chili, garlic, salt, coconut milk, lime, kaffir lime leaves, Paku, lime leaves, lemongrass, ",
              "imageUrl":
                  "https://img-global.cpcdn.com/recipes/1d34ae7f990bd073/680x482cq70/gulai-pakisgulai-paku-foto-resep-utama.jpg"
            },
            {
              "id": "02274a61-8fc1-4e74-9045-4480764c9da7",
              "title": "Kerupuk jangek",
              "price": 18000,
              "description": "cow's skin krupuk",
              "ingredients": "salt, Cow skin, oil, ",
              "imageUrl":
                  "https://upload.wikimedia.org/wikipedia/commons/b/be/Karupuak_jangek_2.jpg"
            },
            {
              "id": "0aa137f9-3f93-44d1-b1bb-4a5d3f0d42a3",
              "title": "Kalio Ayam",
              "price": 35000,
              "description":
                  "similar to rendang; while rendang is rather dry, kalio is watery and light-colored",
              "ingredients":
                  "Shallots, Turmeric, Coconut milk, chilies, Cooking oil, chili, Ginger (sliced), Garlic, Lemongrass, Sugar, Water, oil, Shallots (sliced), Chicken, Salt, Garlic (minced), Red chilies (sliced), ",
              "imageUrl":
                  "https://asset.kompas.com/crops/mCb4rnN344JdAyqQs9i1IJWktRU%3D/0x379%3A667x823/750x500/data/photo/2021/05/11/609a2c750cdc5.jpg"
            },
            {
              "id": "0e2f036f-36cd-49fa-a70c-436e38bca75c",
              "title": "Gulai talua",
              "price": 30000,
              "description": "boiled eggs gulai",
              "ingredients":
                  "coconut, shallots, chilies, turmeric, chili, garlic, coconut milk, Boiled eggs, eggs, lemongrass, ",
              "imageUrl": "https://i.ytimg.com/vi/AU1czt1_Cz8/mqdefault.jpg"
            },
            {
              "id": "3a4ba9ed-dd6c-4bbc-bfae-7faf76e5ca88",
              "title": "Soto",
              "price": 35000,
              "description":
                  "traditional soup mainly composed of broth, meat and vegetables",
              "ingredients":
                  "Meat, broth (spices like turmeric, turmeric, garlic, ginger, ginger), vegetables, broth, ",
              "imageUrl":
                  "https://giwang.sumselprov.go.id/api/uploads/kuliner/kuliner_168860841064729.jpg"
            },
            {
              "id": "4450880a-a28a-4949-8b2c-77781029c613",
              "title": "Dendeng",
              "price": 50000,
              "description": "thinly sliced dried meat",
              "ingredients": "tamarind, garlic, salt, Beef, oil, coriander, ",
              "imageUrl":
                  "https://encrypted-tbn0.gstatic.com/images%3Fq%3Dtbn%3AANd9GcSiBNMWYvpmCt1h1cajjZXjk-o_lv3e2NwtoA%26s"
            },
            {
              "id": "4ba1704a-998a-4063-80be-bfd63c24869a",
              "title": "Ayam goreng",
              "price": 38000,
              "description": "fried chicken with spicy granules",
              "ingredients":
                  "turmeric, water, garlic, salt, oil, Chicken, coriander, ",
              "imageUrl":
                  "https://www.astronauts.id/blog/wp-content/uploads/2023/04/Resep-Ayam-Goreng-Serundeng-ala-Rumahan-yang-Nggak-Kalah-Enak-dari-Restoran-1200x900.jpg"
            },
            {
              "id": "4ed19b4d-53b4-49f8-95ed-5a6bf1c0fef5",
              "title": "Dendeng balado",
              "price": 52000,
              "description": "thin crispy beef with chili",
              "ingredients":
                  "shallots, tomato, chilies, chili, garlic, tomatoes, salt, lime, oil, red chilies, Thin beef slices, lime leaves, ",
              "imageUrl":
                  "https://www.sasa.co.id/medias/page_medias/resep_dendeng_balado.jpg"
            },
            {
              "id": "6d340647-dad4-4c40-8134-c23cef70a1d7",
              "title": "Satay daging",
              "price": 45000,
              "description":
                  "dish of seasoned, skewered and grilled meat, served with a sauce",
              "ingredients":
                  "shallots, garlic, sweet soy sauce, Beef, skewers, ",
              "imageUrl":
                  "https://gerobaksate.my/serikembangan/wp-content/uploads/sites/32/2023/10/sate-daging-2.jpg"
            },
            {
              "id": "70baf4c8-6763-4955-ae77-97d2725c9dd0",
              "title": "Lado Ijo",
              "price": 15000,
              "description":
                  "a variant of green chili sambal with fried anchovies or shrimp",
              "ingredients":
                  "Shallots, Lime juice, Green chilies, chilies, tamarind, chili, Garlic, Sugar, Water, Lime juice or tamarind, Salt, Sugar (optional), ",
              "imageUrl":
                  "https://asset.kompas.com/crops/i8XPicsLEUrsaUTQpb62FK7kU_g%3D/0x0%3A1000x667/750x500/data/photo/2020/08/24/5f431f6307111.jpg"
            },
            {
              "id": "81111c4f-1778-4ea7-997c-6ac7e0ac2253",
              "title": "Ikan Panggang",
              "price": 60000,
              "description":
                  "Grilled fish marinated in traditional Padang spices and served with sambal.",
              "ingredients":
                  "Fish (snapper, shallots, chilies, turmeric, chili, garlic, or other), pepper., salt, mackerel, lime, red chilies, Fish, ",
              "imageUrl":
                  "https://img-global.cpcdn.com/recipes/7e5ace0001a81816/680x482cq70/ikan-bakar-khas-minang-foto-resep-utama.jpg"
            },
            {
              "id": "82139a64-8fb1-45df-b215-31e0c2e4ae5d",
              "title": "Ayam lado ijo",
              "price": 42000,
              "description": "chicken in green chili",
              "ingredients":
                  "shallots, chilies, chili, garlic, salt, lime, oil, Chicken, lime leaves, green chilies, ",
              "imageUrl":
                  "https://static.promediateknologi.id/crop/6x262%3A1075x1659/750x500/webp/photo/p1/1005/2024/01/28/Screenshot_20240128_195516_Instagram-3462551055.jpg"
            },
            {
              "id": "b7b01f69-e246-4fa8-b32e-d64388844c87",
              "title": "Kalio Daging",
              "price": 45000,
              "description":
                  "similar to rendang; while rendang is rather dry, kalio is watery and light-colored",
              "ingredients":
                  "coconut, shallots, chilies, turmeric, chili, garlic, Beef, coconut milk, lime, kaffir lime leaves, Beef (or other meat), lime leaves, lemongrass, ",
              "imageUrl":
                  "https://i.ytimg.com/vi/5yOqx_wRcLk/hq720.jpg%3Fsqp%3D-oaymwEhCK4FEIIDSFryq4qpAxMIARUAAAAAGAElAADIQj0AgKJD%26rs%3DAOn4CLDx9t5odrM5TA0JReDbmi7D-IqVCw"
            },
            {
              "id": "bd4434a5-4488-4d53-a477-9b542f5aec34",
              "title": "Gulai kepala ikan kakap merah",
              "price": 50000,
              "description": "red snapper's head gulai",
              "ingredients":
                  "coconut, chilies, turmeric, chili, garlic, salt, coconut milk, lime, kaffir lime leaves, Red snapper's head, lime leaves, lemongrass, ",
              "imageUrl":
                  "https://img-global.cpcdn.com/recipes/2d402f7844250193/1360x964cq70/gulai-kepala-ikan-kakap-merah-foto-resep-utama.webp"
            },
            {
              "id": "c2889a53-7a43-422e-8fc8-8b46975b3604",
              "title": "Pinyaram",
              "price": 14000,
              "description":
                  "traditional cake made from mixture of white sugar or palm sugar, white rice flour or black rice, and coconut milk",
              "ingredients":
                  "coconut, Rice Flour, Flour, palm sugar, sugar, coconut milk, Rice, ",
              "imageUrl":
                  "https://cdn.rri.co.id/berita/Bukittinggi/o/1716043146226-l-screenshot2020112205275120201122052841-1814139726/ylypodc2l1z9vsf.png"
            },
            {
              "id": "c80f5b33-16a8-4ead-8301-298f764a5187",
              "title": "Gulai babek",
              "price": 37000,
              "description":
                  "gulai babat, or gulai paruik kabau, gulai of cow tripes",
              "ingredients":
                  "coconut, shallots, chilies, turmeric, chili, garlic, salt, coconut milk, Cow tripe, lemongrass, ",
              "imageUrl":
                  "https://cdn.yummy.co.id/content-images/images/20210731/B6mbbnT8my7I95S8VOzmTgJFrDnQM0Ne-31363237373039383835d41d8cd98f00b204e9800998ecf8427e.jpg%3Fx-oss-process%3Dimage/resize%2Cw_388%2Ch_388%2Cm_fixed%2Cx-oss-process%3Dimage/format%2Cwebp"
            },
            {
              "id": "d180492c-c47b-4259-8e24-042a2ee22b99",
              "title": "Galamai",
              "price": 15000,
              "description":
                  "sweets made of rice flour, palm sugar and coconut milk, This snack similar to dodol",
              "ingredients":
                  "coconut, Rice Flour, Flour, palm sugar, sugar, coconut milk, Rice, ",
              "imageUrl":
                  "https://www.randangrajorajo.com/wp-content/uploads/2023/03/3328159348.webp"
            },
            {
              "id": "db9ae1f2-b556-4a8f-9fb4-effa914fc1eb",
              "title": "Ayam bakar",
              "price": 40000,
              "description": "grilled spicy chicken",
              "ingredients":
                  "shallots, turmeric, tamarind, chili, garlic, kecap manis (sweet soy sauce), salt, oil, Chicken, lemongrass, ",
              "imageUrl":
                  "https://www.sasa.co.id/medias/page_medias/ayam_bakar_lumajang.jpg"
            }
          ]
        }
      ]
    },
    {
      "title": "Bungus Teluk Kabung",
      "imageUrl":
          "https://upload.wikimedia.org/wikipedia/commons/thumb/3/3b/Lubuak_hitam.jpg/375px-Lubuak_hitam.jpg",
      "trivia":
          "Sebahagian besar areal perkebunan ini berdampingan dengan kawasan hutan lindung atau hutan negara serta hutan rakyat, yang masyarakat setempat menyebutnya tanah ulayat atau tanah adat.",
      "restaurantsInTheDistrict": []
    },
  ];

  bool isLoading = true;

  List<Map<String, dynamic>> allDistrict = [];

  List<Map<String, dynamic>> allRestaurant = [];

  late PageController _pageControllerStack;
  late PageController _pageController;
  final PageController _pageControllerDistrict =
      PageController(initialPage: 0, viewportFraction: 0.75);
  late List<Map<String, dynamic>> loopedCardData;
  late List<Map<String, dynamic>> loopedCardDataRestaurant;
  int currentPage = 0;
  final ScrollController _scrollController = ScrollController();
  bool _showAppBarTitle = false;
  @override
  void initState() {
    super.initState();

    fetchRestaurantData();
    fetchLocationData();
    _pageControllerStack = PageController();

    // Duplicate items to create a looped effect for Foods
    loopedCardData = [
      cardData.last,
      ...cardData,
      cardData.first,
    ];
    _pageController = PageController(initialPage: 2, viewportFraction: 0.85);
    _pageController.addListener(() {
      if (_pageController.page == loopedCardData.length - 1) {
        _pageController.jumpToPage(1);
      } else if (_pageController.page == 0) {
        _pageController.jumpToPage(loopedCardData.length - 2);
      }
    });

    // Duplicate items to create a looped effect for Restaurants

    _scrollController.addListener(() {
      if (_scrollController.offset > 500 && !_showAppBarTitle) {
        setState(() {
          _showAppBarTitle = true;
        });
      } else if (_scrollController.offset <= 500 && _showAppBarTitle) {
        setState(() {
          _showAppBarTitle = false;
        });
      }
    });
  }

  Future<void> fetchRestaurantData() async {
    await RestaurantService.fetchRestaurantData();

    final restaurants = RestaurantService.getRestaurantData();

    if (restaurants!.isNotEmpty) {
      setState(() {
        allRestaurant = restaurants;
        isLoading = false;
      });
    } else {
      print('Error: Restaurant data is null or not found');
    }
  }

  Future<void> fetchLocationData() async {
    await LocationService.fetchLocationData();

    final locations = LocationService.getLocationData();

    if (locations!.isNotEmpty) {
      setState(() {
        allDistrict = locations;
        isLoading = false;
      });
    } else {
      print('Error: Location data is null or not found');
    }
  }

  @override
  void dispose() {
    _pageControllerStack.removeListener(() {});
    _pageController.removeListener(() {});
    _pageControllerStack.dispose();
    _pageController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: CustomScrollView(controller: _scrollController, slivers: [
      SliverAppBar(
        expandedHeight: MediaQuery.of(context).size.height * 0.6,
        floating: false,
        pinned: true,
        title: _showAppBarTitle
            ? Text(
                "Restaurant",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              )
            : null,
        actions: [],
        flexibleSpace: FlexibleSpaceBar(
          background: Stack(
            children: [
              PageView.builder(
                onPageChanged: (int index) {
                  setState(() {
                    currentPage = index;
                  });
                },
                controller: _pageControllerStack,
                itemCount: stackData.length,
                itemBuilder: (context, index) {
                  final item = stackData[index];
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        PageRouteBuilder(
                          pageBuilder:
                              (context, animation, secondaryAnimation) =>
                                  RestaurantDetailsScreen(
                            restaurantAvailable:
                                widget.allRestaurant.sublist(0),
                            foodsInTheRestaurant: [],
                            item: item,
                            heroOrNot: false,
                            username: widget.username,
                          ),
                          transitionDuration: const Duration(
                              milliseconds: 300), // Optional for smoothness
                          transitionsBuilder:
                              (context, animation, secondaryAnimation, child) {
                            return FadeTransition(
                                opacity: animation, child: child);
                          },
                        ),
                      );
                    },
                    child: Stack(
                      children: [
                        Container(
                          width: double.infinity,
                          height: MediaQuery.of(context).size.height * 0.8,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: NetworkImage(item['imageUrl']!),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Positioned.fill(
                          child: Container(
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [
                                  Colors.black.withOpacity(0.50),
                                  Colors.transparent,
                                  Colors.black.withOpacity(0.8),
                                ],
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: 50,
                          left: 20,
                          right: 20,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(height: 10),
                              Align(
                                alignment: Alignment.center,
                                child: Text(
                                  item['title']!,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 48,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              Align(
                                alignment: Alignment.center,
                                child: Text(
                                  item['district'],
                                  textAlign: TextAlign.center,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 14,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
              Positioned(
                bottom:
                    20, // Adjust this value to control how far up the page the indicator appears
                left: 0,
                right: 0,
                child: Center(
                  child: SmoothPageIndicator(
                    controller: _pageControllerStack,
                    count: stackData.length,
                    effect: ExpandingDotsEffect(
                      dotHeight: 7,
                      dotWidth: 7,
                      activeDotColor: Colors.white,
                    ),
                  ),
                ),
              ),
              Positioned(
                top: 40,
                left: 20,
                child: AnimatedOpacity(
                  duration: Duration(milliseconds: 300),
                  opacity: _showAppBarTitle ? 0.0 : 1.0,
                  child: RichText(
                    text: const TextSpan(
                      style: TextStyle(
                        fontSize: 40,
                        fontWeight: FontWeight.bold,
                      ),
                      children: [
                        TextSpan(
                          text: 'Min',
                          style: TextStyle(
                              color: Color(0xffbb0000),
                              fontSize: 40), // Red color
                        ),
                        TextSpan(
                          text: 'eat',
                          style: TextStyle(
                              color: Color(0xffffd700),
                              fontSize: 40), // Gold color
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Positioned(
                top: 40,
                right: 20,
                child: AnimatedOpacity(
                  duration: Duration(milliseconds: 300),
                  opacity: _showAppBarTitle ? 0.0 : 1.0,
                  child: IconButton(
                    icon: Icon(
                      Icons.account_circle,
                      color: Colors.white,
                      size: 30,
                    ),
                    onPressed: () {
                      if (widget.isLoggedIn) {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ProfileScreen(
                                    username: widget.username,
                                  )),
                        );
                      } else {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => LoginScreen(
                                    username: widget.username,
                                    isLoggedIn: widget.isLoggedIn,
                                  )),
                        );
                      }
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      SliverList(
          delegate: SliverChildListDelegate([
        Padding(
          padding: const EdgeInsets.all(0),
          child: Column(
            children: [
              const SizedBox(height: 30),
              const Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Text(
                    "Top Picks",
                    style: TextStyle(fontSize: 23, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              TopPicksWidget(
                allRestaurant: allRestaurant,
                allFood: widget.allFood.sublist(widget.allFood.length - 5),
                pageController: _pageController,
                loopedCardData: loopedCardData,
                callerScreen: "restaurant",
                username: widget.username,
              ),
              const SizedBox(height: 45),
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        PageRouteBuilder(
                          pageBuilder:
                              (context, animation, secondaryAnimation) =>
                                  RestaurantAllScreen(
                            restaurantItems: allRestaurant,
                            username: widget.username,
                          ),
                          transitionDuration: const Duration(
                              milliseconds: 300), // Optional for smoothness
                          transitionsBuilder:
                              (context, animation, secondaryAnimation, child) {
                            return FadeTransition(
                                opacity: animation, child: child);
                          },
                        ),
                      );
                    },
                    child: const Row(
                      children: [
                        Text(
                          "All Restaurants",
                          style: TextStyle(
                              fontSize: 23, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Icon(
                          Icons.arrow_forward_ios,
                          size: 24,
                        ), // Replace with arrow_left for a left arrow
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 5),
              const SizedBox(height: 35),
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        PageRouteBuilder(
                          pageBuilder:
                              (context, animation, secondaryAnimation) =>
                                  DistrictAllScreen(
                            restaurantsInTheDistrict: widget.allRestaurant,
                            districtItems: allDistrict,
                            username: widget.username,
                          ),
                          transitionDuration: const Duration(
                              milliseconds: 300), // Optional for smoothness
                          transitionsBuilder:
                              (context, animation, secondaryAnimation, child) {
                            return FadeTransition(
                                opacity: animation, child: child);
                          },
                        ),
                      );
                    },
                    child: const Row(
                      children: [
                        Text(
                          "District",
                          style: TextStyle(
                              fontSize: 23, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Icon(
                          Icons.arrow_forward_ios,
                          size: 24,
                        ), // Replace with arrow_left for a left arrow
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 5),
              SizedBox(
                height: MediaQuery.of(context).size.width / 1.3,
                child: PageView.builder(
                  controller: _pageControllerDistrict,
                  itemCount: cardDataDistrict.length + 1,
                  itemBuilder: (context, index) {
                    if (index == cardDataDistrict.length) {
                      return SizedBox(
                        width: 50,
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => DistrictDetailsScreen(
                                    item: cardDataDistrict[index],
                                    restaurantsInTheDistrict:
                                        widget.allRestaurant,
                                    title: "All Districts",
                                    imageUrl: "",
                                    trivia: "",
                                    username: widget.username,
                                  ),
                                ),
                              );
                            },
                            child: Padding(
                              padding: const EdgeInsets.only(left: 8.0),
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    PageRouteBuilder(
                                      pageBuilder: (context, animation,
                                              secondaryAnimation) =>
                                          DistrictAllScreen(
                                        restaurantsInTheDistrict:
                                            widget.allRestaurant,
                                        districtItems: allDistrict,
                                        username: widget.username,
                                      ),
                                      transitionDuration: const Duration(
                                          milliseconds:
                                              300), // Optional for smoothness
                                      transitionsBuilder: (context, animation,
                                          secondaryAnimation, child) {
                                        return FadeTransition(
                                            opacity: animation, child: child);
                                      },
                                    ),
                                  );
                                },
                                child: Text(
                                  "Show all districts",
                                  style: TextStyle(
                                    fontSize: 20, // Adjust font size as needed
                                    fontWeight: FontWeight.bold,
                                    color: Colors
                                        .black, // Choose a color for the text
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    } else {
                      // Normal card display logic
                      final item = cardDataDistrict[index];
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            PageRouteBuilder(
                              pageBuilder:
                                  (context, animation, secondaryAnimation) =>
                                      DistrictDetailsScreen(
                                item: item,
                                restaurantsInTheDistrict: [],
                                title: item['title']!,
                                imageUrl: item['imageUrl']!,
                                trivia: item['trivia']!,
                                username: widget.username,
                              ),
                              transitionDuration:
                                  const Duration(milliseconds: 300),
                              transitionsBuilder: (context, animation,
                                  secondaryAnimation, child) {
                                return FadeTransition(
                                    opacity: animation, child: child);
                              },
                            ),
                          );
                        },
                        child: Container(
                          margin: const EdgeInsets.only(
                              bottom: 10, right: 16, top: 10),
                          decoration: BoxDecoration(
                            color: Colors.grey.shade200,
                            borderRadius: BorderRadius.circular(12),
                            boxShadow: [
                              BoxShadow(
                                blurRadius: 4,
                                color: Theme.of(context).shadowColor,
                                offset: const Offset(6, 6),
                              ),
                            ],
                          ),
                          child: Hero(
                            tag: item['title']!,
                            child: Material(
                              type: MaterialType.transparency,
                              child: Stack(
                                children: [
                                  // Image background
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(12),
                                    child: Image.network(
                                      item['imageUrl']!,
                                      fit: BoxFit.cover,
                                      width: double.infinity,
                                      height: double.infinity,
                                    ),
                                  ),
                                  // Gradient overlay
                                  Positioned.fill(
                                    child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(12),
                                        gradient: LinearGradient(
                                          colors: [
                                            Colors.transparent,
                                            Colors.transparent,
                                            Colors.black.withOpacity(0.6),
                                          ],
                                          begin: Alignment.topCenter,
                                          end: Alignment.bottomCenter,
                                        ),
                                      ),
                                    ),
                                  ),
                                  // Text overlay
                                  Align(
                                    alignment: Alignment.bottomLeft,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        item['title']!,
                                        style: const TextStyle(
                                          fontSize: 20,
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    }
                  },
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              // SizedBox(
              //   height: MediaQuery.of(context).size.width / 1.1,
              //   child: PageView.builder(
              //     controller: _pageControllerRestaurant,
              //     itemCount: loopedCardDataRestaurant.length,
              //     itemBuilder: (context, index) {
              //       final item = loopedCardDataRestaurant[index];
              //       return GestureDetector(
              //         onTap: () {
              //           Navigator.push(
              //             context,
              //             PageRouteBuilder(
              //               pageBuilder:
              //                   (context, animation, secondaryAnimation) =>
              //                       FoodDetailsScreen(
              //                 title: item['title']!,
              //                 imageUrl: item['imageUrl']!,
              //               ),
              //               transitionDuration: const Duration(
              //                   milliseconds: 300), // Optional for smoothness
              //               transitionsBuilder: (context, animation,
              //                   secondaryAnimation, child) {
              //                 return FadeTransition(
              //                     opacity: animation, child: child);
              //               },
              //             ),
              //           );
              //         },
              //         child: Container(
              //           margin: const EdgeInsets.only(
              //               bottom: 10, right: 16, top: 10),
              //           decoration: BoxDecoration(
              //             color: Colors.grey.shade200,
              //             borderRadius: BorderRadius.circular(12),
              //             boxShadow: [
              //               BoxShadow(
              //                 blurRadius: 4,
              //                 color: Colors.grey.shade300,
              //                 offset: const Offset(6, 6),
              //               ),
              //             ],
              //           ),
              //           child: Hero(
              //             tag: item['title']!,
              //             child: Stack(
              //               children: [
              //                 // Image background
              //                 ClipRRect(
              //                   borderRadius: BorderRadius.circular(12),
              //                   child: Image.network(
              //                     item['imageUrl']!,
              //                     fit: BoxFit.cover,
              //                     width: double.infinity,
              //                     height: double.infinity,
              //                   ),
              //                 ),
              //                 // Gradient overlay
              //                 Positioned.fill(
              //                   child: Container(
              //                     decoration: BoxDecoration(
              //                       borderRadius: BorderRadius.circular(12),
              //                       gradient: LinearGradient(
              //                         colors: [
              //                           Colors.transparent,
              //                           Colors.transparent,
              //                           Colors.black.withOpacity(0.6),
              //                         ],
              //                         begin: Alignment.topCenter,
              //                         end: Alignment.bottomCenter,
              //                       ),
              //                     ),
              //                   ),
              //                 ),
              //                 // Text overlay
              //                 Align(
              //                   alignment: Alignment.bottomLeft,
              //                   child: Padding(
              //                     padding: const EdgeInsets.all(8.0),
              //                     child: Text(
              //                       item['title']!,
              //                       style: const TextStyle(
              //                         fontSize: 20,
              //                         color: Colors.white,
              //                         fontWeight: FontWeight.bold,
              //                       ),
              //                     ),
              //                   ),
              //                 )
              //               ],
              //             ),
              //           ),
              //         ),
              //       );
              //     },
              //   ),
              // ),
            ],
          ),
        ),
      ]))
    ]));
  }
}
