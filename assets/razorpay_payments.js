

console.log("razorpay_payments.js loaded");

function openRazorpayPayment(options, successCallback, failureCallback) {
  console.log("openRazorpayPayment called with options:", options);
  var rzp = new Razorpay(options);
  rzp.on('payment.success', function (response) {
    console.log("Payment successful:", response);
    successCallback(response);
  });
  rzp.on('payment.error', function (response) {
    console.log("Payment failed:", response);
    failureCallback(response);
  });
  rzp.open();
}