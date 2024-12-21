function openRazorpayPayment(options, successCallback, failureCallback) {
  // Assuming Razorpay is already included in your project
  var rzp = new Razorpay(options);
  rzp.on('payment.success', function(response) {
    successCallback(response);
  });
  rzp.on('payment.error', function(response) {
    failureCallback(response);
  });
  rzp.open();
}