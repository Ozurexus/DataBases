from pymongo import MongoClient
import datetime


def insertRestaurant():
    db.test.insert_one({
        "address": {
            "street": "Sportivnaya",
            "zipcode": "420500",
            "building": "126",
            "coord": [40.7720266, -73.9557413]
        },
        "borough": "Innopolis",
        "cuisine": "Serbian",
        "name": "The Best Restaurant",
        "restaurant_id": "41712354",
        "grades": [
            {
                "date": datetime.datetime(2023, 4, 11),
                "grade": "A",
                "score": 11
            }
        ]
    })
    for restaurant in db.test.find({"restaurant_id": "41712354"}):
        print(restaurant)


client = MongoClient("mongodb://localhost:27017/test")
db = client.test
insertRestaurant()
