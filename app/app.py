from prometheus_flask_exporter import PrometheusMetrics
from flask import Flask, render_template

app = Flask(__name__, static_url_path='/static')  # Explicitly define static folder
metrics = PrometheusMetrics(app)  # Exposes `/metrics`

@app.route('/')
def home():
    return render_template("home.html")

@app.route('/status')
def status():
    return render_template("status.html", status="✅ App is running smoothly on Kubernetes.")

if __name__ == "__main__":
    app.run(host='0.0.0.0', port=5000, debug=True)
