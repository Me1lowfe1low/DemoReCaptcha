import subprocess
from flask import Flask, request

app = Flask(__name__)

@app.route('/post', methods=['POST'])
def handle_post():
    # Get the JSON data from the POST request
    data = request.json
    #print("Received POST request with data:", data)
    token = data.get('token')
    if token:
        # Call checkToken.py with the token as an argument
        subprocess.run(['python', 'CheckToken.py', token])
        return {'message': 'Token sent for validation'}, 200
    else:
        return {'error': 'Token not found in the request'}, 400

if __name__ == '__main__':
    app.run(host='localhost', port=5001)
