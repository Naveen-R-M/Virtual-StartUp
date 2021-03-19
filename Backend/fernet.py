from cryptography.fernet import Fernet 

class FERNET:
    def __init__(self, message):
        self.message = message
    def encrypt(self):
        key = Fernet.generate_key() 
        f = Fernet(key) 
        ciphertext = f.encrypt(bytes(self.message.encode('utf-8'))) 
        return ciphertext,f

    def decrypt(ciphertext,f):
        plaintext = f.decrypt(ciphertext) 
        return plaintext

encryptedMessage,f = FERNET('Hi').encrypt()
print(f)
print(str(f))
print(type(f))
print(encryptedMessage)
decryptedMessage = FERNET.decrypt(encryptedMessage,f)
print(decryptedMessage)