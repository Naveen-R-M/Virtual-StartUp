import sqlite3
import os
import hashlib


currentDirectory = os.path.dirname(os.path.abspath(__file__))
connection = sqlite3.connect(currentDirectory + "\signUpDetails.db")
cursor = connection.cursor()

name = 'Naveen R M'
email = 'naveen.rm.551@gmail.com'
password = 'Naveen551$'
phNo = '7339332313'
ciphertext = (hashlib.sha256(password.encode()).hexdigest())
print((hashlib.sha256(password.encode())).hexdigest())
print(type(ciphertext))

selectQuery = "SELECT * FROM signUpDetails"
createQuery = "CREATE TABLE Users(username TEXT NOT NULL, email TEXT NOT NULL, password TEXT NOT NULL, phNo TEXT NOT NULL)"
insertQuery = "INSERT INTO signUpDetails VALUES('{name}','{email}','{ciphertext}','{phNo}')".format(
    name = name,
    email = email,
    ciphertext = ciphertext,
    phNo = phNo
)
result = cursor.execute(selectQuery)
connection.commit()

for i in result:
    print(i)
    print(i[2])
    print(ciphertext)
    if( (i[1] == email) and ( i[2] == ciphertext ) ):
        print('Yes')
        print(i)
        print(type(i))