
from flask import Flask, render_template, request, redirect
import mysql.connector
from config import DB_CONFIG

app = Flask(__name__)
conn = mysql.connector.connect(**DB_CONFIG)
cursor = conn.cursor(dictionary=True)

@app.route('/')
def home():
    return '''
    <h1>Bienvenido al sistema de Ferretería</h1>
    <a href="/registro_cliente">📋 Registrar Cliente</a><br>
    <a href="/registro_usuario">🧑‍💻 Registrar Usuario</a>
    '''


@app.route('/registro_cliente', methods=['GET', 'POST'])
def registro_cliente():
    if request.method == 'POST':
        nombre = request.form['nombre']
        apellido = request.form['apellido']
        cedula = request.form['cedula']
        correo = request.form['correo']
        telefono = request.form['telefono']
        direccion = request.form['direccion']
        cursor.execute("""
            INSERT INTO clientes (nombre, apellido, cedula, correo, telefono, direccion)
            VALUES (%s, %s, %s, %s, %s, %s)
        """, (nombre, apellido, cedula, correo, telefono, direccion))
        conn.commit()
        return redirect('/')
    return render_template('registro_cliente.html')

@app.route('/registro_usuario', methods=['GET', 'POST'])
def registro_usuario():
    if request.method == 'POST':
        usuario = request.form['usuario']
        contrasena = request.form['contrasena']
        rol_id = request.form['rol_id']
        cursor.execute("""
            INSERT INTO usuarios (usuario, contrasena, rol_id)
            VALUES (%s, %s, %s)
        """, (usuario, contrasena, rol_id))
        conn.commit()
        return redirect('/')
    return render_template('registro_usuario.html')

if __name__ == '__main__':
    app.run(debug=True)
