// This is your test secret API key.
const stripe = Stripe("pk_test_51RTfowRJb4FW218q2l48ulxLUVmwiQ3P4M5JKomL2S6HdArfJBWB5jSWvYhKTrsqEn01rzNCChBfHACkxBE1A1DE00mqptI57K");

initialize();

// Create a Checkout Session
async function initialize() {
  const fetchClientSecret = async () => {
    const response = await fetch("/create-checkout-session", {
      method: "POST",
    });
    const { clientSecret } = await response.json();
    return clientSecret;
  };

  const checkout = await stripe.initEmbeddedCheckout({
    fetchClientSecret,
  });

  // Mount Checkout
  checkout.mount('#checkout');
}