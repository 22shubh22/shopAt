import 'package:bot_toast/bot_toast.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shopat/firebase_repository/auth.dart';
import 'package:shopat/firebase_repository/src/entities/product_entity.dart';
import 'package:shopat/firebase_repository/src/models/cart_item.dart';
import 'package:shopat/firebase_repository/src/models/wishlist_item.dart';

class FirestoreService {
  //firestore instance to user multiple times.
  FirebaseFirestore _instance = FirebaseFirestore.instance;

  getUserByPhone(String phoneNumber, String? uid) async {
    var s = await _instance.collection('customers').doc(phoneNumber).get();
    if (s.data() == null) {
      print("User with phone number $phoneNumber not exists. Signing him up");
      await _instance.collection('customers').doc(phoneNumber).set({
        'customerNumber': phoneNumber,
        'uid': uid,
        'address': "",
        'name': "",
        'email': "",
        'wishlist': [],
        'orders': [],
        'cart': [],
      });
    } else {
      print(
          "User with phone number $phoneNumber already exists. Just logging in");
    }
  }

  Future<List<ProductEntity>> getProductsList() async {
    List<ProductEntity> productsList = [];
    var products = await _instance.collection('products').get();

    for (var i in products.docs) {
      var data = i.data();
      if (i['quantityAvailable'] > 0 && i['status'] == "Accepted") {
        productsList.add(ProductEntity.fromJson(data));
      }
    }
    return productsList;
  }

  Future<bool> isItemWishListed(String pId) async {
    String phoneNumber = AuthService().getPhoneNumber() ?? "";
    var data = await _instance.collection('customers').doc(phoneNumber).get();
    List wishList = data.data()?['wishlist'];
    bool _isProductAdded = false;
    for (var i in wishList) {
      if (i['id'] == pId) {
        _isProductAdded = true;
        break;
      }
    }
    return _isProductAdded;
  }

  addProductToWishList(
    ProductEntity product,
  ) async {
    String phoneNumber = AuthService().getPhoneNumber() ?? "";
    var data = await _instance.collection('customers').doc(phoneNumber).get();

    List wishList = data.data()?['wishlist'];

    wishList.add({
      "id": product.id,
      "productName": product.productName,
      "shopId": product.shopId,
      "description1": product.description1,
      "description2": product.description2,
      "image": product.image,
      "costPrice": product.costPrice,
      "sellingPrice": product.sellingPrice,
      "quantityAvailable": product.quantityAvailable,
      "addedOn": DateTime.now().toString()
    });

    try {
      await _instance
          .collection('customers')
          .doc(phoneNumber)
          .update({'wishlist': wishList});

      print(" Item added to wishlist");

      BotToast.showText(text: "Item added to your wishlist");
    } catch (e) {
      print("error adding item to wishlist : $e");

      BotToast.showText(text: "Cannot add item to your wishlist right now.");
    }
  }

  removeProductToWishList(
    String productId,
  ) async {
    String phoneNumber = AuthService().getPhoneNumber() ?? "";
    var data = await _instance.collection('customers').doc(phoneNumber).get();

    List wishList = data.data()?['wishlist'];
    int? indexToRemove;
    for (var i in wishList) {
      if (i['id'] == productId) {
        indexToRemove = wishList.indexOf(i);
        break;
      }
    }
    if (indexToRemove != null) {
      wishList.removeAt(indexToRemove);
    }

    try {
      await _instance
          .collection('customers')
          .doc(phoneNumber)
          .update({'wishlist': wishList});

      print(" Item removed from wishlist");

      BotToast.showText(text: "Item removed from your wishlist");
    } catch (e) {
      print("error removing item from wishlist : $e");

      BotToast.showText(
          text: "Cannot remove item from your wishlist right now.");
    }
  }

  Future<List<WishListItem>> getUserWishList() async {
    String phoneNumber = AuthService().getPhoneNumber() ?? "";
    List<WishListItem> wishList = [];
    var user = await _instance.collection('customers').doc(phoneNumber).get();

    for (var i in user.data()?['wishlist']) {
      wishList.add(WishListItem.fromJson(i));
    }
    return wishList;
  }

  getProfileDetails() async {
    String phoneNumber = AuthService().getPhoneNumber() ?? "";
    var data = await _instance.collection('customers').doc(phoneNumber).get();
    String name = data.data()?['name'];
    String email = data.data()?['email'];
    String address = data.data()?['address'];
    return {
      'name': name,
      'email': email,
      'address': address,
    };
  }

  updateProfileDetails({
    required String name,
    required String email,
    required String address,
  }) async {
    String phoneNumber = AuthService().getPhoneNumber() ?? "";
    try {
      await _instance.collection('customers').doc(phoneNumber).update({
        'name': name,
        'email': email,
        'address': address,
      });
      print("Profile details updated");

      BotToast.showText(text: "Profile details updated");
    } catch (e) {
      print("error while updating profile : $e");

      BotToast.showText(text: "Cannot update your details");
    }
  }

  Future<bool> isItemAddedToCart(String pId) async {
    print("One");
    String phoneNumber = AuthService().getPhoneNumber() ?? "";
    var data = await _instance.collection('customers').doc(phoneNumber).get();
    List cartList = data.data()?['cart'];
    bool _isProductAdded = false;
    for (var i in cartList) {
      print("Two");
      if (i['id'] == pId) {
        _isProductAdded = true;
        break;
      }
    }
    return _isProductAdded;
  }

  addProductToCartList(
    ProductEntity product,
    int numberOfItems,
  ) async {
    String phoneNumber = AuthService().getPhoneNumber() ?? "";
    var data = await _instance.collection('customers').doc(phoneNumber).get();

    List cartList = data.data()?['cart'];

    cartList.add({
      "id": product.id,
      "productName": product.productName,
      "shopId": product.shopId,
      "description1": product.description1,
      "description2": product.description2,
      "image": product.image,
      "costPrice": product.costPrice,
      "sellingPrice": product.sellingPrice,
      "quantityAvailable": product.quantityAvailable,
      "addedOn": DateTime.now().toString(),
      "numberOfItems": numberOfItems,
      "shopNumber": product.shopNumber,
    });

    try {
      await _instance
          .collection('customers')
          .doc(phoneNumber)
          .update({'cart': cartList});

      print(" Item added to cart");

      BotToast.showText(text: "Item added to your cart");
      return {
        'res': true,
      };
    } catch (e) {
      print("error adding item to cart : $e");

      BotToast.showText(text: "Cannot add item to your cart right now.");
      return {
        'res': false,
      };
    }
  }

  removeItemFromCartList(
    String productId,
  ) async {
    String phoneNumber = AuthService().getPhoneNumber() ?? "";
    var data = await _instance.collection('customers').doc(phoneNumber).get();

    List cartList = data.data()?['cart'];
    int? indexToRemove;
    for (var i in cartList) {
      if (i['id'] == productId) {
        indexToRemove = cartList.indexOf(i);
        break;
      }
    }
    if (indexToRemove != null) {
      cartList.removeAt(indexToRemove);
    }

    try {
      await _instance
          .collection('customers')
          .doc(phoneNumber)
          .update({'cart': cartList});

      print(" Item removed from cart");

      BotToast.showText(text: "Item removed from your cart");
      return {
        'res': true,
      };
    } catch (e) {
      print("error removing item from cart : $e");

      BotToast.showText(text: "Cannot remove item from your cart right now.");
      return {
        'res': false,
      };
    }
  }

  Future<List<CartItem>> getUsercartList() async {
    String phoneNumber = AuthService().getPhoneNumber() ?? "";
    List<CartItem> cartList = [];
    var user = await _instance.collection('customers').doc(phoneNumber).get();

    for (var i in user.data()?['cart']) {
      cartList.add(CartItem.fromJson(i));
    }
    return cartList;
  }

  updateItemFromCartList(
    String productId,
    int numberOfItems,
  ) async {
    String phoneNumber = AuthService().getPhoneNumber() ?? "";
    var data = await _instance.collection('customers').doc(phoneNumber).get();

    List cartList = data.data()?['cart'];
    int? indexToUpdate;
    for (var i in cartList) {
      if (i['id'] == productId) {
        indexToUpdate = cartList.indexOf(i);
        break;
      }
    }
    if (indexToUpdate != null) {
      cartList.elementAt(indexToUpdate)['numberOfItems'] = numberOfItems;
    }

    try {
      await _instance
          .collection('customers')
          .doc(phoneNumber)
          .update({'cart': cartList});

      print("Item count updated in cart");

      BotToast.showText(text: "Item count updated in cart");
      return {
        'res': true,
      };
    } catch (e) {
      print("error updating item count in cart : $e");

      BotToast.showText(text: "Cannot update item in your cart right now.");
      return {
        'res': false,
      };
    }
  }

  addNewOrder(
    List<CartItem> cartItems,
    int totalBillAmount,
    int totalItems,
  ) async {
    String phoneNumber = AuthService().getPhoneNumber() ?? "";
    var data = await _instance.collection('customers').doc(phoneNumber).get();

    List orders = data.data()?['orders'];

    List serializedCart = [];
    var customerDetails = await getProfileDetails();

    Map<String, List> sellerProducts = {};

    for (var i in cartItems) {
      print("cart item : ${i.toJson()}");
      //Updating quantity available value
      var data = await _instance.collection('products').doc(i.id).get();
      int quantityAvailable = data.data()?['quantityAvailable'];
      await _instance.collection('products').doc(i.id).update({
        'quantityAvailable': quantityAvailable - i.numberOfItems,
      });
      serializedCart.add(i.toJson());

      //sort the list items based on seller.

      try {
        List sProducts = sellerProducts[i.shopNumber] ?? [];

        sProducts.add(
          i.toJson(),
        );
        sellerProducts[i.shopNumber] = sProducts;
      } catch (e) {
        print("error : $e");
      }
    }

    print("sprods: $sellerProducts");

    //should make a seller wise map
    /*
          {
            '<sellerNumber>' : {
               'productInfo': [
                               <cartItem sold by this seller>,
                                <cartItem sold by this seller>
                               ],
               'customerDetails': { 
                                     'name': name,
                                      'email': email,
                                      'address': address,
                                   },
               'createdAt': DateTime.now().toString(),
               'status': "Pending"
            },

            '<sellerNumber2>' : {
               'productInfo': [
                               <cartItem sold by this seller2>,
                                <cartItem sold by this seller2>
                               ],
               'customerDetails': { 
                                     'name': name,
                                      'email': email,
                                      'address': address,
                                   },
               'createdAt': DateTime.now().toString(),
               'status': "Pending"
            }

          }
       */

    // this variable holds the seller wise map that admin has access to.
    Map<String, dynamic> sellerWiseMap = {};

    for (var seller in sellerProducts.keys) {
      sellerWiseMap[seller] = {
        'productInfo': sellerProducts[seller],
        'customerDetails': customerDetails,
        'createdAt': DateTime.now().toString(),
        'status': "Pending"
      };
    }

    // store the og map in masterlist.
    var res = await _instance
        .collection('ordersMasterList')
        .add({'order': sellerWiseMap});

    // now store the id of the document from masterlist to individual seller's list.
    for (var seller in sellerProducts.keys) {
      var productsData =
          await _instance.collection('sellers').doc(seller).get();
      List productsRequested = productsData.data()?['productsRequested'];

      productsRequested.add(res.id);
      await _instance.collection('sellers').doc(seller).update({
        'productsRequested': productsRequested,
      });
    }

    orders.add({
      "cartItems": serializedCart,
      "totalBillAmount": totalBillAmount,
      "totalItems": totalItems,
      "createdAt": DateTime.now().toString(),
      "status": "Pending",
    });

    try {
      await _instance
          .collection('customers')
          .doc(phoneNumber)
          .update({'orders': orders});
      await _instance
          .collection('customers')
          .doc(phoneNumber)
          .update({'cart': []});

      print("Order placed succesfully");

      BotToast.showText(text: "Order placed succesfully");
      return {
        'res': true,
      };
    } catch (e) {
      print("error placing order : $e");

      BotToast.showText(text: "Cannot place order right now");
      return {
        'res': false,
      };
    }
  }

  clearCartList() async {
    String phoneNumber = AuthService().getPhoneNumber() ?? "";
    try {
      await _instance
          .collection('customers')
          .doc(phoneNumber)
          .update({'cart': []});
    } catch (e) {
      print("error placing order : $e");
    }
  }

  getUserOrders() async {
    String phoneNumber = AuthService().getPhoneNumber() ?? "";
    var user = await _instance.collection('customers').doc(phoneNumber).get();
    List<Map<String, dynamic>> ordersList = [];
    for (var i in user.data()?['orders']) {
      List<CartItem> cartItemsLocal = [];

      for (var j in i['cartItems']) {
        cartItemsLocal.add(CartItem.fromJson(j));
      }
      ordersList.add({
        "cartItems": cartItemsLocal,
        "totalBillAmount": i['totalBillAmount'],
        "totalItems": i['totalItems'],
        "createdAt": i['createdAt'],
        "status": i['status'],
      });
    }
    return ordersList;
  }
}
