// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require bootstrap-sprockets
//= require_tree .

function executeQuery() {
  $.ajax({
    url: '/packages',
    success: function(data) {
      $('#current-price').load('/packages #current-price')
    }
  });
  setTimeout(executeQuery, 5000);
}

$(document).ready(function() {
  setTimeout(executeQuery, 5000);
});


$(document).ready(function() {
    bitcoinaddress.init({

        // jQuery selector defining bitcon addresses on the page
        // needing the boost
        selector: ".bitcoin-address",

        // Id of the DOM template element we use to decorate the addresses.
        // This must contain placefolder .bitcoin-address
        template: "bitcoin-address-template",

        // Passed directly to QRCode.js
        // https://github.com/davidshimjs/qrcodejs
        qr : {
            width: 128,
            height: 128,
            colorDark : "#000000",
            colorLight : "#ffffff"
        },

        // By default the generated QR code is bitcoin:// URL.
        // However you might want to change this for altcoins, which do not have
        // official protocol handlers. Set true to remove bitcoin:// from
        // QR code.
        qrRawAddress: false
    });
});

$(document).ready(function() {
    bitcoinprices.init({

        // Where we get bitcoinaverage data
        url: "https://api.bitcoinaverage.com/ticker/all",

        // Which of bitcoinaverages value we use to present prices
        marketRateVariable: "24h_avg",

        // Which currencies are in shown to the user
        currencies: ["BTC", "USD", "EUR", "CNY"],

        // Special currency symbol artwork
        symbols: {
            "BTC": "<i class='fa fa-btc'></i>"
        },

        // Which currency we show user by the default if
        // no currency is selected
        defaultCurrency: "EUR",

        // How the user is able to interact with the prices
        ux : {
            // Make everything with data-btc-price HTML attribute clickable
            clickPrices : true,

            // Build Bootstrap dropdown menu for currency switching
            menu : true,

            // Allow user to cycle through currency choices in currency:

            clickableCurrencySymbol:  true
        },

        // Allows passing the explicit jQuery version to bitcoinprices.
        // This is useful if you are using modular javascript (AMD/UMD/require()),
        // but for most normal usage you don't need this
        jQuery: jQuery,

        // Price source data attribute
        priceAttribute: "data-price-eur",

        // Price source currency for data-btc-price attribute.
        // E.g. if your shop prices are in USD
        // but converted to BTC when you do Bitcoin
        // checkout, put USD here.
        priceOrignalCurrency: "EUR"

    });
});
