from Crypto.Cipher import AES
from secrets import token_bytes
import base64

class Aes:
    def __init__(self):
        self.key = token_bytes(16)

    def encrypt(self, message):
        cipher = AES.new(self.key, AES.MODE_EAX)
        nonce = cipher.nonce
        ciphertext, tag = cipher.encrypt_and_digest(message.encode('ascii'))
        return nonce, ciphertext, tag

    def decrypt(self, nonce, ciphertext, tag):
        cipher = AES.new(self.key, AES.MODE_EAX, nonce=nonce)
        plaintext = cipher.decrypt(ciphertext)
        try:
            cipher.verify(tag)
            return plaintext.decode('ascii')
        except:
            return False

aes = Aes()
nonce, ciphertext, tag = aes.encrypt("Hello Naveen..")
plaintext = aes.decrypt(nonce=nonce, ciphertext=ciphertext, tag=tag)
print('cipher',ciphertext)
print(f'cipher text {ciphertext}')
print(f'b64 : {str(base64.b64encode(ciphertext))}')
if not plaintext:
    print('Corrupted')
else:
    print(f'plain text {plaintext}')