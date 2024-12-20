function openRazorpayPayment(options, onSuccess, onFailure) {
    const rzp = new Razorpay(options);
    rzp.open();
    rzp.on('payment.success', function(response) {
        onSuccess(response);
    });

    rzp.on('payment.error', function(response) {
        onFailure(response);
    });
}