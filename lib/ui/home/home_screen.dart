import 'dart:convert';

import 'package:stripe_subscription_demo/constants/constants.dart';
import 'package:stripe_subscription_demo/utils/config_packages..dart';
import 'package:http/http.dart' as http;
import 'package:stripe_checkout/stripe_checkout.dart';

class HomeScreenUI extends StatefulWidget {
  const HomeScreenUI({super.key});

  @override
  State<HomeScreenUI> createState() => _HomeScreenUIState();
}

class _HomeScreenUIState extends State<HomeScreenUI> {
  String? subscriptionId;
  int? createdDate;
  int? expireDate;
  double? amount;
  String? status;
  String? name;
  String? email;
  String? customerId;
  Widget gap = const SizedBox(
    height: 10,
  );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<HomeController>(
          init: HomeController(),
          builder: (HomeController controller) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CommonCupertinoButton(
                    onTap: () async {
                      // StripePaymentService.instance.getSubscriptionProductsList();
                      //                  if (!await launchUrl(Uri.parse("https://buy.stripe.com/test_28o6pm1hh7Fg3dK4gh"),)) {
                      //   throw Exception('Could not launch https://buy.stripe.com/test_28o6pm1hh7Fg3dK4gh');
                      // }
                      // _openWebView();

                      var items = [
                        {
                          'productPrice': 20,
                          'productName': 'Basic',
                          'qty': '1'
                        },
                      ];

                      await stripePaymentCheckout(items, 5, context, mounted,
                          onSuccess: () {}, onCancel: () {
                        debugPrint('Cancel');
                      }, onError: (e) {
                        debugPrint('error :: ${e.toString()}');
                      });
                    },
                    child: Container(
                        height: 50,
                        width: 200,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            color: AppColors.black,
                            borderRadius: BorderRadius.circular(8.0)),
                        child: const TextWidget(
                          text: AppStrings.makePayment,
                          color: AppColors.white,
                          fontWeight: FontWeight.w600,
                          textize: AppSizes.text18,
                        )),
                  ),
                  gap,
                  TextWidget(text: "amount: $amount"),
                  gap,
                  TextWidget(text: "status: $status"),
                  gap,
                  if (createdDate != null)
                    TextWidget(
                        text:
                            "created: ${DateTime.fromMillisecondsSinceEpoch(createdDate! * 1000)}"),
                  gap,
                  if (expireDate != null)
                    TextWidget(
                        text:
                            "expired:$expireDate  ${DateTime.fromMillisecondsSinceEpoch(
                      expireDate! * 1000,
                    )}"),
                  gap,
                  TextWidget(text: "name: $name"),
                  gap,
                  TextWidget(text: "email: $email"),
                  gap,
                  TextWidget(text: "customerId: $customerId"),
                  gap,
                  CommonCupertinoButton(
                    onTap: () {
                      _cancelSubscription();
                    },
                    child: Container(
                        height: 50,
                        width: 200,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            color: AppColors.black,
                            borderRadius: BorderRadius.circular(8.0)),
                        child: const TextWidget(
                          text: "Cancel",
                          color: AppColors.white,
                          fontWeight: FontWeight.w600,
                          textize: AppSizes.text18,
                        )),
                  )
                ],
              ),
            );
          }),
    );
  }

  createCheckoutSession(List<dynamic> productItems) async {
    final url = Uri.parse("https://api.stripe.com/v1/checkout/sessions");
    String lineItems = "";
    int index = 0;
    productItems.forEach((val) {
      var productPrice = (val['productPrice'] * 100);
/*       lineItems +=
          "&line_items[$index][price_data][product_data][name]=${val['productName']}";
      lineItems += "&line_items[$index][price_data][unit_amount]=$productPrice";
      lineItems += "&line_items[$index][price_data][currency]=USD";
      lineItems += "&line_items[$index][quantity]=${val['qty'].toString()}"; */
      // lineItems += "&line_items[$index][name]='price_1Nt3ejIhqAVNscPw1PNz79P1'";
      lineItems += "&line_items[$index][price]=price_1O0hqfIhqAVNscPwbeIJouyV";
      // lineItems += "&line_items[$index][currency]=USD";
      lineItems += "&line_items[$index][quantity]=${val['qty'].toString()}";

      index++;
    });

    final Map<String, dynamic> requestBody = {
      "success_url": "https://your-website.com/success",
      "cancel_url": "https://your-website.com/cancel",
      "payment_method_types": jsonEncode(["card"]),
      "line_items": jsonEncode([
        {
          "price": "price_1Nt3ejIhqAVNscPw1PNz79P1",
          "quantity": "1",
        },
      ]),
      "mode": "payment",
    };

    final response = await http.post(url,
        body:
            // requestBody,
            'success_url=https://checkout.stripe.dev/success&mode=subscription$lineItems',
        headers: {
          'Authorization': 'Bearer $stripeSecretKey',
          'Content-Type': 'application/x-www-form-urlencoded'
        });
    debugPrint('response : ${response.body}');
    return json.decode(response.body)['id'];
  }

  stripePaymentCheckout(productItems, subTotal, context, mounted,
      {onSuccess, onCancel, onError}) async {
    final String sessionID = await createCheckoutSession(
      productItems,
    );

    final result = await redirectToCheckout(
        context: context,
        sessionId: sessionID,
        publishableKey: stripePublishKey,
        successUrl: "https://checkout.stripe.dev/success",
        canceledUrl: "https://checkout.stripe.dev/cancel");
    if (mounted) {
      final text = result.when(
          redirected: () => 'Redirected successfuly',
          success: () {
            onSuccess();
            getSessionData(sessionID);
            debugPrint('result : ${result.toString()}');
          },
          canceled: () => onCancel(),
          error: (error) => onError(error));
      return text;
    }
  }

  Future<void> getSessionData(String sessionID) async {
    final url = 'https://api.stripe.com/v1/checkout/sessions/$sessionID';
    final response = await http.get(
      Uri.parse(url),
      headers: {
        'Authorization': 'Bearer $stripeSecretKey',
      },
    );

    if (response.statusCode == 200) {
      final sessionData = jsonDecode(response.body);
      debugPrint('subscintion id: ${sessionData['subscription']}');
      subscriptionId = sessionData['subscription'];
      status = sessionData['payment_status'];
      expireDate = sessionData['expires_at'];
      createdDate = sessionData['created'];
      name = sessionData['customer_details']['name'];
      email = sessionData['customer_details']['email'];
      amount = sessionData['amount_subtotal'] / 100;
      customerId = sessionData['customer'];
      setState(() {});
    }
  }

  Future<void> _cancelSubscription() async {
    final url = 'https://api.stripe.com/v1/subscriptions/$subscriptionId';

    final response = await http.delete(
      Uri.parse(url),
      headers: {
        'Authorization': 'Bearer $stripeSecretKey',
      },
    );

    if (response.statusCode == 200) {
      debugPrint('cancel : ${response.body}');
    } else {
      debugPrint('error : ${response.body}');
    }
  }
}
