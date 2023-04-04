from pymongo import MongoClient


def queryRestaurants():
    for restaurant in db.test.find({"address.street": "Prospect Park West"}):
        i = 0
        for grade in restaurant["grades"]:
            if grade["grade"] == "A":
                i += 1
        if i > 1:
            db.test.delete_one({"_id": restaurant["_id"]})
            print("Deleted a restaurant with more than one A grade")
        else:
            db.test.update_one({"_id": restaurant["_id"]}, {"$push": {"grades": {
                               "date": "2023-04-11", "grade": "A", "score": 11}}})
            print("Added another A grade to a restaurant")


client = MongoClient("mongodb://localhost:27017/test")
db = client.test
queryRestaurants()
