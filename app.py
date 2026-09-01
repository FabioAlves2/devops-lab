from flask import Flask, jsonify, request

app = Flask(__name__)

def soma(a,b):
    return a+b

@app.route('/')
def home():
    return 'Calculadora v2 - Deploy automatico via GitHub Actions!'

@app.route('/soma')
def soma_route():
    a = request.args.get('a', type=int, default=0)
    b = request.args.get('b', type=int, default=0)
    resultado = soma(a, b)
    return jsonify({"a": a, "b": b, "resultado": resultado})

@app.route('/health')
def health():
    return "OK", 200
    
if __name__ == "__main__":
    app.run(host="0.0.0.0", port=80)
