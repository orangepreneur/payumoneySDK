const functions = require("firebase-functions");
const sha512 = require("js-sha512");

const secret = {
  merchantKey: "",
  merchantSalt: "",
};

// URL will be like : https://us-central1-mukesh-joshi.cloudfunctions.net/payUMoney_CheckoutPro_Hash
//      here us-central1 is the server location
//      mukesh-joshi is the project ID
//      payUMoney_CheckoutPro_Hash is the function name

exports.payUMoney_CheckoutPro_Hash = functions.https.onRequest(
  (request, response) => {
    const hash = sha512(request.body["hash"] + secret.merchantSalt);
    functions.logger.info(
      "Requested String: " + request.body["hash"] + secret.merchantSalt,
      {
        structuredData: true,
      }
    );
    functions.logger.info("Hash : " + hash, { structuredData: true });
    response.send(hash);
  }
);
