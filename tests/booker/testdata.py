url = "https://restful-booker.herokuapp.com"
headers = {'Content-Type': 'application/json'}
auth = {'username': 'admin', 'password': 'password123'}
booking = {
    "firstname" : "Jim",
    "lastname" : "Brown",
    "totalprice" : 111,
    "depositpaid" : True,
    "bookingdates" : {
        "checkin" : "2018-01-01",
        "checkout" : "2019-01-01"
    },
    "additionalneeds" : "Breakfast"
}