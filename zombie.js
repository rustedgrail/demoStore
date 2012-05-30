// Generated by CoffeeScript 1.3.1
(function() {
  var Browser, assert, browser;

  Browser = require("zombie");

  assert = require("assert");

  browser = new Browser;

  browser.authenticate("test.ordergroove.com").basic("ordergroove", "t3stSt0r3");

  browser.visit("http://test.ordergroove.com/index.php/beverages/folgers.html", function(error, browser, status) {
    console.log(error ? error : "On the product page");
    assert.ok(browser.success, "Failed to get the product page " + status);
    assert.ok(browser.evaluate("window.og_settings"), "Unable to find og_settings");
    browser.choose("input#og_deliver_on_68");
    return browser.pressButton("button#add_to_cart", function(error, browser, status) {
      console.log(error ? error : "On the cart page");
      return assert.ok(browser.success, "Failed to get the cart page " + status);
    });
  });

}).call(this);
