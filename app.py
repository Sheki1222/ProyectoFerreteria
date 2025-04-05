from flask import Flask, render_template

app = Flask(__name__)

@app.route('/')
def home():
    return render_template('home.html')

@app.route('/conocenos')
def conocenos():
    return render_template('conocenos.html')

@app.route('/productos')
def productos():
    return render_template('productos.html')

@app.route('/servicios')
def servicios():
    return render_template('servicios.html')

@app.route('/login')
def login():
    return render_template('login.html')

if __name__ == '__main__':
    app.run(debug=True)
