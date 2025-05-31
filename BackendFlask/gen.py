import os

with open("secret.env","w") as f:
    f.write(f"JWT_SECRET_KEY={os.urandom(32).hex()}")
    