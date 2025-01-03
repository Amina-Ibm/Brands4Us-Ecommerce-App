import 'dart:convert';
import 'package:elo_clone/models/product.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class apiProductController extends GetxController{
  var products = [].obs;
  var categories = <String>[].obs;
  var loadingProducts = true.obs;
  var loadingCategories = true.obs;
  RxString selectedCategory = 'All'.obs;
  var userDetails = {}.obs;

  int? userId;


  void onInit() {
    super.onInit();
    fetchCategories();
    fetchProducts();
  }
  fetchCategories() async{
    loadingCategories(true);
    try {
      var response = await http.get(Uri.parse('https://fakestoreapi.com/products/categories'));
      if (response.statusCode == 200) {
        categories.value = List<String>.from(jsonDecode(response.body));
      } else {
        Get.snackbar('Error', 'Failed to fetch categories');
      }
    } catch (e) {
      Get.snackbar('Error', e.toString());
    } finally {
      loadingCategories(false);
    }
  }
  fetchProducts({String? category}) async {
    loadingProducts(true);
    try{
      print("connecting to api");
      String endpoint = category != null
          ? 'https://fakestoreapi.com/products/category/$category'
          : 'https://fakestoreapi.com/products';
      var response = await http.get(Uri.parse(endpoint));
      if (response.statusCode == 200) {
        print("response 200");
        var responseJson = jsonDecode(response.body) as List;
        products.value = responseJson.map(
                (product) => Product.fromJson(product)
        ).toList();
        print("products list populated");
      }
      else {
        Get.snackbar('Error', 'Failed to fetch products');
      }
    } catch (e) {
      Get.snackbar('Error', e.toString());
      print(e.toString());
    } finally {
      loadingProducts(false);
    }
  }
  Future<bool> loginUser(String username, String password) async {
    final url = Uri.parse('https://fakestoreapi.com/auth/login');
    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'username': username,
          'password': password,
        }),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        print('Login successful: $data');
        final prefs = await SharedPreferences.getInstance();
        prefs.setBool('isLoggedIn', true);
        prefs.setString('username', username);
        prefs.setString('password', password);
        getUserDetails(username, password);
        return true;
      } else {
        print('Login failed: ${response.statusCode}');
        Get.snackbar('Login Failed', '${response.body}');
        print('Response body: ${response.body}');
      }

    } catch (error) {
      print('Error occurred: $error');
    }
    return false;
  }
  Future<Map<dynamic, dynamic>?> getUserDetails(String username, String password) async {
    final url = Uri.parse('https://fakestoreapi.com/users');

    try {
      // Fetch all users
      final response = await http.get(url);

      if (response.statusCode == 200) {
        // Parse the response body
        final List users = jsonDecode(response.body);

        // Find the user with matching username and password
        final user = users.firstWhere(
              (user) => user['username'] == username && user['password'] == password,
          orElse: () => null, // Return null if no match is found
        );

        if (user != null) {
          print('User found: ${user['id']}');
          userId = user['id'];
          userDetails.value = {
            'id': user['id'],
            'firstname': user['name']['firstname'],
            'lastname': user['name']['lastname'],
          };
          print(userDetails);
          return userDetails;
          // Return the user ID
        } else {
          print('User not found');
          return null;
        }
      } else {
        print('Failed to fetch users: ${response.statusCode}');
        return null;
      }
    } catch (error) {
      print('Error occurred: $error');
      return null;
    }
  }
  Future<List<Map<String, dynamic>>> getUserCart(int userId) async {
    final url = Uri.parse('https://fakestoreapi.com/carts/user/$userId');

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final List carts = jsonDecode(response.body);

        print('User Cart: $carts');
        return List<Map<String, dynamic>>.from(carts);
      } else {
        print('Failed to fetch user cart: ${response.statusCode}');
        return [];
      }
    } catch (error) {
      print('Error occurred while fetching user cart: $error');
      return [];
    }
  }
}