from flask import Flask, request

app = Flask(__name__)

@app.route("/", methods=["GET"])
def index():
  return ""

@app.route("/user/<id>", methods=["GET"])
def show_user(id):
  return id

@app.route("/user", methods=["POST"])
def echo_user():
  return request.data
