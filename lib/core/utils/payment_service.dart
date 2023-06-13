// import 'dart:convert';
//
// import 'package:flutter/material.dart';
// import 'package:flutter_dotenv/flutter_dotenv.dart';
// import 'package:flutter_stripe/flutter_stripe.dart';
// import 'package:http/http.dart' as http;
// class PaymentService {
//   static createPaymentIntent(String amount, String currency) async {
//     try {
//       //Request body
//       Map<String, dynamic> body = {
//         'amount': calculateAmount(amount),
//         'currency': currency,
//       };
//
//       //Make post request to Stripe
//       var response = await http.post(
//         Uri.parse('https://api.stripe.com/v1/payment_intents'),
//         headers: {
//           'Authorization': 'Bearer ${dotenv.env['STRIPE_SECRET']}',
//           'Content-Type': 'application/x-www-form-urlencoded'
//         },
//         body: body,
//       );
//       return json.decode(response.body);
//     } catch (err) {
//       throw Exception(err.toString());
//     }
//   }
//
//   Future<void> makePayment() async {
//     try {
//       //STEP 1: Create Payment Intent
//       paymentIntent = await createPaymentIntent('100', 'NZD');
//
//       //STEP 2: Initialize Payment Sheet
//       await Stripe.instance
//           .initPaymentSheet(
//
//           paymentSheetParameters: SetupPaymentSheetParameters(
//               paymentIntentClientSecret: paymentIntent![
//               'client_secret'], //Gotten from payment intent
//               style: ThemeMode.light,
//               merchantDisplayName: 'Ikay'))
//           .then((value) {});
//
//       //STEP 3: Display Payment sheet
//       displayPaymentSheet();
//     } catch (err) {
//       throw Exception(err);
//     }
//   }
//
//   calculate(String amount){
//     return double.parse(amount)*100;
//   }
// }