http = require "http"

options = 
  host: "test.ordergroove.com"
  auth: "ordergroove:t3stSt0r3"
  path: "/index.php/customer/account/"
  method: 'POST'

logHeaders = (response) ->
  console.log "Status: #{response.statusCode}"
  console.log "Headers: #{JSON.stringify response.headers}"

parseCookie = (cookies, key) ->
  for cookie in cookies
    if cookie.indexOf(key) > -1
      return cookie.split(";")[0].substr(cookie.indexOf("=") + 1)
  false

login = http.request options, (response) ->
  logHeaders response
  options.method = "GET"
  options.path = "/index.php/sales/order/history/"
  account = http.request options, (response) ->
    logHeaders response
    response.on "data", (chunk) ->
      console.log "Body: #{data}"

  cookie = parseCookie response.headers["set-cookie"], "frontend"
  account.setHeader "Cookie", "frontend=#{cookie};"
  account.end()

login.write("login%5Busername%5D=david%40ordergroove.com&login%5Bpassword%5D=t2a5l5e4&send=")
login.end()
