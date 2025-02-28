from prometheus_flask_exporter import PrometheusMetrics
from flask import Flask

app = Flask(__name__)
metrics = PrometheusMetrics(app)  # This exposes `/metrics` endpoint

@app.route('/')
def home():
    return "Hello, Welcome to my App!"

@app.route('/status')
def status():
    return "✅ App is running smoothly on Kubernetes."

if __name__ == "__main__":
    app.run(host='0.0.0.0', port=5000, debug=True)
