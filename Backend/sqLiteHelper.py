import sqlite3
import os

directory = None

class SqliteHelper:

    def __init__(self, dbName, tableName):
        global direcotry
        direcotry = os.path.dirname(os.path.abspath(__file__))
        self.tableName = tableName
        self.dbName = dbName

    def connect(self):
        connection = sqlite3.connect(directory + '\signUpDetails.db')
        cursor = connection.cursor()
        return cursor,connection
    
    def selectAllQuery(self, cursor):
        query = f"SELECT * FROM {self.tableName}"
        cursor.execute(query)
