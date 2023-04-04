from pymongo import MongoClient


def queryIrishCuisines():
    print("Query all Irish cuisines")
    for restaurant in db.test.find({"cuisine": "Irish"}):
        print(restaurant)


def queryIrishAndRussianCuisines():
    print("Query all Irish and Russian cuisines")
    for restaurant in db.test.find({"$or": [{"cuisine": "Irish"}, {"cuisine": "Russian"}]}):
        print(restaurant)


def findRestaurant():
    for restaurant in db.test.find({"$and": [{"address.street": "Prospect Park West"}, {"address.zipcode": "11215"}, {"address.building": "284"}]}):
        print(restaurant)


client = MongoClient("mongodb://localhost:27017/test")
db = client.test
queryIrishCuisines()
queryIrishAndRussianCuisines()
findRestaurant()
