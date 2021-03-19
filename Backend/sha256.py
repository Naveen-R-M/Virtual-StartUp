import hashlib

string1 = "Naveen R M"
string2 = "Naveen R M"

result1 = hashlib.sha256(string1.encode())
result2 = hashlib.sha256(string2.encode())

print((hashlib.sha256(string1.encode())).hexdigest())
print(result2.hexdigest())