import 'package:flutter/material.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

class RazorpayPayment extends StatefulWidget {
  @override
  _RazorpayPaymentState createState() => _RazorpayPaymentState();
}

class _RazorpayPaymentState extends State<RazorpayPayment> {
  late Razorpay _razorpay;

  @override
  void initState() {
    super.initState();
    _razorpay = Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, handleExternalWallet);
  }

  void handlePaymentSuccess(PaymentSuccessResponse response) {
    // Handle successful payment here
    print("Payment Success: ${response.paymentId}");
    // You can show a success dialog or navigate to another page
  }

  void handlePaymentError(PaymentFailureResponse response) {
    // Handle failed payment here
    print("Payment Error: ${response.code} - ${response.message}");
    // You can show an error dialog or retry option
  }

  void handleExternalWallet(ExternalWalletResponse response) {
    // Handle external wallet payment here
    print("External Wallet: ${response.walletName}");
  }

  void openCheckout() async {
    var options = {
      'key': 'rzp_test_ry9cS8x8J3XYbD', // Your Razorpay key
      'amount': calculateTotalAmount(), // Total amount in paise (e.g., ₹100 = 10000)
      'name': 'Your App Name',
      'description': 'Order Payment',
      'prefill': {
        'contact': '9999999999',
        'email': 'test@example.com'
      },
      'external': {
        'wallets': ['paypal']
      }
    };

    try {
      await _razorpay.open(options);
    } catch (e) {
      print(e.toString());
    }
  }

  int calculateTotalAmount() {
    // Implement your logic to calculate total amount based on user selections
    double total = 0;

    // Example calculation logic (replace with actual logic)
    for (var quantity in quantities.values) {
      total += quantity * pricePerItem; // Assuming pricePerItem is defined elsewhere
    }

    return total * 100; // Convert to paise
  }

  @override
  void dispose() {
    super.dispose();
    _razorpay.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Razorpay Payment'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            openCheckout();
          },
          child: Text('Proceed to Payment'),
        ),
      ),
    );
  }
}
