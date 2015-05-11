from flask import Flask
from flask import request
import os
from dogapi import dog_http_api as api

app = Flask(__name__)

api.api_key = os.environ.get('DD_API_KEY')

action_url = "/" + os.environ.get('BASE_URL') + "/"

@app.route(action_url, methods=['POST', 'GET'])
def mailgun_event():
    ts = request.form['timestamp']
    event_tag = "event_name:" + request.form['event']
    api.metric('mailgun.event', (ts, 1), tags=[event_tag], metric_type='counter')
    return "200"

@app.route("/", methods=['POST', 'GET'])
def root_route():
    return "200"

if __name__ == "__main__":
    port = int(os.environ.get("PORT", 5000))
    app.run(host='0.0.0.0', port=port)
