from pymongo import MongoClient


def deleteBrooklynRestaurant():
    db.test.delete_one({"borough": "Brooklyn"})
    print("Deleted one Brooklyn restaurant")


def deleteThaiCuisines():
    db.test.delete_many({"cuisine": "Thai"})
    print("Deleted all Thai cuisines")


# support function for counting restaurants in a borough
def countRestaurantsInBorough(borough):
    return db.test.count_documents({"borough": borough})


# support function for counting restaurants with a cuisine
def countRestaurantsWithCuisine(cuisine):
    return db.test.count_documents({"cuisine": cuisine})


client = MongoClient("mongodb://localhost:27017/test")
db = client.test

print(countRestaurantsInBorough("Brooklyn"))
deleteBrooklynRestaurant()
print(countRestaurantsInBorough("Brooklyn"))

print(countRestaurantsWithCuisine("Thai"))
deleteThaiCuisines()
print(countRestaurantsWithCuisine("Thai"))
