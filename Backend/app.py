from flask import Flask, jsonify, request
from flask_cors import CORS, cross_origin
import json

import sqlite3
import os

import hashlib

directory = os.path.dirname(os.path.abspath(__file__))

response = ''
permitted = 0
username = ''
ciphertext = ''

app = Flask(__name__)
cors = CORS(app)

@app.route('/signUpCall', methods = ['GET','POST'])
@cross_origin()

def signUpCall():
    global response
    global permitted
    global ciphertext

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

        ciphertext = (hashlib.sha256(password.encode())).hexdigest()

        response = f'Welocme {username}'

        for i in result:
            if(i[1]==email and (hashlib.sha256(i[2].encode())).hexdigest() == ciphertext):
                permitted = 0
            else:
                insertQuery = "INSERT INTO signUpDetails VALUES('{username}','{email}','{ciphertext}','{phNo}')".format(
                     username=username,
                     email=email,
                     ciphertext= ciphertext,
                     phNo=phNo,
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

        ciphertext = (hashlib.sha256(password.encode())).hexdigest()
        
        for i in result:
            if((i[1] == email) and (i[2] == ciphertext)):
                permitted = 1
                username = i[0]
                print('verified--------------------')
                break
            else:
                print('not verified----------------')
                permitted = 0
        connection.commit()
        return ""


    else:
        return jsonify({
            'username': username,
            'permitted': permitted
        })

@app.route('/createOrganizationCall', methods = ['GET','POST'])
@cross_origin()

def createOrganizationCall():

    global response

    dbName = r'\employerOrganization'
    connection = sqlite3.connect(directory + dbName)
    cursor = connection.cursor()
    
    if(request.method == 'POST'):
        requestData = request.data
        requestData = json.loads(requestData.decode('utf-8'))

        user = requestData['user']
        organizationName = requestData['organizationName']
        ideaSynopsis = requestData['ideaSynopsis']
        base64File = requestData['base64File']

        insertQuery = "INSERT INTO EmployerOrganization VALUES('{user}','{organizationName}','{ideaSynopsis}','{base64File}')".format(
                user = user,
                organizationName = organizationName,
                ideaSynopsis = ideaSynopsis,
                base64File = base64File
            )
        cursor.execute(insertQuery)
    
        connection.commit()

        response = 'File Added Successfully'

        return ""
    else:
        return jsonify({
            'response': response,
        })

if __name__ == "__main__":
    app.run(debug=True)


