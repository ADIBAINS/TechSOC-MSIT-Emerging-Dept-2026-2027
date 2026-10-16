from bson import ObjectId
from flask import Flask, request, jsonify
from pymongo import MongoClient
from flask_cors import CORS
import urllib


app = Flask(__name__)
CORS(app)
# Connect to MongoDB
client = MongoClient('mongodb+srv://'+urllib.parse.quote("User") +':'+ urllib.parse.quote("Pass") +'@cluster0.h4dvb9i.mongodb.net/')
db = client['Cluster0'] # Database name
collection = db['todo'] # Collection name





@app.route('/add', methods=['GET'])
def add_todo():
   req = request.args['query']
   data = {'task': req}
   collection.insert_one(data)
   return jsonify({"message": "Todo added successfully!"}), 


@app.route('/todos', methods=['GET'])
def get_todos():
   tlist = []
   comptlist = []
   id = []
   compid = []
   todos = list(collection.find({'task': {'$exists': True}}))
   comptodos = list(collection.find({'comp_task': {'$exists': True}}))

   for i in comptodos:
         comptlist.append(i['comp_task'])
         compid.append(str(i['_id']))


   for i in todos:
      tlist.append(i['task'])
      id.append(str(i['_id']))

   dict = {'tasks': tlist, 'ids':id}

   print(dict)
   return jsonify(dict)

@app.route('/comptodos', methods=['GET'])
def get_comp_todos():

   comptlist = []
   compid = []

   comptodos = list(collection.find({'comp_task': {'$exists': True}}))

   for i in comptodos:
         comptlist.append(i['comp_task'])
         compid.append(str(i['_id']))




   dict = {'comptasks': comptlist, 'ids':compid}

   print(dict)
   return jsonify(dict)


@app.route('/delete', methods=['GET'])
def delete_todo():
   req = request.args['query']
   if not ObjectId.is_valid(req):
      return jsonify({"message": "Invalid todo ID"}), 

   result = collection.delete_one({"_id": ObjectId(req)})
   if result.deleted_count == 0:
      return jsonify({"message": "Todo not found"}), 

   return jsonify({"message": "Todo deleted successfully!"}), 

@app.route('/addcomp', methods=['GET'])
def add_todo_comp():
   req = request.args['query']
   data = {'comp_task': req}
   collection.insert_one(data)
   return jsonify({"message": "Todo completed successfully!"}), 



if __name__=="__main__":
    app.run(
        host="127.0.0.1",
    port=5000,
    debug=False,
    use_reloader=False
    )
