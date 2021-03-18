import sqlite3
import os

currentDirectory = os.path.dirname(os.path.abspath(__file__))
connection = sqlite3.connect(currentDirectory+'\SampleDb.db')
cursor = connection.cursor()

selectQuery = "SELECT * FROM SampleDb"
insertQuery = "INSERT INTO SampleDb VALUES('Naveen','naveen.rm.551@gmail.com',7339332313)"
result = cursor.execute(selectQuery)
connection.commit()
for i in result:
    if(i[0] == 'Naveen R M'):
        print(i[1])