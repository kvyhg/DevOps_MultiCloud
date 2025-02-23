from flask import Flask

app = Flask(__name__)

@app.route('/')
def home():
    return "Hello, Welcome to my App!"

@app.route('/status')
def status():
    return "✅ App is running smoothly on Kubernetes."

if __name__ == "__main__":
    app.run(host='0.0.0.0', port=5000)
