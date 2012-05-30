Browser = require "zombie"
assert = require "assert"

#options = debug: true

browser = new Browser #options
browser.authenticate("test.ordergroove.com").basic("ordergroove", "t3stSt0r3")

browser.visit "http://test.ordergroove.com/index.php/beverages/folgers.html", (error, browser, status) ->
  console.log if error then error else "On the product page"
  assert.ok browser.success, "Failed to get the product page #{status}"

  assert.ok browser.evaluate("window.og_settings"), "Unable to find og_settings"

  browser.choose "input#og_deliver_on_68"
  browser.pressButton "button#add_to_cart", (error, browser, status) ->
    console.log if error then error else "On the cart page"
    assert.ok browser.success, "Failed to get the cart page #{status}"
