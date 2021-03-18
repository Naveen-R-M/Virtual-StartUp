from flask import Flask, jsonify, request
from flask_cors import CORS, cross_origin
import json

import sqlite3
import os

directory = os.path.dirname(os.path.abspath(__file__))

response = ''
permitted = 0
username = ''

app = Flask(__name__)
cors = CORS(app)

@app.route('/signUpCall', methods = ['GET','POST'])
@cross_origin()

def signUpCall():
    global response
    global permitted

    connection = sqlite3.connect(directory + '\signUpDetails.db')
    cursor = connection.cursor()

    selectQuery = "SELECT * FROM signUpDetails"
    result = cursor.execute(selectQuery)

    if(request.method == 'POST'):
        requestData = request.data
        requestData = json.loads(requestData.decode('utf-8'))

        username = requestData['username']
        email = requestData['email']
        password = requestData['password']
        phNo = requestData['phNo']

        response = f'Welocme {username}'

        for i in result:
            if(i[1]==email and i[2]==password):
                permitted = 0
            else:
                insertQuery = "INSERT INTO signUpDetails VALUES('{username}','{email}','{password}','{phNo}')".format(
                     username=username,
                     email=email,
                     password=password,
                     phNo=phNo
                    )
                cursor.execute(insertQuery)
                permitted = 1

    
        connection.commit()

        return ""
    else:
        return jsonify({
            'response': response,
            'permitted': permitted,
        })

@app.route('/signInCall', methods = ['GET','POST'])
@cross_origin()

def signInCall():
    global permitted
    global username

    connection = sqlite3.connect(directory + '\signUpDetails.db')
    cursor = connection.cursor()

    selectQuery = "SELECT * FROM signUpDetails"
    result = cursor.execute(selectQuery)

    if (request.method == 'POST'):
        requestData = request.data
        requestData = json.loads(requestData.decode('utf-8'))
        email = requestData['email']
        password = requestData['password']
        for i in result:
            if(i[1] == email and i[2] == password):
                permitted = 1
                username = i[0]
                break
            else:
                permitted = 0
        connection.commit()
        return ""


    else:
        return jsonify({
            'username': username,
            'permitted': permitted
        })


if __name__ == "__main__":
    app.run(debug=True)