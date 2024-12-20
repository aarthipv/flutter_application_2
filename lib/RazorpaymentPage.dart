import 'package:flutter/material.dart';
import 'package:flutter_application_2/main.dart';
import 'dart:js' as js;
import 'dart:js_util' as js_util;

class RazorpayPaymentPage extends StatefulWidget {
  final CartState cartState;

  RazorpayPaymentPage({required this.cartState});

  @override
  _RazorpayPaymentPageState createState() => _RazorpayPaymentPageState();
}

class _RazorpayPaymentPageState extends State<RazorpayPaymentPage> {
  void openCheckout() {
    var options = js.JsObject.jsify({
      'key': 'rzp_test_ry9cS8x8J3XYbD',
      'amount': widget.cartState.total * 100,
      'name': 'StudVery',
      'description': 'Payment for your cart',
      'prefill': {
        'contact': '1234567890',
        'email': 'test@example.com'
      },
      'theme': {
        'color': '#F37254'
      }
    });

    try {
      js.context.callMethod('openRazorpayPayment', [
        options,
        js.allowInterop((response) {
          // Handle success
          print('Payment successful: $response');
        }),
        js.allowInterop((response) {
          // Handle failure
          print('Payment failed: $response');
        })
      ]);
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Razorpay Payment'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: openCheckout,
          child: Text('Pay Now'),
        ),
      ),
    );
  }
}