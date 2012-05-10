Browser = require "zombie"
assert = require "assert"

options =
  credentials:
    scheme: "basic"
    user: "ordergroove"
    password: "t3stSt0r3"
    site: "http://test.ordergroove.com"
  debug: true

browser = new Browser options
browser.visit "http://test.ordergroove.com/index.php/customer/account/login/", (error, browser, status) ->
  console.log if error then error else "On the Log In Page"
  assert.ok browser.success, "Failed to get log in page #{status}"

  browser.fill("login[username]", "david@ordergroove.com").
    fill("login[password]", "t2a5l5e4").
    pressButton "send", (error, browser, status) ->
      console.log if error then error else "Logged In"
      assert.ok browser.success, "Failed to log in #{status}"

      browser.visit "http://test.ordergroove.com/index.php/beverages/folgers.html", (error, browser, status) ->
        console.log if error then error else "On the product page"
        assert.ok browser.success, "Failed to get the product page #{status}"
        assert.ok browser.query("div#og_div"), "Unable to find og_div"
        assert.ok browser.evaluate("window.og_settings"), "Unable to find og_settings"

        console.log browser.html()

        browser.choose "delivery"
        browser.pressButton "fieldset.add-to-cart > button.button-3", (error, browser, status) ->
          console.log if error then error else "On the cart page"
          assert.ok browser.success, "Failed to get the cart page #{status}"
          console.log browser.html()

          browser.pressButton "button.button", (error, browser, status) ->
            console.log if error then error else "On the checkout page"
            assert.ok browser.success, "Failed to get the checkout page #{status}"

            console.log "TITLE !!!: #{browser.text('title')}"

            #            browser.choose("billing[use_for_shipping]").
            #              pressButton "button.button", (error, browser, status) ->
            #                browser.pressButton "button.button", (error, browser, status) ->
            #                  browser.choose("shipping_method").
            #                    browser.pressButton "button.button", (error, browser, status) ->
            #                      browser.fill("payment[cc_owner]", "David Newell").
            #                        select("payment[cc_type]", "VI").
            #                        fill("payment[cc_number", "4111 1111 1111 1111").
            #                        select("payment[cc_exp_month", "5").
            #                        select("payment[cc_exp_year", "2").
            #                        pressButton "button.button", (error, browser, status) ->
            #                          browser.pressButton "button.button", (error, browser, status) ->
            #                            console.log if error then error else "On the success page"
            #                            assert.ok browser.success, "Failed to get the success page #{status}"
            #
            #                            console.log browser.html()
